import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:maxeffo_bot/models/api/character_mounts.dart';
import 'package:maxeffo_bot/models/api/character_profile.dart';
import 'package:maxeffo_bot/models/api/guild_roster.dart';

/// Decodes JSON response bodies into typed model objects.
/// Register new response types here as new API endpoints are added.
class BnetConverter implements Converter {
  const BnetConverter();

  @override
  Request convertRequest(Request request) => request;

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(
      Response<dynamic> response) {
    if (response.body is! String || (response.body as String).isEmpty) {
      return response.copyWith<BodyType>(body: null);
    }

    final dynamic decoded = json.decode(response.body as String);

    if (!response.isSuccessful || decoded is! Map<String, dynamic>) {
      return response.copyWith<BodyType>(body: null);
    }

    return response.copyWith<BodyType>(body: _parse<BodyType>(decoded));
  }

  BodyType _parse<BodyType>(Map<String, dynamic> json) {
    if (BodyType == GuildRosterResponse) {
      return GuildRosterResponse.fromJson(json) as BodyType;
    }
    if (BodyType == CharacterMountsResponse) {
      return CharacterMountsResponse.fromJson(json) as BodyType;
    }
    if (BodyType == CharacterProfileResponse) {
      return CharacterProfileResponse.fromJson(json) as BodyType;
    }
    throw UnsupportedError('[BnetConverter] No parser registered for $BodyType');
  }
}
