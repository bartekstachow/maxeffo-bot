import 'package:nyxx/nyxx.dart';
import 'package:maxeffo_bot/bot/commands/command.dart';
import 'package:maxeffo_bot/config.dart';
import 'package:maxeffo_bot/services/api/raiderio/raiderio_client.dart';

class ProgressionCommand extends BotCommand {
  final Config _config;
  final RaiderioClient _client;

  static const _cacheTtl = Duration(hours: 1);
  static const _barWidth = 10;
  static const _color = DiscordColor(0xFF6600); // raid orange

  List<RaidProgression>? _cached;
  DateTime? _cachedAt;

  ProgressionCommand(this._config) : _client = RaiderioClient();

  // Sends a loading placeholder before the (potentially slow) fetch.
  @override
  Future<void> handle(MessageCreateEvent event) async {
    await event.message.channel.sendMessage(
      MessageBuilder(content: '⏳ Pobieram dane...'),
    );
    await event.message.channel.sendMessage(await buildMessage());
  }

  @override
  Future<MessageBuilder> buildMessage() async {
    try {
      final progression = await _getProgression();
      final active = progression.where((r) => r.normalKilled > 0).toList();

      if (active.isEmpty) {
        return MessageBuilder(content: '📭 Brak danych o progresie gildii.');
      }

      final fields = <EmbedFieldBuilder>[];
      for (final raid in active) {
        final lines = <String>[];

        if (raid.mythicKilled > 0 || raid.heroicKilled == raid.totalBosses) {
          lines.add('Mythic  `${_bar(raid.mythicKilled, raid.totalBosses)}`  ${_kills(raid.mythicKilled, raid.totalBosses)}');
        }
        lines.add('Heroic  `${_bar(raid.heroicKilled, raid.totalBosses)}`  ${_kills(raid.heroicKilled, raid.totalBosses)}');
        lines.add('Normal  `${_bar(raid.normalKilled, raid.totalBosses)}`  ${_kills(raid.normalKilled, raid.totalBosses)}');

        fields.add(EmbedFieldBuilder(
          name: '${_formatName(raid.slug)}  •  ${raid.summary}',
          value: lines.join('\n'),
          isInline: false,
        ));
      }

      final age = _cachedAt != null
          ? 'Dane z ${_minutesAgo(_cachedAt!)} min temu'
          : 'MaximumEffort – Draenor EU';
      final footer = '$age • MaximumEffort – Draenor EU • via raider.io';

      return MessageBuilder(
        embeds: [
          EmbedBuilder(
            title: '🏰 Postęp Raidowy',
            color: _color,
            fields: fields,
            footer: EmbedFooterBuilder(text: footer),
            timestamp: DateTime.now(),
          ),
        ],
      );
    } catch (e) {
      print('[Progression] Error: $e');
      return MessageBuilder(content: '⚠️ Nie udało się pobrać danych o progresie.');
    }
  }

  Future<List<RaidProgression>> _getProgression() async {
    final now = DateTime.now();
    if (_cached != null &&
        _cachedAt != null &&
        now.difference(_cachedAt!) < _cacheTtl) {
      return _cached!;
    }

    print('[Progression] Fetching guild progression from raider.io...');
    final result = await _client.getGuildProgression(
      _config.region,
      _config.realmSlug,
      _config.guildSlug,
    );

    _cached = result;
    _cachedAt = now;
    print('[Progression] Fetched ${result.length} raid(s).');
    return result;
  }

  String _bar(int killed, int total) {
    if (total == 0) return '░' * _barWidth;
    final filled = (killed / total * _barWidth).round();
    return '${'█' * filled}${'░' * (_barWidth - filled)}';
  }

  String _kills(int killed, int total) {
    final s = '$killed/$total';
    return killed == total ? '**$s ✓**' : s;
  }

  String _formatName(String slug) =>
      slug.split('-').map((w) => '${w[0].toUpperCase()}${w.substring(1)}').join(' ');

  int _minutesAgo(DateTime dt) => DateTime.now().difference(dt).inMinutes;
}