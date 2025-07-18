// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_data_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignDataResult {
  /// base64 encoded signature
  String get signature;

  /// UNIX timestamp in seconds (UTC) at the moment on creating the signature
  String get timestamp;

  /// Create a copy of SignDataResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignDataResultCopyWith<SignDataResult> get copyWith =>
      _$SignDataResultCopyWithImpl<SignDataResult>(
          this as SignDataResult, _$identity);

  /// Serializes this SignDataResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignDataResult &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, signature, timestamp);

  @override
  String toString() {
    return 'SignDataResult(signature: $signature, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $SignDataResultCopyWith<$Res> {
  factory $SignDataResultCopyWith(
          SignDataResult value, $Res Function(SignDataResult) _then) =
      _$SignDataResultCopyWithImpl;
  @useResult
  $Res call({String signature, String timestamp});
}

/// @nodoc
class _$SignDataResultCopyWithImpl<$Res>
    implements $SignDataResultCopyWith<$Res> {
  _$SignDataResultCopyWithImpl(this._self, this._then);

  final SignDataResult _self;
  final $Res Function(SignDataResult) _then;

  /// Create a copy of SignDataResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signature = null,
    Object? timestamp = null,
  }) {
    return _then(_self.copyWith(
      signature: null == signature
          ? _self.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SignDataResult implements SignDataResult {
  _SignDataResult({required this.signature, required this.timestamp});
  factory _SignDataResult.fromJson(Map<String, dynamic> json) =>
      _$SignDataResultFromJson(json);

  /// base64 encoded signature
  @override
  final String signature;

  /// UNIX timestamp in seconds (UTC) at the moment on creating the signature
  @override
  final String timestamp;

  /// Create a copy of SignDataResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignDataResultCopyWith<_SignDataResult> get copyWith =>
      __$SignDataResultCopyWithImpl<_SignDataResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SignDataResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignDataResult &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, signature, timestamp);

  @override
  String toString() {
    return 'SignDataResult(signature: $signature, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$SignDataResultCopyWith<$Res>
    implements $SignDataResultCopyWith<$Res> {
  factory _$SignDataResultCopyWith(
          _SignDataResult value, $Res Function(_SignDataResult) _then) =
      __$SignDataResultCopyWithImpl;
  @override
  @useResult
  $Res call({String signature, String timestamp});
}

/// @nodoc
class __$SignDataResultCopyWithImpl<$Res>
    implements _$SignDataResultCopyWith<$Res> {
  __$SignDataResultCopyWithImpl(this._self, this._then);

  final _SignDataResult _self;
  final $Res Function(_SignDataResult) _then;

  /// Create a copy of SignDataResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? signature = null,
    Object? timestamp = null,
  }) {
    return _then(_SignDataResult(
      signature: null == signature
          ? _self.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
