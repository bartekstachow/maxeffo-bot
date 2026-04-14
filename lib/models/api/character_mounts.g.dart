// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_mounts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharacterMountsResponseImpl _$$CharacterMountsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CharacterMountsResponseImpl(
      mounts: (json['mounts'] as List<dynamic>?)
              ?.map((e) => MountEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CharacterMountsResponseImplToJson(
        _$CharacterMountsResponseImpl instance) =>
    <String, dynamic>{
      'mounts': instance.mounts,
    };

_$MountEntryImpl _$$MountEntryImplFromJson(Map<String, dynamic> json) =>
    _$MountEntryImpl(
      mount: MountRef.fromJson(json['mount'] as Map<String, dynamic>),
      isUseable: json['is_useable'] as bool? ?? false,
    );

Map<String, dynamic> _$$MountEntryImplToJson(_$MountEntryImpl instance) =>
    <String, dynamic>{
      'mount': instance.mount,
      'is_useable': instance.isUseable,
    };

_$MountRefImpl _$$MountRefImplFromJson(Map<String, dynamic> json) =>
    _$MountRefImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$MountRefImplToJson(_$MountRefImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
