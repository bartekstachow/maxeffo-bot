import 'dart:async';
import 'dart:math';

import 'package:maxeffo_bot/config.dart';
import 'package:maxeffo_bot/models/guild_member.dart';
import 'package:maxeffo_bot/models/mount_change.dart';
import 'package:maxeffo_bot/services/api/bnet/bnet_client.dart';
import 'package:maxeffo_bot/services/cache_service.dart';

const _inactiveCutoff = Duration(days: 90);

class GuildRepository {
  final Config _config;
  final BnetClient _client;
  final CacheService _cacheService;

  Map<String, GuildMember> _members = {};

  /// Snapshot of mount counts from the last completed polling cycle.
  /// Used to detect changes and compute ranking shifts.
  Map<String, int> _mountSnapshot = {};

  final _changesController = StreamController<List<MountChange>>.broadcast();

  /// Fires after each full polling cycle when at least one mount count changed.
  Stream<List<MountChange>> get onCycleChanges => _changesController.stream;

  bool _initialized = false;
  bool get isInitialized => _initialized;

  GuildRepository(this._config)
      : _client = BnetClient.fromConfig(_config),
        _cacheService = CacheService();

  Future<void> initialize() async {
    print('[Guild] Loading cache...');
    _members = await _cacheService.load();
    print('[Guild] Cache loaded: ${_members.length} members.');

    // TODO: re-enable fetching when done debugging (see README)
    // if (_members.isEmpty) {
    //   print('[Guild] No cache found. Performing initial fetch...');
    //   await _fetchRosterAndMounts();
    //   await _refreshLastLogins();
    // } else {
    //   _fetchRosterAndMounts().catchError((Object e) {
    //     print('[Guild] Warning: Background roster refresh failed: $e');
    //   });
    //   _refreshLastLoginsIfNeeded();
    // }

    // Lightweight one-time roster fetch to populate class/race data
    _refreshRosterClassData().catchError((Object e) {
      print('[Guild] Warning: Class data refresh failed: $e');
    });

    _mountSnapshot = _takeMountSnapshot();
    _initialized = true;
    // _startPolling();
    // _startDailyLoginRefresh();
    print('[Guild] Ready (fetch disabled for debugging).');
  }

  /// Fetches the guild roster (single API call) and updates class/race data only.
  /// Does not touch mount counts or trigger polling.
  Future<void> _refreshRosterClassData() async {
    print('[Guild] Refreshing class/race data from roster...');
    final roster =
        await _client.getGuildRoster(_config.realmSlug, _config.guildSlug);

    int updated = 0;
    for (final entry in roster) {
      final name = entry.character.name;
      final realmSlug = entry.character.realm.slug;
      final key = '${name.toLowerCase()}_$realmSlug';
      final cls = entry.character.playableClass?.name;
      final race = entry.character.playableRace?.name;

      if (_members.containsKey(key)) {
        final existing = _members[key]!;
        if (existing.characterClass == null && cls != null ||
            existing.characterRace == null && race != null) {
          _members[key] = existing.copyWith(
            characterClass: cls ?? existing.characterClass,
            characterRace: race ?? existing.characterRace,
            guildRank: entry.rank,
          );
          updated++;
        }
      } else {
        // New member not yet in cache
        _members[key] = GuildMember(
          name: name,
          realmSlug: realmSlug,
          guildRank: entry.rank,
          characterClass: cls,
          characterRace: race,
        );
        updated++;
      }
    }

    await _cacheService.save(_members);
    print('[Guild] Class data refresh done. Updated $updated member(s).');
  }

  // ignore: unused_element
  Future<void> _fetchRosterAndMounts() async {
    print('[Guild] Fetching roster for ${_config.guildSlug}@${_config.realmSlug}...');
    final roster =
        await _client.getGuildRoster(_config.realmSlug, _config.guildSlug);

    for (final entry in roster) {
      final name = entry.character.name;
      final realmSlug = entry.character.realm.slug;
      final key = '${name.toLowerCase()}_$realmSlug';

      if (!_members.containsKey(key)) {
        _members[key] = GuildMember(
          name: name,
          realmSlug: realmSlug,
          guildRank: entry.rank,
          characterClass: entry.character.playableClass?.name,
          characterRace: entry.character.playableRace?.name,
        );
      } else {
        // Update class/race in case roster data changed
        final existing = _members[key]!;
        final cls = entry.character.playableClass?.name;
        final race = entry.character.playableRace?.name;
        if (cls != null || race != null) {
          _members[key] = existing.copyWith(
            characterClass: cls ?? existing.characterClass,
            characterRace: race ?? existing.characterRace,
          );
        }
      }
    }

    print('[Guild] Fetching mounts for ${_members.length} members...');
    int done = 0;
    for (final key in _members.keys.toList()) {
      await _updateMounts(key);
      done++;
      if (done % 10 == 0) {
        print('[Guild] Mounts progress: $done/${_members.length}');
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }

    await _cacheService.save(_members);
    print('[Guild] Roster + mounts fetch complete.');
  }

  Future<void> _refreshLastLogins() async {
    print('[Guild] Refreshing last login data for ${_members.length} members...');
    int done = 0;
    for (final key in _members.keys.toList()) {
      await _updateLastLogin(key);
      done++;
      if (done % 10 == 0) {
        print('[Guild] Last login progress: $done/${_members.length}');
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }
    await _cacheService.save(_members);
    print('[Guild] Last login refresh complete.');
  }

  // ignore: unused_element
  void _refreshLastLoginsIfNeeded() {
    final needsRefresh = _members.values.any((m) => m.lastLogin == null);
    if (needsRefresh) {
      _refreshLastLogins().catchError((Object e) {
        print('[Guild] Warning: Last login refresh failed: $e');
      });
    }
  }

  // ignore: unused_element
  void _startDailyLoginRefresh() {
    Timer.periodic(const Duration(hours: 24), (_) {
      _refreshLastLogins().catchError((Object e) {
        print('[Guild] Warning: Daily last login refresh failed: $e');
      });
    });
  }

  Future<void> _updateMounts(String key) async {
    final member = _members[key];
    if (member == null) return;

    try {
      final count =
          await _client.getCharacterMountCount(member.realmSlug, member.name);
      _members[key] = member.copyWith(
        mountCount: count > member.mountCount ? count : member.mountCount,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      print('[Guild] Warning: Failed to update mounts for ${member.name}: $e');
    }
  }

  Future<void> _updateLastLogin(String key) async {
    final member = _members[key];
    if (member == null) return;

    try {
      final lastLogin =
          await _client.getCharacterLastLogin(member.realmSlug, member.name);
      if (lastLogin != null) {
        _members[key] = member.copyWith(lastLogin: lastLogin);
      }
    } catch (e) {
      print('[Guild] Warning: Failed to get last login for ${member.name}: $e');
    }
  }

  // ignore: unused_element
  void _startPolling() {
    final keys = _members.keys.toList();
    if (keys.isEmpty) return;

    int index = 0;

    Timer.periodic(const Duration(seconds: 10), (timer) async {
      final key = keys[index % keys.length];
      index++;

      await _updateMounts(key);

      if (index % keys.length == 0) {
        await _cacheService.save(_members);
        print('[Guild] Polling cycle complete. Cache saved.');
        _emitChanges();
      }
    });
  }

  void _emitChanges() {
    final ranking = getRanking();
    final newRanks = {
      for (int i = 0; i < ranking.length; i++) ranking[i].key: i + 1,
    };

    // Build old ranking from snapshot to get previous positions
    final oldRanking = _mountSnapshot.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final oldRanks = {
      for (int i = 0; i < oldRanking.length; i++) oldRanking[i].key: i + 1,
    };

    final changes = <MountChange>[];
    for (final member in ranking) {
      final oldCount = _mountSnapshot[member.key] ?? 0;
      final gained = member.mountCount - oldCount;
      if (gained <= 0) continue;

      changes.add(MountChange(
        characterName: member.name,
        gained: gained,
        newTotal: member.mountCount,
        previousRank: oldRanks[member.key] ?? 0,
        newRank: newRanks[member.key] ?? 0,
      ));
    }

    _mountSnapshot = _takeMountSnapshot();

    if (changes.isNotEmpty) {
      _changesController.add(changes);
    }
  }

  Map<String, int> _takeMountSnapshot() => {
        for (final e in _members.entries) e.key: e.value.mountCount,
      };

  /// Simulates mount count changes for testing the announcement pipeline.
  /// Picks up to [count] random members from the current ranking, gives them
  /// fake gains, and fires the changes stream — real data is NOT modified.
  void debugSimulateMountChanges({int count = 5}) {
    final ranking = getRanking();
    if (ranking.isEmpty) return;

    final rng = Random();
    final picked = [...ranking]..shuffle(rng);
    final targets = picked.take(count.clamp(1, ranking.length)).toList();

    final newRanks = {
      for (int i = 0; i < ranking.length; i++) ranking[i].key: i + 1,
    };

    final changes = <MountChange>[];
    for (final member in targets) {
      final gained = rng.nextInt(3) + 1; // 1–3 mounts gained
      changes.add(MountChange(
        characterName: member.name,
        gained: gained,
        newTotal: member.mountCount + gained,
        previousRank: newRanks[member.key]! + (rng.nextInt(5) - 2), // ±2 shift
        newRank: newRanks[member.key]!,
      ));
    }

    changes.sort((a, b) => b.gained.compareTo(a.gained));
    _changesController.add(changes);
    print('[Debug] Simulated ${changes.length} mount changes.');
  }

  /// Finds a member by character name (case-insensitive).
  GuildMember? getMemberByCharacterName(String name) {
    final lower = name.toLowerCase();
    try {
      return _members.values.firstWhere(
        (m) => m.name.toLowerCase() == lower,
      );
    } catch (_) {
      return null;
    }
  }

  /// Returns members sorted by mount count, excluding anyone inactive for 90+ days.
  /// Members with no last login data yet are included (benefit of the doubt).
  List<GuildMember> getRanking() {
    final cutoff = DateTime.now().subtract(_inactiveCutoff);
    return _members.values
        .where((m) => m.lastLogin == null || m.lastLogin!.isAfter(cutoff))
        .toList()
      ..sort((a, b) => b.mountCount.compareTo(a.mountCount));
  }
}
