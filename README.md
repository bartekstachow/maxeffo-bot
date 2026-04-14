# MaximumEffort Bot

Discord bot for the MaximumEffort WoW guild on Draenor-EU.

## Running

```
dart run bin/main.dart
```

## Roadmap

### Guild Data
- [x] `!mounts` — mount count ranking via Battle.net API
- [x] `!mplus` — M+ score ranking via raider.io API (free, no key required)
- [x] `!progression` — guild raid progress (bosses killed, difficulty)
- [ ] `!lookup <character>` — quick character profile: class, ilvl, mounts, M+ score
- [ ] Auto-announcement when someone kills a new boss or improves their M+ score

### Weekly Reminders
- [ ] Weekly reset (Wednesday EU) — bot posts M+ affixes and weekly news automatically
- [ ] Current M+ affixes (available via WoW API)
- [ ] In-game events (Darkmoon Faire, timewalking, etc.)

### AI Improvements
- [ ] Per-channel conversation memory — bot sees last N messages in the channel, not just the tagged message
- [ ] Proactive messages — bot occasionally posts on its own (WoW trivia, ranking commentary)
- [ ] `!roast <nick>` — bot roasts a player based on their stats

### UX / Discord
- [x] Slash commands (`/mounts`, `/lookup`) instead of prefix — more native Discord experience
- [x] Rich embeds for all rankings (mounts, M+, progression, lookup) instead of plain code blocks
- [ ] `!compare <char1> <char2>` — side-by-side player comparison

### Infrastructure
- [ ] Deploy to VPS (24/7 uptime without a local machine)
- [ ] Re-enable mount polling (`guild_service.dart → initialize()` — calls to `_fetchRosterAndMounts`, `_refreshLastLogins`, `_refreshLastLoginsIfNeeded`, `_startPolling`, `_startDailyLoginRefresh` are currently commented out)
- [ ] Web dashboard for viewing stats and editing `guild_context.json`
