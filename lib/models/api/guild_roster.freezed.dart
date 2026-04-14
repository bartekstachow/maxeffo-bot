// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guild_roster.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GuildRosterResponse _$GuildRosterResponseFromJson(Map<String, dynamic> json) {
  return _GuildRosterResponse.fromJson(json);
}

/// @nodoc
mixin _$GuildRosterResponse {
  List<GuildRosterMember> get members => throw _privateConstructorUsedError;

  /// Serializes this GuildRosterResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GuildRosterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuildRosterResponseCopyWith<GuildRosterResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuildRosterResponseCopyWith<$Res> {
  factory $GuildRosterResponseCopyWith(
          GuildRosterResponse value, $Res Function(GuildRosterResponse) then) =
      _$GuildRosterResponseCopyWithImpl<$Res, GuildRosterResponse>;
  @useResult
  $Res call({List<GuildRosterMember> members});
}

/// @nodoc
class _$GuildRosterResponseCopyWithImpl<$Res, $Val extends GuildRosterResponse>
    implements $GuildRosterResponseCopyWith<$Res> {
  _$GuildRosterResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuildRosterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? members = null,
  }) {
    return _then(_value.copyWith(
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<GuildRosterMember>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GuildRosterResponseImplCopyWith<$Res>
    implements $GuildRosterResponseCopyWith<$Res> {
  factory _$$GuildRosterResponseImplCopyWith(_$GuildRosterResponseImpl value,
          $Res Function(_$GuildRosterResponseImpl) then) =
      __$$GuildRosterResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GuildRosterMember> members});
}

/// @nodoc
class __$$GuildRosterResponseImplCopyWithImpl<$Res>
    extends _$GuildRosterResponseCopyWithImpl<$Res, _$GuildRosterResponseImpl>
    implements _$$GuildRosterResponseImplCopyWith<$Res> {
  __$$GuildRosterResponseImplCopyWithImpl(_$GuildRosterResponseImpl _value,
      $Res Function(_$GuildRosterResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GuildRosterResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? members = null,
  }) {
    return _then(_$GuildRosterResponseImpl(
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<GuildRosterMember>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GuildRosterResponseImpl implements _GuildRosterResponse {
  const _$GuildRosterResponseImpl(
      {required final List<GuildRosterMember> members})
      : _members = members;

  factory _$GuildRosterResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuildRosterResponseImplFromJson(json);

  final List<GuildRosterMember> _members;
  @override
  List<GuildRosterMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'GuildRosterResponse(members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuildRosterResponseImpl &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_members));

  /// Create a copy of GuildRosterResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuildRosterResponseImplCopyWith<_$GuildRosterResponseImpl> get copyWith =>
      __$$GuildRosterResponseImplCopyWithImpl<_$GuildRosterResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GuildRosterResponseImplToJson(
      this,
    );
  }
}

abstract class _GuildRosterResponse implements GuildRosterResponse {
  const factory _GuildRosterResponse(
          {required final List<GuildRosterMember> members}) =
      _$GuildRosterResponseImpl;

  factory _GuildRosterResponse.fromJson(Map<String, dynamic> json) =
      _$GuildRosterResponseImpl.fromJson;

  @override
  List<GuildRosterMember> get members;

  /// Create a copy of GuildRosterResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuildRosterResponseImplCopyWith<_$GuildRosterResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GuildRosterMember _$GuildRosterMemberFromJson(Map<String, dynamic> json) {
  return _GuildRosterMember.fromJson(json);
}

/// @nodoc
mixin _$GuildRosterMember {
  GuildCharacterRef get character => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;

  /// Serializes this GuildRosterMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GuildRosterMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuildRosterMemberCopyWith<GuildRosterMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuildRosterMemberCopyWith<$Res> {
  factory $GuildRosterMemberCopyWith(
          GuildRosterMember value, $Res Function(GuildRosterMember) then) =
      _$GuildRosterMemberCopyWithImpl<$Res, GuildRosterMember>;
  @useResult
  $Res call({GuildCharacterRef character, int rank});

  $GuildCharacterRefCopyWith<$Res> get character;
}

/// @nodoc
class _$GuildRosterMemberCopyWithImpl<$Res, $Val extends GuildRosterMember>
    implements $GuildRosterMemberCopyWith<$Res> {
  _$GuildRosterMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuildRosterMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? character = null,
    Object? rank = null,
  }) {
    return _then(_value.copyWith(
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as GuildCharacterRef,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of GuildRosterMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GuildCharacterRefCopyWith<$Res> get character {
    return $GuildCharacterRefCopyWith<$Res>(_value.character, (value) {
      return _then(_value.copyWith(character: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GuildRosterMemberImplCopyWith<$Res>
    implements $GuildRosterMemberCopyWith<$Res> {
  factory _$$GuildRosterMemberImplCopyWith(_$GuildRosterMemberImpl value,
          $Res Function(_$GuildRosterMemberImpl) then) =
      __$$GuildRosterMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GuildCharacterRef character, int rank});

  @override
  $GuildCharacterRefCopyWith<$Res> get character;
}

/// @nodoc
class __$$GuildRosterMemberImplCopyWithImpl<$Res>
    extends _$GuildRosterMemberCopyWithImpl<$Res, _$GuildRosterMemberImpl>
    implements _$$GuildRosterMemberImplCopyWith<$Res> {
  __$$GuildRosterMemberImplCopyWithImpl(_$GuildRosterMemberImpl _value,
      $Res Function(_$GuildRosterMemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of GuildRosterMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? character = null,
    Object? rank = null,
  }) {
    return _then(_$GuildRosterMemberImpl(
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as GuildCharacterRef,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GuildRosterMemberImpl implements _GuildRosterMember {
  const _$GuildRosterMemberImpl({required this.character, required this.rank});

  factory _$GuildRosterMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuildRosterMemberImplFromJson(json);

  @override
  final GuildCharacterRef character;
  @override
  final int rank;

  @override
  String toString() {
    return 'GuildRosterMember(character: $character, rank: $rank)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuildRosterMemberImpl &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.rank, rank) || other.rank == rank));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, character, rank);

  /// Create a copy of GuildRosterMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuildRosterMemberImplCopyWith<_$GuildRosterMemberImpl> get copyWith =>
      __$$GuildRosterMemberImplCopyWithImpl<_$GuildRosterMemberImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GuildRosterMemberImplToJson(
      this,
    );
  }
}

abstract class _GuildRosterMember implements GuildRosterMember {
  const factory _GuildRosterMember(
      {required final GuildCharacterRef character,
      required final int rank}) = _$GuildRosterMemberImpl;

  factory _GuildRosterMember.fromJson(Map<String, dynamic> json) =
      _$GuildRosterMemberImpl.fromJson;

  @override
  GuildCharacterRef get character;
  @override
  int get rank;

  /// Create a copy of GuildRosterMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuildRosterMemberImplCopyWith<_$GuildRosterMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GuildCharacterRef _$GuildCharacterRefFromJson(Map<String, dynamic> json) {
  return _GuildCharacterRef.fromJson(json);
}

/// @nodoc
mixin _$GuildCharacterRef {
  String get name => throw _privateConstructorUsedError;
  RealmRef get realm => throw _privateConstructorUsedError;
  @JsonKey(name: 'playable_class')
  ClassRef? get playableClass => throw _privateConstructorUsedError;
  @JsonKey(name: 'playable_race')
  RaceRef? get playableRace => throw _privateConstructorUsedError;

  /// Serializes this GuildCharacterRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GuildCharacterRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuildCharacterRefCopyWith<GuildCharacterRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuildCharacterRefCopyWith<$Res> {
  factory $GuildCharacterRefCopyWith(
          GuildCharacterRef value, $Res Function(GuildCharacterRef) then) =
      _$GuildCharacterRefCopyWithImpl<$Res, GuildCharacterRef>;
  @useResult
  $Res call(
      {String name,
      RealmRef realm,
      @JsonKey(name: 'playable_class') ClassRef? playableClass,
      @JsonKey(name: 'playable_race') RaceRef? playableRace});

  $RealmRefCopyWith<$Res> get realm;
  $ClassRefCopyWith<$Res>? get playableClass;
  $RaceRefCopyWith<$Res>? get playableRace;
}

/// @nodoc
class _$GuildCharacterRefCopyWithImpl<$Res, $Val extends GuildCharacterRef>
    implements $GuildCharacterRefCopyWith<$Res> {
  _$GuildCharacterRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuildCharacterRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? realm = null,
    Object? playableClass = freezed,
    Object? playableRace = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      realm: null == realm
          ? _value.realm
          : realm // ignore: cast_nullable_to_non_nullable
              as RealmRef,
      playableClass: freezed == playableClass
          ? _value.playableClass
          : playableClass // ignore: cast_nullable_to_non_nullable
              as ClassRef?,
      playableRace: freezed == playableRace
          ? _value.playableRace
          : playableRace // ignore: cast_nullable_to_non_nullable
              as RaceRef?,
    ) as $Val);
  }

  /// Create a copy of GuildCharacterRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RealmRefCopyWith<$Res> get realm {
    return $RealmRefCopyWith<$Res>(_value.realm, (value) {
      return _then(_value.copyWith(realm: value) as $Val);
    });
  }

  /// Create a copy of GuildCharacterRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClassRefCopyWith<$Res>? get playableClass {
    if (_value.playableClass == null) {
      return null;
    }

    return $ClassRefCopyWith<$Res>(_value.playableClass!, (value) {
      return _then(_value.copyWith(playableClass: value) as $Val);
    });
  }

  /// Create a copy of GuildCharacterRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RaceRefCopyWith<$Res>? get playableRace {
    if (_value.playableRace == null) {
      return null;
    }

    return $RaceRefCopyWith<$Res>(_value.playableRace!, (value) {
      return _then(_value.copyWith(playableRace: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GuildCharacterRefImplCopyWith<$Res>
    implements $GuildCharacterRefCopyWith<$Res> {
  factory _$$GuildCharacterRefImplCopyWith(_$GuildCharacterRefImpl value,
          $Res Function(_$GuildCharacterRefImpl) then) =
      __$$GuildCharacterRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      RealmRef realm,
      @JsonKey(name: 'playable_class') ClassRef? playableClass,
      @JsonKey(name: 'playable_race') RaceRef? playableRace});

  @override
  $RealmRefCopyWith<$Res> get realm;
  @override
  $ClassRefCopyWith<$Res>? get playableClass;
  @override
  $RaceRefCopyWith<$Res>? get playableRace;
}

/// @nodoc
class __$$GuildCharacterRefImplCopyWithImpl<$Res>
    extends _$GuildCharacterRefCopyWithImpl<$Res, _$GuildCharacterRefImpl>
    implements _$$GuildCharacterRefImplCopyWith<$Res> {
  __$$GuildCharacterRefImplCopyWithImpl(_$GuildCharacterRefImpl _value,
      $Res Function(_$GuildCharacterRefImpl) _then)
      : super(_value, _then);

  /// Create a copy of GuildCharacterRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? realm = null,
    Object? playableClass = freezed,
    Object? playableRace = freezed,
  }) {
    return _then(_$GuildCharacterRefImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      realm: null == realm
          ? _value.realm
          : realm // ignore: cast_nullable_to_non_nullable
              as RealmRef,
      playableClass: freezed == playableClass
          ? _value.playableClass
          : playableClass // ignore: cast_nullable_to_non_nullable
              as ClassRef?,
      playableRace: freezed == playableRace
          ? _value.playableRace
          : playableRace // ignore: cast_nullable_to_non_nullable
              as RaceRef?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GuildCharacterRefImpl implements _GuildCharacterRef {
  const _$GuildCharacterRefImpl(
      {required this.name,
      required this.realm,
      @JsonKey(name: 'playable_class') this.playableClass,
      @JsonKey(name: 'playable_race') this.playableRace});

  factory _$GuildCharacterRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuildCharacterRefImplFromJson(json);

  @override
  final String name;
  @override
  final RealmRef realm;
  @override
  @JsonKey(name: 'playable_class')
  final ClassRef? playableClass;
  @override
  @JsonKey(name: 'playable_race')
  final RaceRef? playableRace;

  @override
  String toString() {
    return 'GuildCharacterRef(name: $name, realm: $realm, playableClass: $playableClass, playableRace: $playableRace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuildCharacterRefImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.realm, realm) || other.realm == realm) &&
            (identical(other.playableClass, playableClass) ||
                other.playableClass == playableClass) &&
            (identical(other.playableRace, playableRace) ||
                other.playableRace == playableRace));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, realm, playableClass, playableRace);

  /// Create a copy of GuildCharacterRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuildCharacterRefImplCopyWith<_$GuildCharacterRefImpl> get copyWith =>
      __$$GuildCharacterRefImplCopyWithImpl<_$GuildCharacterRefImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GuildCharacterRefImplToJson(
      this,
    );
  }
}

abstract class _GuildCharacterRef implements GuildCharacterRef {
  const factory _GuildCharacterRef(
          {required final String name,
          required final RealmRef realm,
          @JsonKey(name: 'playable_class') final ClassRef? playableClass,
          @JsonKey(name: 'playable_race') final RaceRef? playableRace}) =
      _$GuildCharacterRefImpl;

  factory _GuildCharacterRef.fromJson(Map<String, dynamic> json) =
      _$GuildCharacterRefImpl.fromJson;

  @override
  String get name;
  @override
  RealmRef get realm;
  @override
  @JsonKey(name: 'playable_class')
  ClassRef? get playableClass;
  @override
  @JsonKey(name: 'playable_race')
  RaceRef? get playableRace;

  /// Create a copy of GuildCharacterRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuildCharacterRefImplCopyWith<_$GuildCharacterRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClassRef _$ClassRefFromJson(Map<String, dynamic> json) {
  return _ClassRef.fromJson(json);
}

/// @nodoc
mixin _$ClassRef {
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this ClassRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassRefCopyWith<ClassRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassRefCopyWith<$Res> {
  factory $ClassRefCopyWith(ClassRef value, $Res Function(ClassRef) then) =
      _$ClassRefCopyWithImpl<$Res, ClassRef>;
  @useResult
  $Res call({String? name});
}

/// @nodoc
class _$ClassRefCopyWithImpl<$Res, $Val extends ClassRef>
    implements $ClassRefCopyWith<$Res> {
  _$ClassRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassRefImplCopyWith<$Res>
    implements $ClassRefCopyWith<$Res> {
  factory _$$ClassRefImplCopyWith(
          _$ClassRefImpl value, $Res Function(_$ClassRefImpl) then) =
      __$$ClassRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name});
}

/// @nodoc
class __$$ClassRefImplCopyWithImpl<$Res>
    extends _$ClassRefCopyWithImpl<$Res, _$ClassRefImpl>
    implements _$$ClassRefImplCopyWith<$Res> {
  __$$ClassRefImplCopyWithImpl(
      _$ClassRefImpl _value, $Res Function(_$ClassRefImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClassRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$ClassRefImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassRefImpl implements _ClassRef {
  const _$ClassRefImpl({this.name});

  factory _$ClassRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassRefImplFromJson(json);

  @override
  final String? name;

  @override
  String toString() {
    return 'ClassRef(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassRefImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of ClassRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassRefImplCopyWith<_$ClassRefImpl> get copyWith =>
      __$$ClassRefImplCopyWithImpl<_$ClassRefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassRefImplToJson(
      this,
    );
  }
}

abstract class _ClassRef implements ClassRef {
  const factory _ClassRef({final String? name}) = _$ClassRefImpl;

  factory _ClassRef.fromJson(Map<String, dynamic> json) =
      _$ClassRefImpl.fromJson;

  @override
  String? get name;

  /// Create a copy of ClassRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassRefImplCopyWith<_$ClassRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RaceRef _$RaceRefFromJson(Map<String, dynamic> json) {
  return _RaceRef.fromJson(json);
}

/// @nodoc
mixin _$RaceRef {
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this RaceRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RaceRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RaceRefCopyWith<RaceRef> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RaceRefCopyWith<$Res> {
  factory $RaceRefCopyWith(RaceRef value, $Res Function(RaceRef) then) =
      _$RaceRefCopyWithImpl<$Res, RaceRef>;
  @useResult
  $Res call({String? name});
}

/// @nodoc
class _$RaceRefCopyWithImpl<$Res, $Val extends RaceRef>
    implements $RaceRefCopyWith<$Res> {
  _$RaceRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RaceRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RaceRefImplCopyWith<$Res> implements $RaceRefCopyWith<$Res> {
  factory _$$RaceRefImplCopyWith(
          _$RaceRefImpl value, $Res Function(_$RaceRefImpl) then) =
      __$$RaceRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name});
}

/// @nodoc
class __$$RaceRefImplCopyWithImpl<$Res>
    extends _$RaceRefCopyWithImpl<$Res, _$RaceRefImpl>
    implements _$$RaceRefImplCopyWith<$Res> {
  __$$RaceRefImplCopyWithImpl(
      _$RaceRefImpl _value, $Res Function(_$RaceRefImpl) _then)
      : super(_value, _then);

  /// Create a copy of RaceRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$RaceRefImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RaceRefImpl implements _RaceRef {
  const _$RaceRefImpl({this.name});

  factory _$RaceRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$RaceRefImplFromJson(json);

  @override
  final String? name;

  @override
  String toString() {
    return 'RaceRef(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RaceRefImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of RaceRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RaceRefImplCopyWith<_$RaceRefImpl> get copyWith =>
      __$$RaceRefImplCopyWithImpl<_$RaceRefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RaceRefImplToJson(
      this,
    );
  }
}

abstract class _RaceRef implements RaceRef {
  const factory _RaceRef({final String? name}) = _$RaceRefImpl;

  factory _RaceRef.fromJson(Map<String, dynamic> json) = _$RaceRefImpl.fromJson;

  @override
  String? get name;

  /// Create a copy of RaceRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RaceRefImplCopyWith<_$RaceRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RealmRef _$RealmRefFromJson(Map<String, dynamic> json) {
  return _RealmRef.fromJson(json);
}

/// @nodoc
mixin _$RealmRef {
  String get slug => throw _privateConstructorUsedError;

  /// Serializes this RealmRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RealmRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RealmRefCopyWith<RealmRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RealmRefCopyWith<$Res> {
  factory $RealmRefCopyWith(RealmRef value, $Res Function(RealmRef) then) =
      _$RealmRefCopyWithImpl<$Res, RealmRef>;
  @useResult
  $Res call({String slug});
}

/// @nodoc
class _$RealmRefCopyWithImpl<$Res, $Val extends RealmRef>
    implements $RealmRefCopyWith<$Res> {
  _$RealmRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RealmRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
  }) {
    return _then(_value.copyWith(
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RealmRefImplCopyWith<$Res>
    implements $RealmRefCopyWith<$Res> {
  factory _$$RealmRefImplCopyWith(
          _$RealmRefImpl value, $Res Function(_$RealmRefImpl) then) =
      __$$RealmRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String slug});
}

/// @nodoc
class __$$RealmRefImplCopyWithImpl<$Res>
    extends _$RealmRefCopyWithImpl<$Res, _$RealmRefImpl>
    implements _$$RealmRefImplCopyWith<$Res> {
  __$$RealmRefImplCopyWithImpl(
      _$RealmRefImpl _value, $Res Function(_$RealmRefImpl) _then)
      : super(_value, _then);

  /// Create a copy of RealmRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
  }) {
    return _then(_$RealmRefImpl(
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RealmRefImpl implements _RealmRef {
  const _$RealmRefImpl({required this.slug});

  factory _$RealmRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$RealmRefImplFromJson(json);

  @override
  final String slug;

  @override
  String toString() {
    return 'RealmRef(slug: $slug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RealmRefImpl &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, slug);

  /// Create a copy of RealmRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RealmRefImplCopyWith<_$RealmRefImpl> get copyWith =>
      __$$RealmRefImplCopyWithImpl<_$RealmRefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RealmRefImplToJson(
      this,
    );
  }
}

abstract class _RealmRef implements RealmRef {
  const factory _RealmRef({required final String slug}) = _$RealmRefImpl;

  factory _RealmRef.fromJson(Map<String, dynamic> json) =
      _$RealmRefImpl.fromJson;

  @override
  String get slug;

  /// Create a copy of RealmRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RealmRefImplCopyWith<_$RealmRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
