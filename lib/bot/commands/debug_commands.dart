import 'package:nyxx/nyxx.dart';
import 'package:maxeffo_bot/services/guild_repository.dart';

class DebugCommands {
  final GuildRepository _guildService;

  DebugCommands(this._guildService);

  /// Returns true if the message was a recognised debug command.
  Future<bool> handle(MessageCreateEvent event) async {
    final content = event.message.content.trim().toLowerCase();
    if (!content.startsWith('!debug-')) return false;

    final command = content.substring('!debug-'.length).split(' ').first;

    switch (command) {
      case 'simulate-mounts':
        await _simulateMounts(event);
      default:
        await _unknownCommand(event, command);
    }

    return true;
  }

  Future<void> _simulateMounts(MessageCreateEvent event) async {
    if (!_guildService.isInitialized) {
      await _reply(event, '⏳ Guild data not ready yet.');
      return;
    }

    await _reply(
      event,
      '🔧 Simulating mount changes and triggering announcement...',
    );
    _guildService.debugSimulateMountChanges();
  }

  Future<void> _unknownCommand(
      MessageCreateEvent event, String command) async {
    await _reply(
      event,
      '❓ Unknown debug command: `!debug-$command`\n\n'
      '**Available commands:**\n'
      '`!debug-simulate-mounts` — simulate a ranking change and trigger the announcement embed',
    );
  }

  Future<void> _reply(MessageCreateEvent event, String content) async {
    await event.message.channel.sendMessage(
      MessageBuilder(content: content),
    );
  }
}
