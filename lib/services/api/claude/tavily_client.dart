import 'dart:convert';
import 'package:http/http.dart' as http;

class TavilyClient {
  static const _apiUrl = 'https://api.tavily.com/search';

  // WoW-relevant domains get prioritised in results
  static const _includeDomains = [
    'wowhead.com',
    'wowpedia.fandom.com',
    'worldofwarcraft.com',
    'eu.battle.net',
    'us.battle.net',
    'raider.io',
    'warcraftlogs.com',
  ];

  final String _apiKey;

  TavilyClient({required String apiKey}) : _apiKey = apiKey;

  /// Returns a plain-text summary of top search results for Claude to read.
  Future<String> search(String query) async {
    print('[Search] Querying: "$query"');

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {'content-type': 'application/json'},
      body: json.encode({
        'api_key': _apiKey,
        'query': query,
        'search_depth': 'basic',
        'max_results': 3,
        'include_domains': _includeDomains,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Search API error (${response.statusCode}): ${response.body}');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    final results = (data['results'] as List<dynamic>?) ?? [];

    if (results.isEmpty) return 'Brak wyników wyszukiwania dla: "$query"';

    print('[Search] Got ${results.length} result(s).');
    return results.map((r) {
      final result = r as Map<String, dynamic>;
      final title = result['title'] ?? '';
      final url = result['url'] ?? '';
      final content = result['content'] ?? '';
      return '### $title\n$url\n$content';
    }).join('\n\n---\n\n');
  }
}