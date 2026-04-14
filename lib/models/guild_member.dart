import 'package:freezed_annotation/freezed_annotation.dart';

part 'guild_member.freezed.dart';
part 'guild_member.g.dart';

@freezed
class GuildMember with _$GuildMember {
  const GuildMember._();

  const factory GuildMember({
    required String name,
    required String realmSlug,
    required int guildRank,
    @Default(0) int mountCount,
    DateTime? lastUpdated,
    DateTime? lastLogin,
    String? characterClass,
    String? characterRace,
  }) = _GuildMember;

  factory GuildMember.fromJson(Map<String, dynamic> json) =>
      _$GuildMemberFromJson(json);

  String get key => '${name.toLowerCase()}_$realmSlug';
}
