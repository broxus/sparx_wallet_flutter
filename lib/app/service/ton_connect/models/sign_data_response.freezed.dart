// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_data_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SignDataResponse _$SignDataResponseFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'success':
      return SignDataResponseSuccess.fromJson(json);
    case 'error':
      return SignDataResponseError.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SignDataResponse',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SignDataResponse {
  String get id;

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignDataResponseCopyWith<SignDataResponse> get copyWith =>
      _$SignDataResponseCopyWithImpl<SignDataResponse>(
          this as SignDataResponse, _$identity);

  /// Serializes this SignDataResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignDataResponse &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @override
  String toString() {
    return 'SignDataResponse(id: $id)';
  }
}

/// @nodoc
abstract mixin class $SignDataResponseCopyWith<$Res> {
  factory $SignDataResponseCopyWith(
          SignDataResponse value, $Res Function(SignDataResponse) _then) =
      _$SignDataResponseCopyWithImpl;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$SignDataResponseCopyWithImpl<$Res>
    implements $SignDataResponseCopyWith<$Res> {
  _$SignDataResponseCopyWithImpl(this._self, this._then);

  final SignDataResponse _self;
  final $Res Function(SignDataResponse) _then;

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class SignDataResponseSuccess implements SignDataResponse {
  const SignDataResponseSuccess(
      {required this.id, required this.result, final String? $type})
      : $type = $type ?? 'success';
  factory SignDataResponseSuccess.fromJson(Map<String, dynamic> json) =>
      _$SignDataResponseSuccessFromJson(json);

  @override
  final String id;
  final SignDataResult result;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignDataResponseSuccessCopyWith<SignDataResponseSuccess> get copyWith =>
      _$SignDataResponseSuccessCopyWithImpl<SignDataResponseSuccess>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SignDataResponseSuccessToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignDataResponseSuccess &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, result);

  @override
  String toString() {
    return 'SignDataResponse.success(id: $id, result: $result)';
  }
}

/// @nodoc
abstract mixin class $SignDataResponseSuccessCopyWith<$Res>
    implements $SignDataResponseCopyWith<$Res> {
  factory $SignDataResponseSuccessCopyWith(SignDataResponseSuccess value,
          $Res Function(SignDataResponseSuccess) _then) =
      _$SignDataResponseSuccessCopyWithImpl;
  @override
  @useResult
  $Res call({String id, SignDataResult result});

  $SignDataResultCopyWith<$Res> get result;
}

/// @nodoc
class _$SignDataResponseSuccessCopyWithImpl<$Res>
    implements $SignDataResponseSuccessCopyWith<$Res> {
  _$SignDataResponseSuccessCopyWithImpl(this._self, this._then);

  final SignDataResponseSuccess _self;
  final $Res Function(SignDataResponseSuccess) _then;

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? result = null,
  }) {
    return _then(SignDataResponseSuccess(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as SignDataResult,
    ));
  }

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignDataResultCopyWith<$Res> get result {
    return $SignDataResultCopyWith<$Res>(_self.result, (value) {
      return _then(_self.copyWith(result: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class SignDataResponseError implements SignDataResponse {
  const SignDataResponseError(
      {required this.id, required this.error, final String? $type})
      : $type = $type ?? 'error';
  factory SignDataResponseError.fromJson(Map<String, dynamic> json) =>
      _$SignDataResponseErrorFromJson(json);

  @override
  final String id;
  final TonConnectError error;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignDataResponseErrorCopyWith<SignDataResponseError> get copyWith =>
      _$SignDataResponseErrorCopyWithImpl<SignDataResponseError>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SignDataResponseErrorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignDataResponseError &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, error);

  @override
  String toString() {
    return 'SignDataResponse.error(id: $id, error: $error)';
  }
}

/// @nodoc
abstract mixin class $SignDataResponseErrorCopyWith<$Res>
    implements $SignDataResponseCopyWith<$Res> {
  factory $SignDataResponseErrorCopyWith(SignDataResponseError value,
          $Res Function(SignDataResponseError) _then) =
      _$SignDataResponseErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String id, TonConnectError error});

  $TonConnectErrorCopyWith<$Res> get error;
}

/// @nodoc
class _$SignDataResponseErrorCopyWithImpl<$Res>
    implements $SignDataResponseErrorCopyWith<$Res> {
  _$SignDataResponseErrorCopyWithImpl(this._self, this._then);

  final SignDataResponseError _self;
  final $Res Function(SignDataResponseError) _then;

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? error = null,
  }) {
    return _then(SignDataResponseError(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as TonConnectError,
    ));
  }

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonConnectErrorCopyWith<$Res> get error {
    return $TonConnectErrorCopyWith<$Res>(_self.error, (value) {
      return _then(_self.copyWith(error: value));
    });
  }
}

// dart format on
