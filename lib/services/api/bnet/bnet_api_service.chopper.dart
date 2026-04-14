// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bnet_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$BnetApiService extends BnetApiService {
  _$BnetApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = BnetApiService;

  @override
  Future<Response<GuildRosterResponse>> getGuildRoster(
    String realmSlug,
    String guildSlug,
  ) {
    final Uri $url =
        Uri.parse('/data/wow/guild/${realmSlug}/${guildSlug}/roster');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GuildRosterResponse, GuildRosterResponse>($request);
  }

  @override
  Future<Response<CharacterMountsResponse>> getCharacterMounts(
    String realmSlug,
    String characterName,
  ) {
    final Uri $url = Uri.parse(
        '/profile/wow/character/${realmSlug}/${characterName}/collections/mounts');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<CharacterMountsResponse, CharacterMountsResponse>($request);
  }

  @override
  Future<Response<CharacterProfileResponse>> getCharacterProfile(
    String realmSlug,
    String characterName,
  ) {
    final Uri $url =
        Uri.parse('/profile/wow/character/${realmSlug}/${characterName}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<CharacterProfileResponse, CharacterProfileResponse>($request);
  }
}
