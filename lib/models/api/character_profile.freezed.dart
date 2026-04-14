// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CharacterProfileResponse _$CharacterProfileResponseFromJson(
    Map<String, dynamic> json) {
  return _CharacterProfileResponse.fromJson(json);
}

/// @nodoc
mixin _$CharacterProfileResponse {
  @JsonKey(name: 'last_login_timestamp')
  int get lastLoginTimestamp => throw _privateConstructorUsedError;

  /// Serializes this CharacterProfileResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CharacterProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CharacterProfileResponseCopyWith<CharacterProfileResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterProfileResponseCopyWith<$Res> {
  factory $CharacterProfileResponseCopyWith(CharacterProfileResponse value,
          $Res Function(CharacterProfileResponse) then) =
      _$CharacterProfileResponseCopyWithImpl<$Res, CharacterProfileResponse>;
  @useResult
  $Res call({@JsonKey(name: 'last_login_timestamp') int lastLoginTimestamp});
}

/// @nodoc
class _$CharacterProfileResponseCopyWithImpl<$Res,
        $Val extends CharacterProfileResponse>
    implements $CharacterProfileResponseCopyWith<$Res> {
  _$CharacterProfileResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CharacterProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastLoginTimestamp = null,
  }) {
    return _then(_value.copyWith(
      lastLoginTimestamp: null == lastLoginTimestamp
          ? _value.lastLoginTimestamp
          : lastLoginTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CharacterProfileResponseImplCopyWith<$Res>
    implements $CharacterProfileResponseCopyWith<$Res> {
  factory _$$CharacterProfileResponseImplCopyWith(
          _$CharacterProfileResponseImpl value,
          $Res Function(_$CharacterProfileResponseImpl) then) =
      __$$CharacterProfileResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'last_login_timestamp') int lastLoginTimestamp});
}

/// @nodoc
class __$$CharacterProfileResponseImplCopyWithImpl<$Res>
    extends _$CharacterProfileResponseCopyWithImpl<$Res,
        _$CharacterProfileResponseImpl>
    implements _$$CharacterProfileResponseImplCopyWith<$Res> {
  __$$CharacterProfileResponseImplCopyWithImpl(
      _$CharacterProfileResponseImpl _value,
      $Res Function(_$CharacterProfileResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CharacterProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastLoginTimestamp = null,
  }) {
    return _then(_$CharacterProfileResponseImpl(
      lastLoginTimestamp: null == lastLoginTimestamp
          ? _value.lastLoginTimestamp
          : lastLoginTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterProfileResponseImpl extends _CharacterProfileResponse {
  const _$CharacterProfileResponseImpl(
      {@JsonKey(name: 'last_login_timestamp') required this.lastLoginTimestamp})
      : super._();

  factory _$CharacterProfileResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterProfileResponseImplFromJson(json);

  @override
  @JsonKey(name: 'last_login_timestamp')
  final int lastLoginTimestamp;

  @override
  String toString() {
    return 'CharacterProfileResponse(lastLoginTimestamp: $lastLoginTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterProfileResponseImpl &&
            (identical(other.lastLoginTimestamp, lastLoginTimestamp) ||
                other.lastLoginTimestamp == lastLoginTimestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lastLoginTimestamp);

  /// Create a copy of CharacterProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterProfileResponseImplCopyWith<_$CharacterProfileResponseImpl>
      get copyWith => __$$CharacterProfileResponseImplCopyWithImpl<
          _$CharacterProfileResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterProfileResponseImplToJson(
      this,
    );
  }
}

abstract class _CharacterProfileResponse extends CharacterProfileResponse {
  const factory _CharacterProfileResponse(
      {@JsonKey(name: 'last_login_timestamp')
      required final int lastLoginTimestamp}) = _$CharacterProfileResponseImpl;
  const _CharacterProfileResponse._() : super._();

  factory _CharacterProfileResponse.fromJson(Map<String, dynamic> json) =
      _$CharacterProfileResponseImpl.fromJson;

  @override
  @JsonKey(name: 'last_login_timestamp')
  int get lastLoginTimestamp;

  /// Create a copy of CharacterProfileResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CharacterProfileResponseImplCopyWith<_$CharacterProfileResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
