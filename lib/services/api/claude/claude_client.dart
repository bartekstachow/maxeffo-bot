import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maxeffo_bot/services/api/claude/tavily_client.dart';

class ClaudeResponse {
  final String text;
  final int inputTokens;
  final int outputTokens;

  const ClaudeResponse({
    required this.text,
    required this.inputTokens,
    required this.outputTokens,
  });

  int get totalTokens => inputTokens + outputTokens;

  /// Estimated cost in USD.
  /// claude-sonnet-4-6: $3.00 / 1M input tokens, $15.00 / 1M output tokens.
  double get estimatedCostUsd =>
      (inputTokens * 3.00 + outputTokens * 15.00) / 1000000;
}

class ClaudeClient {
  static const _apiUrl = 'https://api.anthropic.com/v1/messages';
  static const _apiVersion = '2023-06-01';
  static const _model = 'claude-sonnet-4-6';
  static const _maxTokens = 512;

  static const _systemPrompt = '''
Jesteś Dik — botem gildii MaximumEffort, gildii World of Warcraft na serwerze Draenor-EU.
Jesteś bystry, lekko sarkastyczny i doskonale znasz kulturę oraz memy WoW-a.
Pomagasz członkom gildii w pytaniach, bierzesz udział w przekomarzaniu się i dbasz o rozrywkę.
Celuj w 1–3 zdania, chyba że ktoś wyraźnie poprosi o więcej szczegółów.
''';

  static const _webSearchTool = {
    'name': 'web_search',
    'description':
        'Przeszukuje internet w poszukiwaniu aktualnych informacji. '
        'Używaj głównie do pytań o World of Warcraft: patche, itemy, questline, mechaniki, '
        'rankingi, poradniki, aktualności. Nie używaj do zwykłej rozmowy.',
    'input_schema': {
      'type': 'object',
      'properties': {
        'query': {
          'type': 'string',
          'description': 'Zapytanie wyszukiwania po angielsku (WoW queries work best in English)',
        },
      },
      'required': ['query'],
    },
  };

  final String _apiKey;
  final TavilyClient? _searchService;

  ClaudeClient({required String apiKey, TavilyClient? searchService})
      : _apiKey = apiKey,
        _searchService = searchService;

  /// Standard single-turn reply — no search.
  Future<ClaudeResponse> reply({
    required String userMessage,
    String? referencedMessage,
    String? referencedAuthor,
    String? systemPrompt,
    int? maxTokens,
  }) async {
    final prompt = _buildPrompt(userMessage, referencedMessage, referencedAuthor);
    if (prompt.trim().isEmpty) {
      return const ClaudeResponse(text: '...tak?', inputTokens: 0, outputTokens: 0);
    }

    final data = await _callApi(
      messages: [
        {'role': 'user', 'content': prompt},
      ],
      systemPrompt: systemPrompt ?? _systemPrompt,
      maxTokens: maxTokens ?? _maxTokens,
    );

    final stopReason = data['stop_reason'] as String?;
    if (stopReason == 'max_tokens') {
      print('[Claude] Warning: odpowiedź ucięta — osiągnięto limit tokenów (${maxTokens ?? _maxTokens})');
    }

    final content = (data['content'] as List).first as Map<String, dynamic>;
    final usage = data['usage'] as Map<String, dynamic>;
    return ClaudeResponse(
      text: content['text'] as String,
      inputTokens: usage['input_tokens'] as int,
      outputTokens: usage['output_tokens'] as int,
    );
  }

  /// Multi-turn reply with web search tool use.
  /// If no TavilyClient is configured, falls back to regular reply().
  Future<ClaudeResponse> replyWithSearch({
    required String userMessage,
    String? referencedMessage,
    String? referencedAuthor,
    String? systemPrompt,
  }) async {
    if (_searchService == null) {
      return reply(
        userMessage: userMessage,
        referencedMessage: referencedMessage,
        referencedAuthor: referencedAuthor,
        systemPrompt: systemPrompt,
      );
    }

    final prompt = _buildPrompt(userMessage, referencedMessage, referencedAuthor);
    if (prompt.trim().isEmpty) {
      return const ClaudeResponse(text: '...tak?', inputTokens: 0, outputTokens: 0);
    }

    final messages = <Map<String, dynamic>>[
      {'role': 'user', 'content': prompt},
    ];

    int totalInputTokens = 0;
    int totalOutputTokens = 0;

    while (true) {
      final data = await _callApi(
        messages: messages,
        systemPrompt: systemPrompt ?? _systemPrompt,
        maxTokens: _maxTokens,
        tools: [_webSearchTool],
      );

      final usage = data['usage'] as Map<String, dynamic>;
      totalInputTokens += usage['input_tokens'] as int;
      totalOutputTokens += usage['output_tokens'] as int;

      final stopReason = data['stop_reason'] as String?;
      final contentBlocks = data['content'] as List<dynamic>;

      if (stopReason == 'end_turn') {
        final text = contentBlocks
            .whereType<Map>()
            .where((b) => b['type'] == 'text')
            .map((b) => b['text'] as String)
            .join('\n')
            .trim();
        return ClaudeResponse(
          text: text.isEmpty ? '...' : text,
          inputTokens: totalInputTokens,
          outputTokens: totalOutputTokens,
        );
      }

      if (stopReason == 'tool_use') {
        // Append assistant turn to conversation
        messages.add({'role': 'assistant', 'content': contentBlocks});

        // Execute each tool call and collect results
        final toolResults = <Map<String, dynamic>>[];
        for (final block in contentBlocks) {
          final b = block as Map<String, dynamic>;
          if (b['type'] != 'tool_use') continue;

          final toolUseId = b['id'] as String;
          final input = b['input'] as Map<String, dynamic>;
          final query = input['query'] as String;

          String resultContent;
          try {
            resultContent = await _searchService.search(query);
          } catch (e) {
            resultContent = 'Błąd wyszukiwania: $e';
            print('[Claude] Search error: $e');
          }

          toolResults.add({
            'type': 'tool_result',
            'tool_use_id': toolUseId,
            'content': resultContent,
          });
        }

        messages.add({'role': 'user', 'content': toolResults});
        continue;
      }

      // Unexpected stop reason — return whatever text we have
      final text = contentBlocks
          .whereType<Map>()
          .where((b) => b['type'] == 'text')
          .map((b) => b['text'] as String)
          .join('\n')
          .trim();
      return ClaudeResponse(
        text: text.isEmpty ? '...' : text,
        inputTokens: totalInputTokens,
        outputTokens: totalOutputTokens,
      );
    }
  }

  Future<Map<String, dynamic>> _callApi({
    required List<Map<String, dynamic>> messages,
    required String systemPrompt,
    required int maxTokens,
    List<Map<String, dynamic>>? tools,
  }) async {
    final body = <String, dynamic>{
      'model': _model,
      'max_tokens': maxTokens,
      'system': systemPrompt,
      'messages': messages,
    };
    if (tools != null && tools.isNotEmpty) {
      body['tools'] = tools;
    }

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'x-api-key': _apiKey,
        'anthropic-version': _apiVersion,
        'content-type': 'application/json',
      },
      body: json.encode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('[Claude] API error (${response.statusCode}): ${response.body}');
    }

    return json.decode(response.body) as Map<String, dynamic>;
  }

  String _buildPrompt(
      String userMessage, String? referencedMessage, String? referencedAuthor) {
    final parts = <String>[];
    if (referencedMessage != null && referencedAuthor != null) {
      parts.add('[Odpowiedź do $referencedAuthor: "$referencedMessage"]');
    }
    if (userMessage.isNotEmpty) parts.add(userMessage);
    return parts.join('\n');
  }
}