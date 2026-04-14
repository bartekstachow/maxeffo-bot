import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:maxeffo_bot/config.dart';
import 'package:maxeffo_bot/models/guild_member.dart';
import 'package:maxeffo_bot/services/api/raiderio/raiderio_client.dart';
import 'package:maxeffo_bot/services/guild_repository.dart';

const _inactiveCutoff = Duration(days: 90);

class MplusEntry {
  final String characterName;
  final String realmSlug;
  final double score;
  final DateTime lastUpdated;

  const MplusEntry({
    required this.characterName,
    required this.realmSlug,
    required this.score,
    required this.lastUpdated,
  });

  String get key => '${characterName.toLowerCase()}_$realmSlug';
}

class MplusRepository {
  static const _cacheFile = 'cache/mplus.json';
  static const _pollInterval = Duration(hours: 4);
  static const _requestDelay = Duration(milliseconds: 300);

  final Config _config;
  final GuildRepository _guildService;
  final RaiderioClient _client;

  /// key → entry
  Map<String, MplusEntry> _scores = {};
  bool _initialized = false;

  bool get isInitialized => _initialized;

  MplusRepository({required Config config, required GuildRepository guildService})
      : _config = config,
        _guildService = guildService,
        _client = RaiderioClient();

  Future<void> initialize() async {
    await _loadCache();
    _initialized = true;

    // Start background fetch immediately, then poll every 4 hours
    _fetchAll().catchError((Object e) {
      print('[M+] Warning: Initial fetch failed: $e');
    });
    _startPolling();
  }

  List<MplusEntry> getRanking() {
    final activeKeys = _guildService
        .getRanking() // already filters inactive by 90-day cutoff
        .map((m) => m.key)
        .toSet();

    return _scores.values
        .where((e) => activeKeys.contains(e.key) && e.score > 0)
        .toList()
      ..sort((a, b) => b.score.compareTo(a.score));
  }

  Future<void> _fetchAll() async {
    final members = _activeMembers();
    if (members.isEmpty) return;

    print('[M+] Fetching scores for ${members.length} active members...');
    int done = 0;

    for (final member in members) {
      try {
        final score = await _client.getMplusScore(
          _config.region,
          member.realmSlug,
          member.name,
        );

        if (score != null) {
          _scores[member.key] = MplusEntry(
            characterName: member.name,
            realmSlug: member.realmSlug,
            score: score,
            lastUpdated: DateTime.now(),
          );
        } else {
          // Character has no M+ data — store 0 so we don't re-fetch every time
          _scores[member.key] = MplusEntry(
            characterName: member.name,
            realmSlug: member.realmSlug,
            score: 0,
            lastUpdated: DateTime.now(),
          );
        }
      } catch (e) {
        print('[M+] Warning: Failed to fetch score for ${member.name}: $e');
      }

      done++;
      if (done % 20 == 0) {
        print('[M+] Progress: $done/${members.length}');
      }

      await Future<void>.delayed(_requestDelay);
    }

    await _saveCache();
    print('[M+] Fetch complete. ${getRanking().length} players with M+ score.');
  }

  void _startPolling() {
    Timer.periodic(_pollInterval, (_) {
      _fetchAll().catchError((Object e) {
        print('[M+] Warning: Polling fetch failed: $e');
      });
    });
  }

  List<GuildMember> _activeMembers() {
    final cutoff = DateTime.now().subtract(_inactiveCutoff);
    return _guildService.getRanking()
        .where((m) => m.lastLogin == null || m.lastLogin!.isAfter(cutoff))
        .toList();
  }

  Future<void> _loadCache() async {
    final file = File(_cacheFile);
    if (!await file.exists()) return;

    try {
      final raw = await file.readAsString();
      final json = jsonDecode(raw) as Map<String, dynamic>;

      _scores = {
        for (final entry in json.entries)
          entry.key: _entryFromJson(entry.key, entry.value as Map<String, dynamic>),
      };
      print('[M+] Cache loaded: ${_scores.length} entries.');
    } catch (e) {
      print('[M+] Warning: Failed to load cache: $e');
    }
  }

  Future<void> _saveCache() async {
    try {
      final dir = Directory('cache');
      if (!await dir.exists()) await dir.create(recursive: true);

      final data = {
        for (final e in _scores.entries)
          e.key: {
            'name': e.value.characterName,
            'realm': e.value.realmSlug,
            'score': e.value.score,
            'updated': e.value.lastUpdated.toIso8601String(),
          },
      };
      await File(_cacheFile)
          .writeAsString(const JsonEncoder.withIndent('  ').convert(data));
    } catch (e) {
      print('[M+] Warning: Failed to save cache: $e');
    }
  }

  MplusEntry _entryFromJson(String key, Map<String, dynamic> json) => MplusEntry(
        characterName: json['name'] as String,
        realmSlug: json['realm'] as String,
        score: (json['score'] as num).toDouble(),
        lastUpdated: DateTime.parse(json['updated'] as String),
      );
}
