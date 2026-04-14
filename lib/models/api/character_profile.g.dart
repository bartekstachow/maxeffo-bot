// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharacterProfileResponseImpl _$$CharacterProfileResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CharacterProfileResponseImpl(
      lastLoginTimestamp: (json['last_login_timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$$CharacterProfileResponseImplToJson(
        _$CharacterProfileResponseImpl instance) =>
    <String, dynamic>{
      'last_login_timestamp': instance.lastLoginTimestamp,
    };
