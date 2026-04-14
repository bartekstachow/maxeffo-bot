import 'package:nyxx/nyxx.dart';
import 'package:maxeffo_bot/bot/commands/command.dart';
import 'package:maxeffo_bot/services/guild_repository.dart';
import 'package:maxeffo_bot/services/mplus_repository.dart';
import 'package:maxeffo_bot/utils/wow_class.dart';

class MplusCommand extends BotCommand {
  final MplusRepository _mplusService;
  final GuildRepository _guildService;

  static const _topN = 25;
  static const _color = DiscordColor(0x0A84FF); // mythic+ blue

  MplusCommand(this._mplusService, this._guildService);

  @override
  Future<MessageBuilder> buildMessage() async {
    if (!_mplusService.isInitialized) {
      return MessageBuilder(content: '⏳ Dane M+ jeszcze się ładują, spróbuj za chwilę.');
    }

    final ranking = _mplusService.getRanking();

    if (ranking.isEmpty) {
      return MessageBuilder(content: '📭 Brak danych M+ — trwa pobieranie w tle.');
    }

    final top = ranking.take(_topN).toList();
    final buf = StringBuffer();
    for (int i = 0; i < top.length; i++) {
      final e = top[i];
      final member = _guildService.getMemberByCharacterName(e.characterName);
      final icon = WowClass.emoji(member?.characterClass);
      final rank = '`#${(i + 1).toString().padLeft(2)}`';
      buf.writeln('$icon $rank **${e.characterName}** — ${e.score.toStringAsFixed(1)}');
    }

    return MessageBuilder(
      embeds: [
        EmbedBuilder(
          title: '⚔️ Ranking M+ Score',
          description: buf.toString().trimRight(),
          color: _color,
          footer: EmbedFooterBuilder(text: 'MaximumEffort – Draenor EU • via raider.io'),
          timestamp: DateTime.now(),
        ),
      ],
    );
  }
}