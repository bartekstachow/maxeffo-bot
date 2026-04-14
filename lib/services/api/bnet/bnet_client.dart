import 'package:chopper/chopper.dart';
import 'package:maxeffo_bot/config.dart';
import 'package:maxeffo_bot/models/api/guild_roster.dart';
import 'package:maxeffo_bot/services/api/bnet/bnet_api_service.dart';
import 'package:maxeffo_bot/services/api/bnet/bnet_converter.dart';
import 'package:maxeffo_bot/services/api/bnet/interceptors/bnet_auth_interceptor.dart';
import 'package:maxeffo_bot/services/api/bnet/interceptors/bnet_query_interceptor.dart';

/// High-level Battle.net API client.
/// Wraps [BnetApiService] with error handling and domain-friendly return types.
class BnetClient {
  final BnetApiService _service;

  BnetClient._(this._service);

  factory BnetClient.fromConfig(Config config) {
    final chopperClient = ChopperClient(
      baseUrl: Uri.parse('https://${config.region}.api.blizzard.com'),
      interceptors: [
        BnetAuthInterceptor(
          clientId: config.bnetClientId,
          clientSecret: config.bnetClientSecret,
        ),
        BnetQueryInterceptor('profile-${config.region}'),
      ],
      converter: const BnetConverter(),
    );

    return BnetClient._(BnetApiService.create(chopperClient));
  }

  Future<List<GuildRosterMember>> getGuildRoster(
      String realmSlug, String guildSlug) async {
    final response = await _service.getGuildRoster(realmSlug, guildSlug);
    _requireSuccess(response, 'guild roster');
    return response.body!.members;
  }

  Future<int> getCharacterMountCount(
      String realmSlug, String characterName) async {
    final response = await _service.getCharacterMounts(
        realmSlug, characterName.toLowerCase());

    // Private profile or character not found — not an error, just no data
    if (response.statusCode == 403 || response.statusCode == 404) return 0;

    _requireSuccess(response, 'mounts for $characterName');
    return response.body!.mountCount;
  }

  Future<DateTime?> getCharacterLastLogin(
      String realmSlug, String characterName) async {
    final response = await _service.getCharacterProfile(
        realmSlug, characterName.toLowerCase());

    if (response.statusCode == 403 || response.statusCode == 404) return null;

    _requireSuccess(response, 'profile for $characterName');
    return response.body!.lastLogin;
  }

  void _requireSuccess(Response<dynamic> response, String context) {
    if (!response.isSuccessful) {
      throw Exception(
          '[BnetClient] Failed to fetch $context (HTTP ${response.statusCode})');
    }
  }
}
