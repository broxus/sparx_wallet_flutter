// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_data_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
  String get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, SignDataResult result) success,
    required TResult Function(String id, TonConnectError error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, SignDataResult result)? success,
    TResult? Function(String id, TonConnectError error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, SignDataResult result)? success,
    TResult Function(String id, TonConnectError error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignDataResponseSuccess value) success,
    required TResult Function(SignDataResponseError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignDataResponseSuccess value)? success,
    TResult? Function(SignDataResponseError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignDataResponseSuccess value)? success,
    TResult Function(SignDataResponseError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this SignDataResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignDataResponseCopyWith<SignDataResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignDataResponseCopyWith<$Res> {
  factory $SignDataResponseCopyWith(
          SignDataResponse value, $Res Function(SignDataResponse) then) =
      _$SignDataResponseCopyWithImpl<$Res, SignDataResponse>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$SignDataResponseCopyWithImpl<$Res, $Val extends SignDataResponse>
    implements $SignDataResponseCopyWith<$Res> {
  _$SignDataResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignDataResponseSuccessImplCopyWith<$Res>
    implements $SignDataResponseCopyWith<$Res> {
  factory _$$SignDataResponseSuccessImplCopyWith(
          _$SignDataResponseSuccessImpl value,
          $Res Function(_$SignDataResponseSuccessImpl) then) =
      __$$SignDataResponseSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, SignDataResult result});

  $SignDataResultCopyWith<$Res> get result;
}

/// @nodoc
class __$$SignDataResponseSuccessImplCopyWithImpl<$Res>
    extends _$SignDataResponseCopyWithImpl<$Res, _$SignDataResponseSuccessImpl>
    implements _$$SignDataResponseSuccessImplCopyWith<$Res> {
  __$$SignDataResponseSuccessImplCopyWithImpl(
      _$SignDataResponseSuccessImpl _value,
      $Res Function(_$SignDataResponseSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? result = null,
  }) {
    return _then(_$SignDataResponseSuccessImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as SignDataResult,
    ));
  }

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignDataResultCopyWith<$Res> get result {
    return $SignDataResultCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$SignDataResponseSuccessImpl implements SignDataResponseSuccess {
  const _$SignDataResponseSuccessImpl(
      {required this.id, required this.result, final String? $type})
      : $type = $type ?? 'success';

  factory _$SignDataResponseSuccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignDataResponseSuccessImplFromJson(json);

  @override
  final String id;
  @override
  final SignDataResult result;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SignDataResponse.success(id: $id, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignDataResponseSuccessImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, result);

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignDataResponseSuccessImplCopyWith<_$SignDataResponseSuccessImpl>
      get copyWith => __$$SignDataResponseSuccessImplCopyWithImpl<
          _$SignDataResponseSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, SignDataResult result) success,
    required TResult Function(String id, TonConnectError error) error,
  }) {
    return success(id, result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, SignDataResult result)? success,
    TResult? Function(String id, TonConnectError error)? error,
  }) {
    return success?.call(id, result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, SignDataResult result)? success,
    TResult Function(String id, TonConnectError error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(id, result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignDataResponseSuccess value) success,
    required TResult Function(SignDataResponseError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignDataResponseSuccess value)? success,
    TResult? Function(SignDataResponseError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignDataResponseSuccess value)? success,
    TResult Function(SignDataResponseError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SignDataResponseSuccessImplToJson(
      this,
    );
  }
}

abstract class SignDataResponseSuccess implements SignDataResponse {
  const factory SignDataResponseSuccess(
      {required final String id,
      required final SignDataResult result}) = _$SignDataResponseSuccessImpl;

  factory SignDataResponseSuccess.fromJson(Map<String, dynamic> json) =
      _$SignDataResponseSuccessImpl.fromJson;

  @override
  String get id;
  SignDataResult get result;

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignDataResponseSuccessImplCopyWith<_$SignDataResponseSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignDataResponseErrorImplCopyWith<$Res>
    implements $SignDataResponseCopyWith<$Res> {
  factory _$$SignDataResponseErrorImplCopyWith(
          _$SignDataResponseErrorImpl value,
          $Res Function(_$SignDataResponseErrorImpl) then) =
      __$$SignDataResponseErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, TonConnectError error});

  $TonConnectErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$SignDataResponseErrorImplCopyWithImpl<$Res>
    extends _$SignDataResponseCopyWithImpl<$Res, _$SignDataResponseErrorImpl>
    implements _$$SignDataResponseErrorImplCopyWith<$Res> {
  __$$SignDataResponseErrorImplCopyWithImpl(_$SignDataResponseErrorImpl _value,
      $Res Function(_$SignDataResponseErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? error = null,
  }) {
    return _then(_$SignDataResponseErrorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as TonConnectError,
    ));
  }

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonConnectErrorCopyWith<$Res> get error {
    return $TonConnectErrorCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$SignDataResponseErrorImpl implements SignDataResponseError {
  const _$SignDataResponseErrorImpl(
      {required this.id, required this.error, final String? $type})
      : $type = $type ?? 'error';

  factory _$SignDataResponseErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignDataResponseErrorImplFromJson(json);

  @override
  final String id;
  @override
  final TonConnectError error;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SignDataResponse.error(id: $id, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignDataResponseErrorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, error);

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignDataResponseErrorImplCopyWith<_$SignDataResponseErrorImpl>
      get copyWith => __$$SignDataResponseErrorImplCopyWithImpl<
          _$SignDataResponseErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, SignDataResult result) success,
    required TResult Function(String id, TonConnectError error) error,
  }) {
    return error(id, this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, SignDataResult result)? success,
    TResult? Function(String id, TonConnectError error)? error,
  }) {
    return error?.call(id, this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, SignDataResult result)? success,
    TResult Function(String id, TonConnectError error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(id, this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignDataResponseSuccess value) success,
    required TResult Function(SignDataResponseError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignDataResponseSuccess value)? success,
    TResult? Function(SignDataResponseError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignDataResponseSuccess value)? success,
    TResult Function(SignDataResponseError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SignDataResponseErrorImplToJson(
      this,
    );
  }
}

abstract class SignDataResponseError implements SignDataResponse {
  const factory SignDataResponseError(
      {required final String id,
      required final TonConnectError error}) = _$SignDataResponseErrorImpl;

  factory SignDataResponseError.fromJson(Map<String, dynamic> json) =
      _$SignDataResponseErrorImpl.fromJson;

  @override
  String get id;
  TonConnectError get error;

  /// Create a copy of SignDataResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignDataResponseErrorImplCopyWith<_$SignDataResponseErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
