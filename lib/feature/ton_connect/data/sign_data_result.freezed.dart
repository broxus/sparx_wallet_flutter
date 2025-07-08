// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_data_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignDataResult _$SignDataResultFromJson(Map<String, dynamic> json) {
  return _SignDataResult.fromJson(json);
}

/// @nodoc
mixin _$SignDataResult {
  /// base64 encoded signature
  String get signature => throw _privateConstructorUsedError;

  /// UNIX timestamp in seconds (UTC) at the moment on creating the signature
  String get timestamp => throw _privateConstructorUsedError;

  /// Serializes this SignDataResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignDataResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignDataResultCopyWith<SignDataResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignDataResultCopyWith<$Res> {
  factory $SignDataResultCopyWith(
          SignDataResult value, $Res Function(SignDataResult) then) =
      _$SignDataResultCopyWithImpl<$Res, SignDataResult>;
  @useResult
  $Res call({String signature, String timestamp});
}

/// @nodoc
class _$SignDataResultCopyWithImpl<$Res, $Val extends SignDataResult>
    implements $SignDataResultCopyWith<$Res> {
  _$SignDataResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignDataResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signature = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignDataResultImplCopyWith<$Res>
    implements $SignDataResultCopyWith<$Res> {
  factory _$$SignDataResultImplCopyWith(_$SignDataResultImpl value,
          $Res Function(_$SignDataResultImpl) then) =
      __$$SignDataResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String signature, String timestamp});
}

/// @nodoc
class __$$SignDataResultImplCopyWithImpl<$Res>
    extends _$SignDataResultCopyWithImpl<$Res, _$SignDataResultImpl>
    implements _$$SignDataResultImplCopyWith<$Res> {
  __$$SignDataResultImplCopyWithImpl(
      _$SignDataResultImpl _value, $Res Function(_$SignDataResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignDataResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signature = null,
    Object? timestamp = null,
  }) {
    return _then(_$SignDataResultImpl(
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignDataResultImpl implements _SignDataResult {
  _$SignDataResultImpl({required this.signature, required this.timestamp});

  factory _$SignDataResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignDataResultImplFromJson(json);

  /// base64 encoded signature
  @override
  final String signature;

  /// UNIX timestamp in seconds (UTC) at the moment on creating the signature
  @override
  final String timestamp;

  @override
  String toString() {
    return 'SignDataResult(signature: $signature, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignDataResultImpl &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, signature, timestamp);

  /// Create a copy of SignDataResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignDataResultImplCopyWith<_$SignDataResultImpl> get copyWith =>
      __$$SignDataResultImplCopyWithImpl<_$SignDataResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignDataResultImplToJson(
      this,
    );
  }
}

abstract class _SignDataResult implements SignDataResult {
  factory _SignDataResult(
      {required final String signature,
      required final String timestamp}) = _$SignDataResultImpl;

  factory _SignDataResult.fromJson(Map<String, dynamic> json) =
      _$SignDataResultImpl.fromJson;

  /// base64 encoded signature
  @override
  String get signature;

  /// UNIX timestamp in seconds (UTC) at the moment on creating the signature
  @override
  String get timestamp;

  /// Create a copy of SignDataResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignDataResultImplCopyWith<_$SignDataResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
