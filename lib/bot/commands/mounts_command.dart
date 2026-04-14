import 'package:nyxx/nyxx.dart';
import 'package:maxeffo_bot/bot/commands/command.dart';
import 'package:maxeffo_bot/services/guild_repository.dart';
import 'package:maxeffo_bot/utils/wow_class.dart';

class MountsCommand extends BotCommand {
  final GuildRepository _guildService;

  static const _color = DiscordColor(0xFFD700); // gold

  MountsCommand(this._guildService);

  @override
  Future<MessageBuilder> buildMessage() async {
    if (!_guildService.isInitialized) {
      return MessageBuilder(content: '⏳ Dane gildii się ładują, spróbuj za chwilę.');
    }

    final ranking = _guildService.getRanking();

    if (ranking.isEmpty) {
      return MessageBuilder(content: '❌ Brak danych gildii.');
    }

    final top = ranking.take(25).toList();
    final buf = StringBuffer();
    for (int i = 0; i < top.length; i++) {
      final m = top[i];
      final icon = WowClass.emoji(m.characterClass);
      final rank = '`#${(i + 1).toString().padLeft(2)}`';
      buf.writeln('$icon $rank **${m.name}** — ${m.mountCount}');
    }

    final footer = ranking.length > 25
        ? 'Top 25 z ${ranking.length} postaci • MaximumEffort – Draenor EU'
        : 'MaximumEffort – Draenor EU';

    return MessageBuilder(
      embeds: [
        EmbedBuilder(
          title: '🏇 Ranking Mountów',
          description: buf.toString().trimRight(),
          color: _color,
          footer: EmbedFooterBuilder(text: footer),
          timestamp: DateTime.now(),
        ),
      ],
    );
  }
}