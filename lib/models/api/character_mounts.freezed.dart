// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_mounts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CharacterMountsResponse _$CharacterMountsResponseFromJson(
    Map<String, dynamic> json) {
  return _CharacterMountsResponse.fromJson(json);
}

/// @nodoc
mixin _$CharacterMountsResponse {
  List<MountEntry> get mounts => throw _privateConstructorUsedError;

  /// Serializes this CharacterMountsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharacterMountsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterMountsResponseCopyWith<CharacterMountsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterMountsResponseCopyWith<$Res> {
  factory $CharacterMountsResponseCopyWith(CharacterMountsResponse value,
          $Res Function(CharacterMountsResponse) then) =
      _$CharacterMountsResponseCopyWithImpl<$Res, CharacterMountsResponse>;
  @useResult
  $Res call({List<MountEntry> mounts});
}

/// @nodoc
class _$CharacterMountsResponseCopyWithImpl<$Res,
        $Val extends CharacterMountsResponse>
    implements $CharacterMountsResponseCopyWith<$Res> {
  _$CharacterMountsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterMountsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mounts = null,
  }) {
    return _then(_value.copyWith(
      mounts: null == mounts
          ? _value.mounts
          : mounts // ignore: cast_nullable_to_non_nullable
              as List<MountEntry>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CharacterMountsResponseImplCopyWith<$Res>
    implements $CharacterMountsResponseCopyWith<$Res> {
  factory _$$CharacterMountsResponseImplCopyWith(
          _$CharacterMountsResponseImpl value,
          $Res Function(_$CharacterMountsResponseImpl) then) =
      __$$CharacterMountsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MountEntry> mounts});
}

/// @nodoc
class __$$CharacterMountsResponseImplCopyWithImpl<$Res>
    extends _$CharacterMountsResponseCopyWithImpl<$Res,
        _$CharacterMountsResponseImpl>
    implements _$$CharacterMountsResponseImplCopyWith<$Res> {
  __$$CharacterMountsResponseImplCopyWithImpl(
      _$CharacterMountsResponseImpl _value,
      $Res Function(_$CharacterMountsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CharacterMountsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mounts = null,
  }) {
    return _then(_$CharacterMountsResponseImpl(
      mounts: null == mounts
          ? _value._mounts
          : mounts // ignore: cast_nullable_to_non_nullable
              as List<MountEntry>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterMountsResponseImpl extends _CharacterMountsResponse {
  const _$CharacterMountsResponseImpl(
      {final List<MountEntry> mounts = const []})
      : _mounts = mounts,
        super._();

  factory _$CharacterMountsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterMountsResponseImplFromJson(json);

  final List<MountEntry> _mounts;
  @override
  @JsonKey()
  List<MountEntry> get mounts {
    if (_mounts is EqualUnmodifiableListView) return _mounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mounts);
  }

  @override
  String toString() {
    return 'CharacterMountsResponse(mounts: $mounts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterMountsResponseImpl &&
            const DeepCollectionEquality().equals(other._mounts, _mounts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_mounts));

  /// Create a copy of CharacterMountsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterMountsResponseImplCopyWith<_$CharacterMountsResponseImpl>
      get copyWith => __$$CharacterMountsResponseImplCopyWithImpl<
          _$CharacterMountsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterMountsResponseImplToJson(
      this,
    );
  }
}

abstract class _CharacterMountsResponse extends CharacterMountsResponse {
  const factory _CharacterMountsResponse({final List<MountEntry> mounts}) =
      _$CharacterMountsResponseImpl;
  const _CharacterMountsResponse._() : super._();

  factory _CharacterMountsResponse.fromJson(Map<String, dynamic> json) =
      _$CharacterMountsResponseImpl.fromJson;

  @override
  List<MountEntry> get mounts;

  /// Create a copy of CharacterMountsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterMountsResponseImplCopyWith<_$CharacterMountsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MountEntry _$MountEntryFromJson(Map<String, dynamic> json) {
  return _MountEntry.fromJson(json);
}

/// @nodoc
mixin _$MountEntry {
  MountRef get mount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_useable')
  bool get isUseable => throw _privateConstructorUsedError;

  /// Serializes this MountEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MountEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MountEntryCopyWith<MountEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MountEntryCopyWith<$Res> {
  factory $MountEntryCopyWith(
          MountEntry value, $Res Function(MountEntry) then) =
      _$MountEntryCopyWithImpl<$Res, MountEntry>;
  @useResult
  $Res call({MountRef mount, @JsonKey(name: 'is_useable') bool isUseable});

  $MountRefCopyWith<$Res> get mount;
}

/// @nodoc
class _$MountEntryCopyWithImpl<$Res, $Val extends MountEntry>
    implements $MountEntryCopyWith<$Res> {
  _$MountEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MountEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mount = null,
    Object? isUseable = null,
  }) {
    return _then(_value.copyWith(
      mount: null == mount
          ? _value.mount
          : mount // ignore: cast_nullable_to_non_nullable
              as MountRef,
      isUseable: null == isUseable
          ? _value.isUseable
          : isUseable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of MountEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MountRefCopyWith<$Res> get mount {
    return $MountRefCopyWith<$Res>(_value.mount, (value) {
      return _then(_value.copyWith(mount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MountEntryImplCopyWith<$Res>
    implements $MountEntryCopyWith<$Res> {
  factory _$$MountEntryImplCopyWith(
          _$MountEntryImpl value, $Res Function(_$MountEntryImpl) then) =
      __$$MountEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MountRef mount, @JsonKey(name: 'is_useable') bool isUseable});

  @override
  $MountRefCopyWith<$Res> get mount;
}

/// @nodoc
class __$$MountEntryImplCopyWithImpl<$Res>
    extends _$MountEntryCopyWithImpl<$Res, _$MountEntryImpl>
    implements _$$MountEntryImplCopyWith<$Res> {
  __$$MountEntryImplCopyWithImpl(
      _$MountEntryImpl _value, $Res Function(_$MountEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of MountEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mount = null,
    Object? isUseable = null,
  }) {
    return _then(_$MountEntryImpl(
      mount: null == mount
          ? _value.mount
          : mount // ignore: cast_nullable_to_non_nullable
              as MountRef,
      isUseable: null == isUseable
          ? _value.isUseable
          : isUseable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MountEntryImpl implements _MountEntry {
  const _$MountEntryImpl(
      {required this.mount,
      @JsonKey(name: 'is_useable') this.isUseable = false});

  factory _$MountEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MountEntryImplFromJson(json);

  @override
  final MountRef mount;
  @override
  @JsonKey(name: 'is_useable')
  final bool isUseable;

  @override
  String toString() {
    return 'MountEntry(mount: $mount, isUseable: $isUseable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MountEntryImpl &&
            (identical(other.mount, mount) || other.mount == mount) &&
            (identical(other.isUseable, isUseable) ||
                other.isUseable == isUseable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mount, isUseable);

  /// Create a copy of MountEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MountEntryImplCopyWith<_$MountEntryImpl> get copyWith =>
      __$$MountEntryImplCopyWithImpl<_$MountEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MountEntryImplToJson(
      this,
    );
  }
}

abstract class _MountEntry implements MountEntry {
  const factory _MountEntry(
      {required final MountRef mount,
      @JsonKey(name: 'is_useable') final bool isUseable}) = _$MountEntryImpl;

  factory _MountEntry.fromJson(Map<String, dynamic> json) =
      _$MountEntryImpl.fromJson;

  @override
  MountRef get mount;
  @override
  @JsonKey(name: 'is_useable')
  bool get isUseable;

  /// Create a copy of MountEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MountEntryImplCopyWith<_$MountEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MountRef _$MountRefFromJson(Map<String, dynamic> json) {
  return _MountRef.fromJson(json);
}

/// @nodoc
mixin _$MountRef {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this MountRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MountRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MountRefCopyWith<MountRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MountRefCopyWith<$Res> {
  factory $MountRefCopyWith(MountRef value, $Res Function(MountRef) then) =
      _$MountRefCopyWithImpl<$Res, MountRef>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$MountRefCopyWithImpl<$Res, $Val extends MountRef>
    implements $MountRefCopyWith<$Res> {
  _$MountRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MountRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MountRefImplCopyWith<$Res>
    implements $MountRefCopyWith<$Res> {
  factory _$$MountRefImplCopyWith(
          _$MountRefImpl value, $Res Function(_$MountRefImpl) then) =
      __$$MountRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$MountRefImplCopyWithImpl<$Res>
    extends _$MountRefCopyWithImpl<$Res, _$MountRefImpl>
    implements _$$MountRefImplCopyWith<$Res> {
  __$$MountRefImplCopyWithImpl(
      _$MountRefImpl _value, $Res Function(_$MountRefImpl) _then)
      : super(_value, _then);

  /// Create a copy of MountRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$MountRefImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MountRefImpl implements _MountRef {
  const _$MountRefImpl({required this.id, required this.name});

  factory _$MountRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$MountRefImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'MountRef(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MountRefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of MountRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MountRefImplCopyWith<_$MountRefImpl> get copyWith =>
      __$$MountRefImplCopyWithImpl<_$MountRefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MountRefImplToJson(
      this,
    );
  }
}

abstract class _MountRef implements MountRef {
  const factory _MountRef({required final int id, required final String name}) =
      _$MountRefImpl;

  factory _MountRef.fromJson(Map<String, dynamic> json) =
      _$MountRefImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of MountRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MountRefImplCopyWith<_$MountRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
