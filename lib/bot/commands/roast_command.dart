import 'package:nyxx/nyxx.dart';
import 'package:maxeffo_bot/models/guild_member.dart';
import 'package:maxeffo_bot/services/api/claude/claude_client.dart';
import 'package:maxeffo_bot/services/guild_context_repository.dart';
import 'package:maxeffo_bot/services/guild_repository.dart';
import 'package:maxeffo_bot/services/mplus_repository.dart';

class RoastCommand {
  final ClaudeClient _claude;
  final GuildContextRepository _guildContext;
  final GuildRepository _guildRepository;
  final MplusRepository _mplusRepository;

  static const _maxTokens = 300;

  static const _systemPrompt =
      'Jesteś mistrzem roastów gildii MaximumEffort na Draenor-EU. '
      'Twoje roasty są celne, śmieszne i zakorzenione w realiach WoW — '
      'mechanikach, klasach, rankingach, błędach raidowych. '
      'Piszesz po polsku. Maksymalnie 3–4 zdania. '
      'Skup się na konkretnych detalach — im bardziej osobiste, tym śmieszniej.';

  RoastCommand({
    required ClaudeClient claude,
    required GuildContextRepository guildContext,
    required GuildRepository guildRepository,
    required MplusRepository mplusRepository,
  })  : _claude = claude,
        _guildContext = guildContext,
        _guildRepository = guildRepository,
        _mplusRepository = mplusRepository;

  Future<void> handle(MessageCreateEvent event, String target) async {
    if (target.isEmpty) {
      await event.message.channel.sendMessage(
        MessageBuilder(content: 'Użycie: `!roast <nick>`'),
      );
      return;
    }
    await event.message.channel.sendMessage(await buildMessage(target));
  }

  Future<void> handleSlash(
      ApplicationCommandInteraction interaction, String target) async {
    await interaction.acknowledge();
    await interaction.respond(await buildMessage(target));
  }

  Future<MessageBuilder> buildMessage(String target) async {
    try {
      final memberCtx = _findInContext(target);
      final mainName = memberCtx?.main ?? target;
      final wowMember = _guildRepository.getMemberByCharacterName(mainName);
      final mplusScore = _findMplusScore(mainName);

      print('[Roast] Generating roast for: $target'
          '${memberCtx != null ? ' (found in context)' : ''}');

      final response = await _claude.reply(
        userMessage: _buildPrompt(
          target: target,
          memberCtx: memberCtx,
          wowMember: wowMember,
          mplusScore: mplusScore,
        ),
        systemPrompt: _systemPrompt,
        maxTokens: _maxTokens,
      );

      return MessageBuilder(content: response.text);
    } catch (e) {
      print('[Roast] Error: $e');
      return MessageBuilder(
        content: '⚠️ Nie udało się wygenerować roasta dla **$target**.',
      );
    }
  }

  /// Looks up a target by Discord username first, then by any known WoW character
  /// name — checking both the rich [CharacterRef] list and the legacy flat list.
  GuildMemberContext? _findInContext(String name) {
    final byUsername = _guildContext.lookup(name);
    if (byUsername != null) return byUsername;

    final lower = name.toLowerCase();
    for (final member in _guildContext.members) {
      if (member.characters.any((c) => c.name.toLowerCase() == lower)) {
        return member;
      }
      if (member.wowCharacters.any((c) => c.toLowerCase() == lower)) {
        return member;
      }
    }

    return null;
  }

  double? _findMplusScore(String characterName) {
    final lower = characterName.toLowerCase();
    for (final entry in _mplusRepository.getRanking()) {
      if (entry.characterName.toLowerCase() == lower) return entry.score;
    }
    return null;
  }

  String _buildPrompt({
    required String target,
    required GuildMemberContext? memberCtx,
    required GuildMember? wowMember,
    required double? mplusScore,
  }) {
    final lines = <String>['Napisz roasta dla gracza: **$target**', ''];

    if (memberCtx == null && wowMember == null) {
      lines.add('Brak danych o tej osobie — zaimprowizuj na podstawie samego nicku.');
      return lines.join('\n');
    }

    lines.add('Znane fakty:');

    // Rich character list from context takes priority over GuildRepository lookup
    if (memberCtx != null && memberCtx.characters.isNotEmpty) {
      final main = memberCtx.characters.firstWhere(
        (c) => c.isMain,
        orElse: () => memberCtx.characters.first,
      );
      lines.add('- Główna postać: ${main.name}'
          '${main.characterClass != null ? ' (${main.characterClass})' : ''}'
          '${main.realm != null ? ' @ ${main.realm}' : ''}');

      final alts = memberCtx.characters.where((c) => !c.isMain).toList();
      if (alts.isNotEmpty) {
        final altStr = alts.map((c) {
          final cls = c.characterClass != null ? ' (${c.characterClass})' : '';
          return '${c.name}$cls';
        }).join(', ');
        lines.add('- Alty: $altStr');
      }
    } else {
      // Fallback to GuildRepository data
      if (memberCtx?.main != null) lines.add('- Główna postać: ${memberCtx!.main}');
      if (wowMember?.characterClass != null) lines.add('- Klasa: ${wowMember!.characterClass}');
      if (wowMember?.characterRace != null) lines.add('- Rasa: ${wowMember!.characterRace}');
    }

    if (wowMember != null && wowMember.mountCount > 0) {
      final ranking = _guildRepository.getRanking();
      final rank = ranking.indexWhere(
            (m) => m.name.toLowerCase() == wowMember.name.toLowerCase(),
          ) +
          1;
      final rankStr = rank > 0 ? ' (#$rank w gildii)' : '';
      lines.add('- Mounty: ${wowMember.mountCount}$rankStr');
    }

    if (mplusScore != null && mplusScore > 0) {
      lines.add('- M+ Score: ${mplusScore.toStringAsFixed(1)}');
    }

    if (memberCtx != null) {
      if (memberCtx.communicationStyle != null) {
        lines.add('- Styl komunikacji: ${memberCtx.communicationStyle}');
      }
      if (memberCtx.topicsOfInterest.isNotEmpty) {
        lines.add('- Zainteresowania: ${memberCtx.topicsOfInterest.join(', ')}');
      }
      if (memberCtx.runningJokes.isNotEmpty) {
        lines.add('- Powtarzające się żarty: ${memberCtx.runningJokes.join('; ')}');
      }
      if (memberCtx.profileNote != null) {
        lines.add('- Profil: ${memberCtx.profileNote}');
      }
    }

    return lines.join('\n');
  }
}
