import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_profile.freezed.dart';
part 'character_profile.g.dart';

@freezed
class CharacterProfileResponse with _$CharacterProfileResponse {
  const CharacterProfileResponse._();

  const factory CharacterProfileResponse({
    @JsonKey(name: 'last_login_timestamp') required int lastLoginTimestamp,
  }) = _CharacterProfileResponse;

  factory CharacterProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$CharacterProfileResponseFromJson(json);

  DateTime get lastLogin =>
      DateTime.fromMillisecondsSinceEpoch(lastLoginTimestamp);
}
