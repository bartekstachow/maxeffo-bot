import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_mounts.freezed.dart';
part 'character_mounts.g.dart';

@freezed
class CharacterMountsResponse with _$CharacterMountsResponse {
  const CharacterMountsResponse._();

  const factory CharacterMountsResponse({
    @Default([]) List<MountEntry> mounts,
  }) = _CharacterMountsResponse;

  factory CharacterMountsResponse.fromJson(Map<String, dynamic> json) =>
      _$CharacterMountsResponseFromJson(json);

  int get mountCount => mounts.length;
}

@freezed
class MountEntry with _$MountEntry {
  const factory MountEntry({
    required MountRef mount,
    @JsonKey(name: 'is_useable') @Default(false) bool isUseable,
  }) = _MountEntry;

  factory MountEntry.fromJson(Map<String, dynamic> json) =>
      _$MountEntryFromJson(json);
}

@freezed
class MountRef with _$MountRef {
  const factory MountRef({
    required int id,
    required String name,
  }) = _MountRef;

  factory MountRef.fromJson(Map<String, dynamic> json) =>
      _$MountRefFromJson(json);
}
