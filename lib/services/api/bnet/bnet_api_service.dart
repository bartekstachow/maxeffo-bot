import 'package:chopper/chopper.dart';
import 'package:maxeffo_bot/models/api/character_mounts.dart';
import 'package:maxeffo_bot/models/api/character_profile.dart';
import 'package:maxeffo_bot/models/api/guild_roster.dart';

part 'bnet_api_service.chopper.dart';

/// Chopper service for the Battle.net / WoW Profile API.
/// Add new endpoints here as new bot features are implemented.
@ChopperApi()
abstract class BnetApiService extends ChopperService {
  static BnetApiService create(ChopperClient client) =>
      _$BnetApiService(client);

  @GET(path: '/data/wow/guild/{realmSlug}/{guildSlug}/roster')
  Future<Response<GuildRosterResponse>> getGuildRoster(
    @Path('realmSlug') String realmSlug,
    @Path('guildSlug') String guildSlug,
  );

  @GET(
      path:
          '/profile/wow/character/{realmSlug}/{characterName}/collections/mounts')
  Future<Response<CharacterMountsResponse>> getCharacterMounts(
    @Path('realmSlug') String realmSlug,
    @Path('characterName') String characterName,
  );

  @GET(path: '/profile/wow/character/{realmSlug}/{characterName}')
  Future<Response<CharacterProfileResponse>> getCharacterProfile(
    @Path('realmSlug') String realmSlug,
    @Path('characterName') String characterName,
  );
}
