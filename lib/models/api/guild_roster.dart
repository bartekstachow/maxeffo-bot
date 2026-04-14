import 'package:freezed_annotation/freezed_annotation.dart';

part 'guild_roster.freezed.dart';

part 'guild_roster.g.dart';

@freezed
class GuildRosterResponse with _$GuildRosterResponse {
  const factory GuildRosterResponse({
    required List<GuildRosterMember> members,
  }) = _GuildRosterResponse;

  factory GuildRosterResponse.fromJson(Map<String, dynamic> json) =>
      _$GuildRosterResponseFromJson(json);
}

@freezed
class GuildRosterMember with _$GuildRosterMember {
  const factory GuildRosterMember({
    required GuildCharacterRef character,
    required int rank,
  }) = _GuildRosterMember;

  factory GuildRosterMember.fromJson(Map<String, dynamic> json) =>
      _$GuildRosterMemberFromJson(json);
}

@freezed
class GuildCharacterRef with _$GuildCharacterRef {
  const factory GuildCharacterRef({
    required String name,
    required RealmRef realm,
    @JsonKey(name: 'playable_class') ClassRef? playableClass,
    @JsonKey(name: 'playable_race') RaceRef? playableRace,
  }) = _GuildCharacterRef;

  factory GuildCharacterRef.fromJson(Map<String, dynamic> json) =>
      _$GuildCharacterRefFromJson(json);
}

@freezed
class ClassRef with _$ClassRef {
  const factory ClassRef({
    String? name,
  }) = _ClassRef;

  factory ClassRef.fromJson(Map<String, dynamic> json) =>
      _$ClassRefFromJson(json);
}

@freezed
class RaceRef with _$RaceRef {
  const factory RaceRef({
    String? name,
  }) = _RaceRef;

  factory RaceRef.fromJson(Map<String, dynamic> json) =>
      _$RaceRefFromJson(json);
}

@freezed
class RealmRef with _$RealmRef {
  const factory RealmRef({
    required String slug,
  }) = _RealmRef;

  factory RealmRef.fromJson(Map<String, dynamic> json) =>
      _$RealmRefFromJson(json);
}
