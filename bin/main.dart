import 'dart:async';

import 'package:loggy/loggy.dart';
import 'package:nyxx/nyxx.dart';
import 'package:maxeffo_bot/config.dart';
import 'package:maxeffo_bot/utils/bot_loggy.dart';
import 'package:maxeffo_bot/services/guild_repository.dart';
import 'package:maxeffo_bot/services/api/claude/claude_client.dart';
import 'package:maxeffo_bot/bot/commands/mounts_command.dart';
import 'package:maxeffo_bot/bot/commands/mplus_command.dart';
import 'package:maxeffo_bot/bot/commands/progression_command.dart';
import 'package:maxeffo_bot/bot/commands/lookup_command.dart';
import 'package:maxeffo_bot/bot/commands/debug_commands.dart';
import 'package:maxeffo_bot/bot/commands/mention_command.dart';
import 'package:maxeffo_bot/bot/commands/roast_command.dart';
import 'package:maxeffo_bot/services/mplus_repository.dart';
import 'package:maxeffo_bot/bot/announcement_service.dart';
import 'package:maxeffo_bot/services/guild_context_repository.dart';
import 'package:maxeffo_bot/services/api/claude/tavily_client.dart';

void main() async {
  Loggy.initLoggy(logPrinter: const BotLogPrinter());

  final config = Config.load();

  final guildService = GuildRepository(config);
  await guildService.initialize();

  _printTop100(guildService);

  final mountsCommand = MountsCommand(guildService);
  final debugCommands = DebugCommands(guildService);

  final mplusService = MplusRepository(config: config, guildService: guildService);
  await mplusService.initialize();
  final mplusCommand = MplusCommand(mplusService, guildService);
  final progressionCommand = ProgressionCommand(config);
  final lookupCommand = LookupCommand(
    config: config,
    guildService: guildService,
    mplusService: mplusService,
  );

  // ClaudeClient is optional — only created if API key is configured
  final searchService = config.tavilyApiKey != null
      ? TavilyClient(apiKey: config.tavilyApiKey!)
      : null;

  final claudeService = config.anthropicApiKey != null
      ? ClaudeClient(apiKey: config.anthropicApiKey!, searchService: searchService)
      : null;

  if (searchService != null) {
    print('[Bot] Web search enabled (Tavily).');
  }

  final guildContext = await GuildContextRepository.load();

  final roastCommand = claudeService != null
      ? RoastCommand(
          claude: claudeService,
          guildContext: guildContext,
          guildRepository: guildService,
          mplusRepository: mplusService,
        )
      : null;

  int attempt = 0;
  while (true) {
    final connectedAt = DateTime.now();
    try {
      attempt++;
      if (attempt > 1) print('[Bot] Reconnect attempt $attempt...');

      await _connect(config, guildService, mountsCommand, mplusCommand,
          progressionCommand, lookupCommand, debugCommands, claudeService,
          guildContext, roastCommand);
    } catch (e) {
      if (DateTime.now().difference(connectedAt) > const Duration(minutes: 1)) {
        attempt = 0;
      }
      final delay = _backoff(attempt);
      print('[Bot] Disconnected ($e). Retrying in ${delay.inSeconds}s...');
      await Future<void>.delayed(delay);
    }
  }
}

Future<void> _connect(
  Config config,
  GuildRepository guildService,
  MountsCommand mountsCommand,
  MplusCommand mplusCommand,
  ProgressionCommand progressionCommand,
  LookupCommand lookupCommand,
  DebugCommands debugCommands,
  ClaudeClient? claudeService,
  GuildContextRepository guildContext,
  RoastCommand? roastCommand,
) {
  final completer = Completer<void>();

  runZonedGuarded(() async {
    final client = await Nyxx.connectGateway(
      config.discordToken,
      GatewayIntents.allUnprivileged | GatewayIntents.messageContent,
    );

    // Register global slash commands (replaces all existing)
    await client.commands.bulkOverride([
      ApplicationCommandBuilder.chatInput(
        name: 'mounts',
        description: 'Ranking mountów w gildii MaximumEffort',
        options: [],
      ),
      ApplicationCommandBuilder.chatInput(
        name: 'mplus',
        description: 'Ranking M+ score w gildii MaximumEffort',
        options: [],
      ),
      ApplicationCommandBuilder.chatInput(
        name: 'progression',
        description: 'Postęp raidowy gildii MaximumEffort',
        options: [],
      ),
      ApplicationCommandBuilder.chatInput(
        name: 'lookup',
        description: 'Profil postaci: klasa, ilvl, M+ score, mounty',
        options: [
          CommandOptionBuilder.string(
            name: 'postac',
            description: 'Nazwa postaci do wyszukania',
            isRequired: true,
          ),
        ],
      ),
      ApplicationCommandBuilder.chatInput(
        name: 'roast',
        description: 'Roast wybranego gracza gildii',
        options: [
          CommandOptionBuilder.string(
            name: 'nick',
            description: 'Nick Discord lub nazwa postaci',
            isRequired: true,
          ),
        ],
      ),
    ]);
    print('[Bot] Slash commands registered.');

    if (config.announcementsChannelId != null) {
      final announcements = AnnouncementService(
        client: client,
        channelId: config.announcementsChannelId!,
      );
      guildService.onCycleChanges.listen((changes) async {
        await announcements.announce(changes);
      });
    }

    // MentionCommand needs the client to fetch referenced messages
    final mentionCommand = claudeService != null
        ? MentionCommand(
            claude: claudeService,
            client: client,
            guildService: guildService,
            guildContext: guildContext,
          )
        : null;

    final botId = client.user.id;

    // Slash command interactions
    client.onApplicationCommandInteraction.listen((event) async {
      final interaction = event.interaction;
      final name = interaction.data.name;

      switch (name) {
        case 'mounts':
          await mountsCommand.handleSlash(interaction);
        case 'mplus':
          await mplusCommand.handleSlash(interaction);
        case 'progression':
          await progressionCommand.handleSlash(interaction);
        case 'lookup':
          final charName = (interaction.data.options
                  ?.firstWhere((o) => o.name == 'postac')
                  .value as String?)
              ?? '';
          await lookupCommand.handleSlash(interaction, charName);
        case 'roast':
          final nick = (interaction.data.options
                  ?.firstWhere((o) => o.name == 'nick')
                  .value as String?)
              ?? '';
          await roastCommand?.handleSlash(interaction, nick);
      }
    });

    client.onMessageCreate.listen((event) async {
      final author = event.message.author;
      if (author is User && author.isBot) return;

      // Check for @mention before lowercasing (IDs are numeric)
      final rawContent = event.message.content;
      final isMentioned = rawContent.contains('<@$botId>') ||
          rawContent.contains('<@!$botId>');

      if (isMentioned && mentionCommand != null) {
        await mentionCommand.handle(event);
        return;
      }

      if (await debugCommands.handle(event)) return;

      final content = rawContent.trim();
      final lower = content.toLowerCase();

      if (lower.startsWith('!lookup')) {
        final name = content.substring('!lookup'.length).trim();
        await lookupCommand.handle(event, name);
        return;
      }

      if (lower.startsWith('!roast')) {
        final nick = content.substring('!roast'.length).trim();
        await roastCommand?.handle(event, nick);
        return;
      }

      switch (lower) {
        case '!mounts':
          await mountsCommand.handle(event);
        case '!mplus':
          await mplusCommand.handle(event);
        case '!progression':
          await progressionCommand.handle(event);
      }
    });

    print('[Bot] Connected and listening.'
        '${mentionCommand != null ? ' Claude mentions + roasts enabled.' : ''}');
  }, (error, stack) {
    if (!completer.isCompleted) completer.completeError(error, stack);
  });

  return completer.future;
}

void _printTop100(GuildRepository guildService) {
  final top = guildService.getRanking().take(100).toList();
  print('--- Top 100 Mounts ---');
  for (int i = 0; i < top.length; i++) {
    final m = top[i];
    print(
        '#${(i + 1).toString().padLeft(2)}  ${m.name.padRight(20)}  ${m.mountCount}');
  }
  print('----------------------');
}

// Exponential backoff: 5s, 10s, 20s, 40s … capped at 5 minutes
Duration _backoff(int attempt) {
  final seconds = (5 * (1 << (attempt - 1))).clamp(5, 300);
  return Duration(seconds: seconds);
}
