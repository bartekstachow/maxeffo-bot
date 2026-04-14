import 'dart:convert';

import 'package:nyxx/nyxx.dart';
import 'package:maxeffo_bot/services/api/claude/claude_client.dart';
import 'package:maxeffo_bot/services/usage_logger.dart';
import 'package:maxeffo_bot/services/guild_repository.dart';
import 'package:maxeffo_bot/services/guild_context_repository.dart';

class MentionCommand {
  final ClaudeClient _claude;
  final NyxxGateway _client;
  final UsageLogger _logger;
  final GuildRepository _guildService;
  final GuildContextRepository _guildContext;

  MentionCommand({
    required ClaudeClient claude,
    required NyxxGateway client,
    required GuildRepository guildService,
    required GuildContextRepository guildContext,
  })  : _claude = claude,
        _client = client,
        _guildService = guildService,
        _guildContext = guildContext,
        _logger = UsageLogger();

  Future<void> handle(MessageCreateEvent event) async {
    final userMessage = event.message.content
        .replaceAll(RegExp(r'<@!?\d+>'), '')
        .trim();

    String? referencedContent;
    String? referencedAuthor;

    final referenced = event.message.referencedMessage;
    if (referenced != null) {
      referencedContent = referenced.content;
      referencedAuthor = switch (referenced.author) {
        final User u => u.username,
        _ => 'someone',
      };
    }

    final authorName = switch (event.message.author) {
      final User u => u.username,
      _ => 'unknown',
    };

    final systemPrompt = _buildSystemPrompt(authorName);
    print('[Mention] Received from $authorName: "$userMessage"');

    try {
      await _client.channels.triggerTyping(event.message.channelId);
    } catch (_) {}

    try {
      final response = await _claude.replyWithSearch(
        userMessage: userMessage,
        referencedMessage: referencedContent,
        referencedAuthor: referencedAuthor,
        systemPrompt: systemPrompt,
      );

      await _logger.log(
        response: response,
        triggeredBy: authorName,
        channelId: event.message.channelId.toString(),
      );

      await event.message.channel.sendMessage(
        MessageBuilder(
          content: response.text,
          referencedMessage: MessageReferenceBuilder.reply(
            messageId: event.message.id,
            failIfInexistent: false,
          ),
          allowedMentions: AllowedMentions(repliedUser: true),
        ),
      );

      if (userMessage.isNotEmpty) {
        final shouldUpdate = await _guildContext.record(authorName, userMessage);
        if (shouldUpdate) {
          _triggerProfileUpdate(authorName); // fire and forget
        }
      }
    } catch (e) {
      print('[Mention] Claude error: $e');
      await event.message.channel.sendMessage(
        MessageBuilder(
          content: '⚠️ Something went wrong. Try again in a moment.',
          referencedMessage: MessageReferenceBuilder.reply(
            messageId: event.message.id,
            failIfInexistent: false,
          ),
        ),
      );
    }
  }

  /// Runs asynchronously after the reply is sent — does not block the response.
  void _triggerProfileUpdate(String discordUsername) {
    _doProfileUpdate(discordUsername).catchError((Object e) {
      print('[Context] Profile update failed for $discordUsername: $e');
    });
  }

  Future<void> _doProfileUpdate(String discordUsername) async {
    final member = _guildContext.lookup(discordUsername);
    if (member == null || member.recentMessages.isEmpty) return;

    print('[Context] Updating profile for $discordUsername...');

    final messageList =
        member.recentMessages.map((m) => '- "$m"').join('\n');
    final existingNote = member.profileNote ?? 'brak';

    final prompt =
        '''Przeanalizuj ostatnie wiadomości gracza Discord "$discordUsername" i zwróć zaktualizowany profil.

Ostatnie wiadomości do bota:
$messageList

Aktualna notatka profilowa: $existingNote

Zwróć TYLKO obiekt JSON, bez markdown:
{
  "language": "pl",
  "topics_of_interest": ["maksymalnie 4 tematy po polsku"],
  "communication_style": "jedno krótkie zdanie po polsku",
  "running_jokes": ["tylko jeśli wyraźnie się powtarzają, inaczej pusta tablica"],
  "profile_note": "2-3 zdania po polsku podsumowujące kim jest ta osoba i jak z nią rozmawiać"
}''';

    final response = await _claude.reply(
      userMessage: prompt,
      systemPrompt:
          'You are a data extraction assistant. Output only valid JSON objects.',
      maxTokens: 512,
    );

    final jsonStr = _extractJson(response.text);
    final data = jsonDecode(jsonStr) as Map<String, dynamic>;
    await _guildContext.applyProfileUpdate(discordUsername, data);
  }

  String _extractJson(String text) {
    final fenceMatch =
        RegExp(r'```(?:json)?\s*([\s\S]*?)```').firstMatch(text);
    if (fenceMatch != null) return fenceMatch.group(1)!.trim();
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start != -1 && end > start) return text.substring(start, end + 1);
    return text.trim();
  }

  String _buildSystemPrompt(String discordUsername) {
    final lines = <String>[
      'Jesteś Maximum Effort Bot — botem gildii MaximumEffort, gildii World of Warcraft na serwerze Draenor-EU.',
      'Jesteś bystry, lekko sarkastyczny i doskonale znasz kulturę oraz memy WoW-a.',
      'Pomagasz członkom gildii w pytaniach, wdajesz się w przekomarzanie i dbasz o rozrywkę.',
      'Odpowiedzi mają być krótkie i treściwe — to czat na Discordzie, nie post na forum.',
      'Celuj w 1–3 zdania, chyba że ktoś wyraźnie poprosi o więcej szczegółów.',
      'Zawsze odpowiadaj po polsku, chyba że rozmówca pisze wyraźnie po angielsku.',
    ];

    if (_guildContext.guildNotes.isNotEmpty) {
      lines.add('');
      lines.add('## O gildii');
      lines.addAll(_guildContext.guildNotes.map((n) => '- $n'));
    }

    final memberCtx = _guildContext.lookup(discordUsername);
    lines.add('');
    lines.add('## Kto teraz z tobą rozmawia');
    lines.add('Nazwa Discord: $discordUsername');

    if (memberCtx != null) {
      if (memberCtx.language != null) {
        lines.add('Preferowany język: ${memberCtx.language}');
      }
      if (memberCtx.characters.isNotEmpty) {
        final main = memberCtx.characters.firstWhere(
          (c) => c.isMain,
          orElse: () => memberCtx.characters.first,
        );
        final cls = main.characterClass != null ? ' (${main.characterClass})' : '';
        lines.add('Główna postać: ${main.name}$cls');

        final alts = memberCtx.characters.where((c) => !c.isMain).toList();
        if (alts.isNotEmpty) {
          final altStr = alts.map((c) {
            final altCls = c.characterClass != null ? ' (${c.characterClass})' : '';
            return '${c.name}$altCls';
          }).join(', ');
          lines.add('Alty: $altStr');
        }

        final wowMain = _guildService.getMemberByCharacterName(main.name);
        if (wowMain != null) {
          if (wowMain.characterRace != null) lines.add('Rasa: ${wowMain.characterRace}');
          final ranking = _guildService.getRanking();
          final rank = ranking.indexWhere((m) => m.name == wowMain.name) + 1;
          if (rank > 0) {
            lines.add('Pozycja w rankingu mountów: #$rank z ${ranking.length} graczy, ${wowMain.mountCount} mountów');
          }
        }
      } else if (memberCtx.main != null) {
        // Fallback for members without rich character data
        lines.add('Główna postać: ${memberCtx.main}');
        final member = _guildService.getMemberByCharacterName(memberCtx.main!);
        if (member != null) {
          if (member.characterClass != null) lines.add('Klasa: ${member.characterClass}');
          if (member.characterRace != null) lines.add('Rasa: ${member.characterRace}');
          final ranking = _guildService.getRanking();
          final rank = ranking.indexWhere((m) => m.name == member.name) + 1;
          if (rank > 0) {
            lines.add('Pozycja w rankingu mountów: #$rank z ${ranking.length} graczy, ${member.mountCount} mountów');
          }
        }
      }
      if (memberCtx.characters.isEmpty && memberCtx.wowCharacters.length > 1) {
        lines.add('Znane postacie: ${memberCtx.wowCharacters.join(', ')}');
      }
      if (memberCtx.communicationStyle != null) {
        lines.add('Styl komunikacji: ${memberCtx.communicationStyle}');
      }
      if (memberCtx.topicsOfInterest.isNotEmpty) {
        lines.add('Zainteresowania: ${memberCtx.topicsOfInterest.join(', ')}');
      }
      if (memberCtx.runningJokes.isNotEmpty) {
        lines.add('Powtarzające się żarty: ${memberCtx.runningJokes.join('; ')}');
      }
      if (memberCtx.profileNote != null) {
        lines.add('Profil: ${memberCtx.profileNote}');
      }
      if (memberCtx.notes != null) {
        lines.add('Notatki: ${memberCtx.notes}');
      }
      lines.add('Liczba interakcji z botem: ${memberCtx.interactionCount}');
      if (memberCtx.recentMessages.isNotEmpty) {
        lines.add('Ostatnie wiadomości do ciebie:');
        lines.addAll(memberCtx.recentMessages.map((m) => '  - "$m"'));
      }
    } else {
      lines.add('(nowy użytkownik — brak historii)');
    }

    if (_guildContext.members.isNotEmpty) {
      lines.add('');
      lines.add('## Znani członkowie gildii');
      for (final m in _guildContext.members) {
        final parts = <String>['Discord: ${m.discordUsername}'];
        if (m.main != null) parts.add('główna postać: ${m.main}');
        if (m.wowCharacters.length > 1) {
          parts.add('alty: ${m.wowCharacters.where((c) => c != m.main).join(', ')}');
        }
        if (m.profileNote != null) parts.add('profil: ${m.profileNote}');
        if (m.notes != null) parts.add('notatki: ${m.notes}');
        lines.add('- ${parts.join(' | ')}');
      }
    }

    final top5 = _guildService.getRanking().take(5).toList();
    if (top5.isNotEmpty) {
      lines.add('');
      lines.add('## Aktualny top-5 rankingu mountów');
      for (int i = 0; i < top5.length; i++) {
        final m = top5[i];
        final cls = m.characterClass != null ? ' (${m.characterClass})' : '';
        lines.add('#${i + 1} ${m.name}$cls — ${m.mountCount} mountów');
      }
    }

    return lines.join('\n');
  }
}
