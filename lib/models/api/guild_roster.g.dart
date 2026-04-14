// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guild_roster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GuildRosterResponseImpl _$$GuildRosterResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GuildRosterResponseImpl(
      members: (json['members'] as List<dynamic>)
          .map((e) => GuildRosterMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GuildRosterResponseImplToJson(
        _$GuildRosterResponseImpl instance) =>
    <String, dynamic>{
      'members': instance.members,
    };

_$GuildRosterMemberImpl _$$GuildRosterMemberImplFromJson(
        Map<String, dynamic> json) =>
    _$GuildRosterMemberImpl(
      character:
          GuildCharacterRef.fromJson(json['character'] as Map<String, dynamic>),
      rank: (json['rank'] as num).toInt(),
    );

Map<String, dynamic> _$$GuildRosterMemberImplToJson(
        _$GuildRosterMemberImpl instance) =>
    <String, dynamic>{
      'character': instance.character,
      'rank': instance.rank,
    };

_$GuildCharacterRefImpl _$$GuildCharacterRefImplFromJson(
        Map<String, dynamic> json) =>
    _$GuildCharacterRefImpl(
      name: json['name'] as String,
      realm: RealmRef.fromJson(json['realm'] as Map<String, dynamic>),
      playableClass: json['playable_class'] == null
          ? null
          : ClassRef.fromJson(json['playable_class'] as Map<String, dynamic>),
      playableRace: json['playable_race'] == null
          ? null
          : RaceRef.fromJson(json['playable_race'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GuildCharacterRefImplToJson(
        _$GuildCharacterRefImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'realm': instance.realm,
      'playable_class': instance.playableClass,
      'playable_race': instance.playableRace,
    };

_$ClassRefImpl _$$ClassRefImplFromJson(Map<String, dynamic> json) =>
    _$ClassRefImpl(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$ClassRefImplToJson(_$ClassRefImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

_$RaceRefImpl _$$RaceRefImplFromJson(Map<String, dynamic> json) =>
    _$RaceRefImpl(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$RaceRefImplToJson(_$RaceRefImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

_$RealmRefImpl _$$RealmRefImplFromJson(Map<String, dynamic> json) =>
    _$RealmRefImpl(
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$$RealmRefImplToJson(_$RealmRefImpl instance) =>
    <String, dynamic>{
      'slug': instance.slug,
    };
