# CLAUDE.md — maxeffo_bot

Discord bot for the **MaximumEffort** WoW guild on **Draenor-EU**.  
Primary features: mount ranking, M+ score ranking, raid progression, character lookup, AI-powered roasts, and bot @mention conversations.

## Running

```bash
dart run bin/main.dart
```

Requires a `.env` file in the project root (see Configuration below).

## Stack

- **Dart** ^3.5.0
- **nyxx** ^6.0.0 — Discord gateway
- **Chopper** ^8.0.0 — HTTP client codegen (Battle.net API only)
- **Freezed** + **json_serializable** — immutable models with JSON support
- **dotenv** ^4.2.0 — environment config
- **http** ^1.2.0 — plain HTTP client (Raider.io, Claude, Tavily)

After adding or modifying a `@freezed` model or a Chopper service, regenerate:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Configuration

All secrets live in `.env` (gitignored). Required keys:

| Key | Purpose |
|---|---|
| `DISCORD_TOKEN` | Bot token |
| `BNET_CLIENT_ID` / `BNET_CLIENT_SECRET` | Battle.net OAuth2 client credentials |
| `REALM_SLUG` | `draenor` |
| `GUILD_SLUG` | `maximumeffort` |
| `REGION` | `eu` |

Optional keys:

| Key | Purpose |
|---|---|
| `ANNOUNCEMENTS_CHANNEL_ID` | Channel for mount-change announcements |
| `ANTHROPIC_API_KEY` | Enables `/roast` and @mention commands |
| `TAVILY_API_KEY` | Enables web search in @mention conversations |

## Architecture & Naming Conventions

### Class naming

| Suffix | Role |
|---|---|
| `*Client` | Thin HTTP wrapper — one external API, stateless (e.g. `BnetClient`, `ClaudeClient`, `RaiderioClient`) |
| `*Repository` | Domain class owning state, caching, and polling (e.g. `GuildRepository`, `MplusRepository`) |
| `*Logger`, `*Cache` | Infrastructure utilities named by what they do |

**Avoid `*Service`** — it blurs the boundary between HTTP clients and domain repositories.

Rule of thumb: *"if I swap the data source, does this class survive?"* — yes → Repository; no → Client.

### Folder layout

```
lib/
  bot/
    commands/           # One file per command; all extend BotCommand
    announcement_service.dart
  models/
    api/                # Freezed response models for external APIs
    *.dart              # Core domain models
  services/
    api/
      bnet/             # Everything that calls Battle.net (client + Chopper service + interceptors)
        interceptors/
      claude/           # Claude + Tavily clients
      raiderio/         # Raider.io client
    *.dart              # Domain repositories and infra (GuildRepository, CacheService, etc.)
  utils/                # Stateless helpers (e.g. wow_class.dart)
  config.dart
bin/
  main.dart             # Entry point: wires services, registers commands
```

### Commands pattern

All commands extend the abstract `BotCommand` base class (`lib/bot/commands/command.dart`).  
Each command handles both prefix (`!cmd`) and slash (`/cmd`) variants.

To add a new command:
1. Create `lib/bot/commands/<name>_command.dart` extending `BotCommand`.
2. Register it in `bin/main.dart`: add a case to the prefix switch block and register the slash command builder.

## Language

All user-facing text — embeds, descriptions, error messages, slash command descriptions — must be in **Polish**.  
WoW class names are also in Polish (see `lib/utils/wow_class.dart`).

## Key implementation notes

- **Mount polling** is intentionally disabled in `GuildRepository.initialize()` during development. Re-enable before deploying.
- **Channel safety guard**: the bot checks `ANNOUNCEMENTS_CHANNEL_ID` to limit where it responds during testing. Remove or widen this restriction for production.
- **Exponential backoff**: Discord reconnection uses 5 s → 10 s → 20 s … capped at 5 min.
- **M+ polling**: `MplusRepository` fetches one character every 300 ms, full cycle ~4 hours.
- **GuildContextRepository**: persists Discord user profiles (alts, language, notes, running jokes) to `guild_context.json`.
- **ClaudeClient**: uses tool use for optional web search via Tavily. Log usage is written to `logs/claude_usage.log`.