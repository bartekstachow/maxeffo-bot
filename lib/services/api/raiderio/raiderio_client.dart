import 'dart:convert';
import 'package:http/http.dart' as http;

class CharacterDetails {
  final int? itemLevelEquipped;
  final int? itemLevelTotal;
  final double? mplusScore;

  const CharacterDetails({
    this.itemLevelEquipped,
    this.itemLevelTotal,
    this.mplusScore,
  });
}

class RaidProgression {
  final String slug;
  final String summary;
  final int totalBosses;
  final int normalKilled;
  final int heroicKilled;
  final int mythicKilled;

  const RaidProgression({
    required this.slug,
    required this.summary,
    required this.totalBosses,
    required this.normalKilled,
    required this.heroicKilled,
    required this.mythicKilled,
  });
}

class RaiderioClient {
  static const _baseUrl = 'https://raider.io/api/v1';

  /// Returns the overall M+ score for the current season.
  /// Returns null if the character has no M+ data or is not found.
  Future<double?> getMplusScore(String region, String realm, String name) async {
    final uri = Uri.parse('$_baseUrl/characters/profile').replace(
      queryParameters: {
        'region': region,
        'realm': realm,
        'name': name,
        'fields': 'mythic_plus_scores_by_season:current',
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 404) return null;

    if (response.statusCode != 200) {
      throw Exception('[Raider.io] API error (${response.statusCode}) for $name: ${response.body}');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    final seasons = data['mythic_plus_scores_by_season'] as List<dynamic>?;

    if (seasons == null || seasons.isEmpty) return null;

    final current = seasons.first as Map<String, dynamic>;
    final scores = current['scores'] as Map<String, dynamic>?;

    if (scores == null) return null;

    final all = scores['all'];
    if (all == null) return null;
    return (all as num).toDouble();
  }

  /// Returns character ilvl and M+ score in one call.
  /// Returns null if the character is not found on raider.io.
  Future<CharacterDetails?> getCharacterDetails(
      String region, String realm, String name) async {
    final uri = Uri.parse('$_baseUrl/characters/profile').replace(
      queryParameters: {
        'region': region,
        'realm': realm,
        'name': name,
        'fields': 'gear,mythic_plus_scores_by_season:current',
      },
    );

    final response = await http.get(uri);
    if (response.statusCode == 404) return null;
    if (response.statusCode != 200) {
      throw Exception(
          '[Raider.io] API error (${response.statusCode}) for $name: ${response.body}');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;

    final gear = data['gear'] as Map<String, dynamic>?;
    final seasons = data['mythic_plus_scores_by_season'] as List<dynamic>?;

    double? mplusScore;
    if (seasons != null && seasons.isNotEmpty) {
      final scores =
          (seasons.first as Map<String, dynamic>)['scores'] as Map<String, dynamic>?;
      final all = scores?['all'];
      if (all != null) mplusScore = (all as num).toDouble();
    }

    return CharacterDetails(
      itemLevelEquipped: gear?['item_level_equipped'] as int?,
      itemLevelTotal: gear?['item_level_total'] as int?,
      mplusScore: mplusScore,
    );
  }

  /// Returns guild raid progression, newest raid first.
  Future<List<RaidProgression>> getGuildProgression(
      String region, String realm, String guildSlug) async {
    final uri = Uri.parse('$_baseUrl/guilds/profile').replace(
      queryParameters: {
        'region': region,
        'realm': realm,
        'name': guildSlug,
        'fields': 'raid_progression',
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 404) return [];

    if (response.statusCode != 200) {
      throw Exception(
          '[Raider.io] Guild API error (${response.statusCode}): ${response.body}');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    final progression =
        data['raid_progression'] as Map<String, dynamic>? ?? {};

    final results = progression.entries.map((e) {
      final r = e.value as Map<String, dynamic>;
      return RaidProgression(
        slug: e.key,
        summary: r['summary'] as String? ?? '',
        totalBosses: (r['total_bosses'] as int?) ?? 0,
        normalKilled: (r['normal_bosses_killed'] as int?) ?? 0,
        heroicKilled: (r['heroic_bosses_killed'] as int?) ?? 0,
        mythicKilled: (r['mythic_bosses_killed'] as int?) ?? 0,
      );
    }).toList();

    // Sort by known raid priority list; unknown raids go at the bottom
    results.sort((a, b) {
      final ai = _raidOrder.indexOf(a.slug);
      final bi = _raidOrder.indexOf(b.slug);
      final ar = ai == -1 ? 999 : ai;
      final br = bi == -1 ? 999 : bi;
      return ar.compareTo(br);
    });

    return results;
  }

  // Newest to oldest — add new tiers at the top
  static const _raidOrder = [
    'liberation-of-undermine',
    'nerub-ar-palace',
    'amirdrassil-the-dreams-hope',
    'aberrus-the-shadowed-crucible',
    'vault-of-the-incarnates',
    'sepulcher-of-the-first-ones',
    'sanctum-of-domination',
    'castle-nathria',
  ];
}
