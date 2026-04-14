import 'package:nyxx/nyxx.dart';
import 'package:maxeffo_bot/config.dart';
import 'package:maxeffo_bot/services/api/raiderio/raiderio_client.dart';
import 'package:maxeffo_bot/services/guild_repository.dart';
import 'package:maxeffo_bot/services/mplus_repository.dart';
import 'package:maxeffo_bot/utils/wow_class.dart';

class LookupCommand {
  final Config _config;
  final GuildRepository _guildService;
  final MplusRepository _mplusService;
  final RaiderioClient _client;

  LookupCommand({
    required Config config,
    required GuildRepository guildService,
    required MplusRepository mplusService,
  })  : _config = config,
        _guildService = guildService,
        _mplusService = mplusService,
        _client = RaiderioClient();

  Future<void> handle(MessageCreateEvent event, String characterName) async {
    if (characterName.isEmpty) {
      await event.message.channel.sendMessage(
        MessageBuilder(content: 'Użycie: `!lookup <postać>`'),
      );
      return;
    }
    final msg = await buildMessage(characterName);
    await event.message.channel.sendMessage(msg);
  }

  Future<void> handleSlash(
      ApplicationCommandInteraction interaction, String characterName) async {
    await interaction.acknowledge();
    final msg = await buildMessage(characterName);
    await interaction.respond(msg);
  }

  Future<MessageBuilder> buildMessage(String characterName) async {
    try {
      final member = _guildService.getMemberByCharacterName(characterName);

      final details = await _client.getCharacterDetails(
        _config.region,
        member?.realmSlug ?? _config.realmSlug,
        characterName,
      );

      if (member == null && details == null) {
        return MessageBuilder(
          embeds: [
            EmbedBuilder(
              title: '❓ Nie znaleziono postaci',
              description:
                  '**$characterName** nie figuruje ani w gildii, ani na raider.io.',
              color: DiscordColor(0x808080),
            ),
          ],
        );
      }

      final displayName = member?.name ?? characterName;
      final className = member?.characterClass;
      final color = WowClass.color(className);
      final iconUrl = WowClass.iconUrl(className);

      final fields = <EmbedFieldBuilder>[];

      if (className != null) {
        fields.add(EmbedFieldBuilder(
          name: 'Klasa',
          value: className,
          isInline: true,
        ));
      }
      if (member?.characterRace != null) {
        fields.add(EmbedFieldBuilder(
          name: 'Rasa',
          value: member!.characterRace!,
          isInline: true,
        ));
      }

      if (details?.itemLevelEquipped != null) {
        final eq = details!.itemLevelEquipped!;
        final avg = details.itemLevelTotal;
        final value = avg != null ? '$eq ekwip. / $avg śr.' : '$eq ekwip.';
        fields.add(EmbedFieldBuilder(
          name: 'Item Level',
          value: value,
          isInline: true,
        ));
      }

      final mplusScore = details?.mplusScore ?? _findMplusScore(characterName);

      if (mplusScore != null && mplusScore > 0) {
        final rank = _mplusRank(characterName);
        final rankStr = rank != null ? ' (#$rank w gildii)' : '';
        fields.add(EmbedFieldBuilder(
          name: 'M+ Score',
          value: '${mplusScore.toStringAsFixed(1)}$rankStr',
          isInline: true,
        ));
      }

      if (member != null && member.mountCount > 0) {
        final mountRank = _mountRank(member.name);
        final rankStr = mountRank != null ? ' (#$mountRank w gildii)' : '';
        fields.add(EmbedFieldBuilder(
          name: 'Mounty',
          value: '${member.mountCount}$rankStr',
          isInline: true,
        ));
      }

      if (member != null) {
        fields.add(EmbedFieldBuilder(
          name: 'Ranga',
          value: _rankName(member.guildRank),
          isInline: true,
        ));
      }

      if (member?.lastLogin != null) {
        fields.add(EmbedFieldBuilder(
          name: 'Ostatnio aktywny',
          value: _lastSeen(member!.lastLogin!),
          isInline: false,
        ));
      }

      final footerText = member == null
          ? 'Postać spoza gildii • MaximumEffort – Draenor EU'
          : 'MaximumEffort – Draenor EU';

      return MessageBuilder(
        embeds: [
          EmbedBuilder(
            title: displayName,
            color: color,
            fields: fields,
            thumbnail: iconUrl != null ? EmbedThumbnailBuilder(url: Uri.parse(iconUrl)) : null,
            footer: EmbedFooterBuilder(text: footerText),
            timestamp: DateTime.now(),
          ),
        ],
      );
    } catch (e) {
      print('[Lookup] Error for $characterName: $e');
      return MessageBuilder(
        content: '⚠️ Błąd podczas pobierania danych dla **$characterName**.',
      );
    }
  }

  double? _findMplusScore(String characterName) {
    final lower = characterName.toLowerCase();
    for (final entry in _mplusService.getRanking()) {
      if (entry.characterName.toLowerCase() == lower) return entry.score;
    }
    return null;
  }

  int? _mplusRank(String name) {
    final ranking = _mplusService.getRanking();
    final idx = ranking.indexWhere(
      (e) => e.characterName.toLowerCase() == name.toLowerCase(),
    );
    return idx == -1 ? null : idx + 1;
  }

  int? _mountRank(String name) {
    final ranking = _guildService.getRanking();
    final idx = ranking.indexWhere(
      (m) => m.name.toLowerCase() == name.toLowerCase(),
    );
    return idx == -1 ? null : idx + 1;
  }

  String _rankName(int rank) => switch (rank) {
        0 => 'Guild Master',
        1 => 'Officer',
        2 => 'Officer Alt',
        _ => 'Member',
      };

  String _lastSeen(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays == 0) return 'dzisiaj';
    if (diff.inDays == 1) return 'wczoraj';
    if (diff.inDays < 30) return '${diff.inDays} dni temu';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()} mies. temu';
    return '${(diff.inDays / 365).floor()} lat temu';
  }

}
