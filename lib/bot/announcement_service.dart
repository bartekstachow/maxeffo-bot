import 'package:nyxx/nyxx.dart';
import 'package:maxeffo_bot/models/mount_change.dart';

class AnnouncementService {
  final NyxxGateway _client;
  final Snowflake _channelId;

  AnnouncementService({
    required NyxxGateway client,
    required String channelId,
  })  : _client = client,
        _channelId = Snowflake.parse(channelId);

  Future<void> announce(List<MountChange> changes) async {
    if (changes.isEmpty) return;

    try {
      final channel = await _client.channels.get(_channelId);
      await (channel as TextChannel).sendMessage(
        MessageBuilder(embeds: [_buildEmbed(changes)]),
      );
    } catch (e) {
      print('[Announce] Failed to send update: $e');
    }
  }

  EmbedBuilder _buildEmbed(List<MountChange> changes) {
    // Sort by mounts gained desc, then by new total desc
    final sorted = [...changes]
      ..sort((a, b) {
        final byGained = b.gained.compareTo(a.gained);
        return byGained != 0 ? byGained : b.newTotal.compareTo(a.newTotal);
      });

    final shown = sorted.take(15).toList();
    final overflow = sorted.length - shown.length;

    final buffer = StringBuffer();
    for (final change in shown) {
      final arrow = switch (change.rankDelta) {
        > 0 => '🟢⬆',
        < 0 => '🔴⬇',
        _ => '⚪➡',
      };

      final rankText = change.rankDelta != 0
          ? '*(#${change.previousRank} → #${change.newRank})*'
          : '*(#${change.newRank})*';

      final mountWord = change.gained == 1 ? 'mount' : 'mounts';

      buffer.writeln(
        '$arrow **${change.characterName}** '
        '+${change.gained} $mountWord · '
        '`${change.newTotal}` total  $rankText',
      );
    }

    if (overflow > 0) {
      buffer.writeln('*... and $overflow more*');
    }

    final total = changes.fold(0, (sum, c) => sum + c.gained);
    final uniqueChars = changes.length;
    final desc = uniqueChars == 1
        ? '**1** adventurer collected **$total** new mount${total == 1 ? '' : 's'}!'
        : '**$uniqueChars** adventurers collected **$total** new mount${total == 1 ? '' : 's'} in total!';

    return EmbedBuilder(
      title: '🏇  Mount Update — MaximumEffort',
      description: desc,
      color: DiscordColor.fromRgb(244, 196, 48), // gold
      fields: [
        EmbedFieldBuilder(
          name: '🆕  New Mounts Collected',
          value: buffer.toString(),
          isInline: false,
        ),
      ],
      timestamp: DateTime.now(),
      footer: EmbedFooterBuilder(text: 'MaximumEffort • Draenor-EU'),
    );
  }
}
