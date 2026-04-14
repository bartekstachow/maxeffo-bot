// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guild_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GuildMemberImpl _$$GuildMemberImplFromJson(Map<String, dynamic> json) =>
    _$GuildMemberImpl(
      name: json['name'] as String,
      realmSlug: json['realmSlug'] as String,
      guildRank: (json['guildRank'] as num).toInt(),
      mountCount: (json['mountCount'] as num?)?.toInt() ?? 0,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
      characterClass: json['characterClass'] as String?,
      characterRace: json['characterRace'] as String?,
    );

Map<String, dynamic> _$$GuildMemberImplToJson(_$GuildMemberImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'realmSlug': instance.realmSlug,
      'guildRank': instance.guildRank,
      'mountCount': instance.mountCount,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'lastLogin': instance.lastLogin?.toIso8601String(),
      'characterClass': instance.characterClass,
      'characterRace': instance.characterRace,
    };
