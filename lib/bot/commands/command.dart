import 'package:nyxx/nyxx.dart';

/// Base class for standard bot commands that follow the build-then-send pattern.
///
/// Subclasses implement [buildMessage] and get the full dispatch logic for both
/// prefix commands ([handle]) and slash command interactions ([handleSlash]).
abstract class BotCommand {
  Future<MessageBuilder> buildMessage();

  Future<void> handle(MessageCreateEvent event) async {
    await event.message.channel.sendMessage(await buildMessage());
  }

  Future<void> handleSlash(ApplicationCommandInteraction interaction) async {
    await interaction.acknowledge();
    await interaction.respond(await buildMessage());
  }
}