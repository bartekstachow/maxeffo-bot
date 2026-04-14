// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guild_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GuildMember _$GuildMemberFromJson(Map<String, dynamic> json) {
  return _GuildMember.fromJson(json);
}

/// @nodoc
mixin _$GuildMember {
  String get name => throw _privateConstructorUsedError;
  String get realmSlug => throw _privateConstructorUsedError;
  int get guildRank => throw _privateConstructorUsedError;
  int get mountCount => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  DateTime? get lastLogin => throw _privateConstructorUsedError;
  String? get characterClass => throw _privateConstructorUsedError;
  String? get characterRace => throw _privateConstructorUsedError;

  /// Serializes this GuildMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GuildMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuildMemberCopyWith<GuildMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuildMemberCopyWith<$Res> {
  factory $GuildMemberCopyWith(
          GuildMember value, $Res Function(GuildMember) then) =
      _$GuildMemberCopyWithImpl<$Res, GuildMember>;
  @useResult
  $Res call(
      {String name,
      String realmSlug,
      int guildRank,
      int mountCount,
      DateTime? lastUpdated,
      DateTime? lastLogin,
      String? characterClass,
      String? characterRace});
}

/// @nodoc
class _$GuildMemberCopyWithImpl<$Res, $Val extends GuildMember>
    implements $GuildMemberCopyWith<$Res> {
  _$GuildMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuildMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? realmSlug = null,
    Object? guildRank = null,
    Object? mountCount = null,
    Object? lastUpdated = freezed,
    Object? lastLogin = freezed,
    Object? characterClass = freezed,
    Object? characterRace = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      realmSlug: null == realmSlug
          ? _value.realmSlug
          : realmSlug // ignore: cast_nullable_to_non_nullable
              as String,
      guildRank: null == guildRank
          ? _value.guildRank
          : guildRank // ignore: cast_nullable_to_non_nullable
              as int,
      mountCount: null == mountCount
          ? _value.mountCount
          : mountCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      characterClass: freezed == characterClass
          ? _value.characterClass
          : characterClass // ignore: cast_nullable_to_non_nullable
              as String?,
      characterRace: freezed == characterRace
          ? _value.characterRace
          : characterRace // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GuildMemberImplCopyWith<$Res>
    implements $GuildMemberCopyWith<$Res> {
  factory _$$GuildMemberImplCopyWith(
          _$GuildMemberImpl value, $Res Function(_$GuildMemberImpl) then) =
      __$$GuildMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String realmSlug,
      int guildRank,
      int mountCount,
      DateTime? lastUpdated,
      DateTime? lastLogin,
      String? characterClass,
      String? characterRace});
}

/// @nodoc
class __$$GuildMemberImplCopyWithImpl<$Res>
    extends _$GuildMemberCopyWithImpl<$Res, _$GuildMemberImpl>
    implements _$$GuildMemberImplCopyWith<$Res> {
  __$$GuildMemberImplCopyWithImpl(
      _$GuildMemberImpl _value, $Res Function(_$GuildMemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of GuildMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? realmSlug = null,
    Object? guildRank = null,
    Object? mountCount = null,
    Object? lastUpdated = freezed,
    Object? lastLogin = freezed,
    Object? characterClass = freezed,
    Object? characterRace = freezed,
  }) {
    return _then(_$GuildMemberImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      realmSlug: null == realmSlug
          ? _value.realmSlug
          : realmSlug // ignore: cast_nullable_to_non_nullable
              as String,
      guildRank: null == guildRank
          ? _value.guildRank
          : guildRank // ignore: cast_nullable_to_non_nullable
              as int,
      mountCount: null == mountCount
          ? _value.mountCount
          : mountCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      characterClass: freezed == characterClass
          ? _value.characterClass
          : characterClass // ignore: cast_nullable_to_non_nullable
              as String?,
      characterRace: freezed == characterRace
          ? _value.characterRace
          : characterRace // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GuildMemberImpl extends _GuildMember {
  const _$GuildMemberImpl(
      {required this.name,
      required this.realmSlug,
      required this.guildRank,
      this.mountCount = 0,
      this.lastUpdated,
      this.lastLogin,
      this.characterClass,
      this.characterRace})
      : super._();

  factory _$GuildMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuildMemberImplFromJson(json);

  @override
  final String name;
  @override
  final String realmSlug;
  @override
  final int guildRank;
  @override
  @JsonKey()
  final int mountCount;
  @override
  final DateTime? lastUpdated;
  @override
  final DateTime? lastLogin;
  @override
  final String? characterClass;
  @override
  final String? characterRace;

  @override
  String toString() {
    return 'GuildMember(name: $name, realmSlug: $realmSlug, guildRank: $guildRank, mountCount: $mountCount, lastUpdated: $lastUpdated, lastLogin: $lastLogin, characterClass: $characterClass, characterRace: $characterRace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuildMemberImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.realmSlug, realmSlug) ||
                other.realmSlug == realmSlug) &&
            (identical(other.guildRank, guildRank) ||
                other.guildRank == guildRank) &&
            (identical(other.mountCount, mountCount) ||
                other.mountCount == mountCount) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            (identical(other.characterClass, characterClass) ||
                other.characterClass == characterClass) &&
            (identical(other.characterRace, characterRace) ||
                other.characterRace == characterRace));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, realmSlug, guildRank,
      mountCount, lastUpdated, lastLogin, characterClass, characterRace);

  /// Create a copy of GuildMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuildMemberImplCopyWith<_$GuildMemberImpl> get copyWith =>
      __$$GuildMemberImplCopyWithImpl<_$GuildMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GuildMemberImplToJson(
      this,
    );
  }
}

abstract class _GuildMember extends GuildMember {
  const factory _GuildMember(
      {required final String name,
      required final String realmSlug,
      required final int guildRank,
      final int mountCount,
      final DateTime? lastUpdated,
      final DateTime? lastLogin,
      final String? characterClass,
      final String? characterRace}) = _$GuildMemberImpl;
  const _GuildMember._() : super._();

  factory _GuildMember.fromJson(Map<String, dynamic> json) =
      _$GuildMemberImpl.fromJson;

  @override
  String get name;
  @override
  String get realmSlug;
  @override
  int get guildRank;
  @override
  int get mountCount;
  @override
  DateTime? get lastUpdated;
  @override
  DateTime? get lastLogin;
  @override
  String? get characterClass;
  @override
  String? get characterRace;

  /// Create a copy of GuildMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuildMemberImplCopyWith<_$GuildMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
