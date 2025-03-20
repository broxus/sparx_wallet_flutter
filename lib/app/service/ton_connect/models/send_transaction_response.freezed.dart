// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_transaction_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendTransactionResponse _$SendTransactionResponseFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'success':
      return SendTransactionResponseSuccess.fromJson(json);
    case 'error':
      return SendTransactionResponseError.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'SendTransactionResponse',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SendTransactionResponse {
  String get id => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String result) success,
    required TResult Function(String id, TonConnectError error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String result)? success,
    TResult? Function(String id, TonConnectError error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String result)? success,
    TResult Function(String id, TonConnectError error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SendTransactionResponseSuccess value) success,
    required TResult Function(SendTransactionResponseError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SendTransactionResponseSuccess value)? success,
    TResult? Function(SendTransactionResponseError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SendTransactionResponseSuccess value)? success,
    TResult Function(SendTransactionResponseError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this SendTransactionResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendTransactionResponseCopyWith<SendTransactionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendTransactionResponseCopyWith<$Res> {
  factory $SendTransactionResponseCopyWith(SendTransactionResponse value,
          $Res Function(SendTransactionResponse) then) =
      _$SendTransactionResponseCopyWithImpl<$Res, SendTransactionResponse>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$SendTransactionResponseCopyWithImpl<$Res,
        $Val extends SendTransactionResponse>
    implements $SendTransactionResponseCopyWith<$Res> {
  _$SendTransactionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendTransactionResponse
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
abstract class _$$SendTransactionResponseSuccessImplCopyWith<$Res>
    implements $SendTransactionResponseCopyWith<$Res> {
  factory _$$SendTransactionResponseSuccessImplCopyWith(
          _$SendTransactionResponseSuccessImpl value,
          $Res Function(_$SendTransactionResponseSuccessImpl) then) =
      __$$SendTransactionResponseSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String result});
}

/// @nodoc
class __$$SendTransactionResponseSuccessImplCopyWithImpl<$Res>
    extends _$SendTransactionResponseCopyWithImpl<$Res,
        _$SendTransactionResponseSuccessImpl>
    implements _$$SendTransactionResponseSuccessImplCopyWith<$Res> {
  __$$SendTransactionResponseSuccessImplCopyWithImpl(
      _$SendTransactionResponseSuccessImpl _value,
      $Res Function(_$SendTransactionResponseSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? result = null,
  }) {
    return _then(_$SendTransactionResponseSuccessImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendTransactionResponseSuccessImpl
    implements SendTransactionResponseSuccess {
  const _$SendTransactionResponseSuccessImpl(
      {required this.id, required this.result, final String? $type})
      : $type = $type ?? 'success';

  factory _$SendTransactionResponseSuccessImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SendTransactionResponseSuccessImplFromJson(json);

  @override
  final String id;
  @override
  final String result;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SendTransactionResponse.success(id: $id, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTransactionResponseSuccessImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, result);

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTransactionResponseSuccessImplCopyWith<
          _$SendTransactionResponseSuccessImpl>
      get copyWith => __$$SendTransactionResponseSuccessImplCopyWithImpl<
          _$SendTransactionResponseSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String result) success,
    required TResult Function(String id, TonConnectError error) error,
  }) {
    return success(id, result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String result)? success,
    TResult? Function(String id, TonConnectError error)? error,
  }) {
    return success?.call(id, result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String result)? success,
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
    required TResult Function(SendTransactionResponseSuccess value) success,
    required TResult Function(SendTransactionResponseError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SendTransactionResponseSuccess value)? success,
    TResult? Function(SendTransactionResponseError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SendTransactionResponseSuccess value)? success,
    TResult Function(SendTransactionResponseError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SendTransactionResponseSuccessImplToJson(
      this,
    );
  }
}

abstract class SendTransactionResponseSuccess
    implements SendTransactionResponse {
  const factory SendTransactionResponseSuccess(
      {required final String id,
      required final String result}) = _$SendTransactionResponseSuccessImpl;

  factory SendTransactionResponseSuccess.fromJson(Map<String, dynamic> json) =
      _$SendTransactionResponseSuccessImpl.fromJson;

  @override
  String get id;
  String get result;

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendTransactionResponseSuccessImplCopyWith<
          _$SendTransactionResponseSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendTransactionResponseErrorImplCopyWith<$Res>
    implements $SendTransactionResponseCopyWith<$Res> {
  factory _$$SendTransactionResponseErrorImplCopyWith(
          _$SendTransactionResponseErrorImpl value,
          $Res Function(_$SendTransactionResponseErrorImpl) then) =
      __$$SendTransactionResponseErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, TonConnectError error});

  $TonConnectErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$SendTransactionResponseErrorImplCopyWithImpl<$Res>
    extends _$SendTransactionResponseCopyWithImpl<$Res,
        _$SendTransactionResponseErrorImpl>
    implements _$$SendTransactionResponseErrorImplCopyWith<$Res> {
  __$$SendTransactionResponseErrorImplCopyWithImpl(
      _$SendTransactionResponseErrorImpl _value,
      $Res Function(_$SendTransactionResponseErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? error = null,
  }) {
    return _then(_$SendTransactionResponseErrorImpl(
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

  /// Create a copy of SendTransactionResponse
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
class _$SendTransactionResponseErrorImpl
    implements SendTransactionResponseError {
  const _$SendTransactionResponseErrorImpl(
      {required this.id, required this.error, final String? $type})
      : $type = $type ?? 'error';

  factory _$SendTransactionResponseErrorImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SendTransactionResponseErrorImplFromJson(json);

  @override
  final String id;
  @override
  final TonConnectError error;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SendTransactionResponse.error(id: $id, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTransactionResponseErrorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, error);

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTransactionResponseErrorImplCopyWith<
          _$SendTransactionResponseErrorImpl>
      get copyWith => __$$SendTransactionResponseErrorImplCopyWithImpl<
          _$SendTransactionResponseErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String result) success,
    required TResult Function(String id, TonConnectError error) error,
  }) {
    return error(id, this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String result)? success,
    TResult? Function(String id, TonConnectError error)? error,
  }) {
    return error?.call(id, this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String result)? success,
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
    required TResult Function(SendTransactionResponseSuccess value) success,
    required TResult Function(SendTransactionResponseError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SendTransactionResponseSuccess value)? success,
    TResult? Function(SendTransactionResponseError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SendTransactionResponseSuccess value)? success,
    TResult Function(SendTransactionResponseError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SendTransactionResponseErrorImplToJson(
      this,
    );
  }
}

abstract class SendTransactionResponseError implements SendTransactionResponse {
  const factory SendTransactionResponseError(
          {required final String id, required final TonConnectError error}) =
      _$SendTransactionResponseErrorImpl;

  factory SendTransactionResponseError.fromJson(Map<String, dynamic> json) =
      _$SendTransactionResponseErrorImpl.fromJson;

  @override
  String get id;
  TonConnectError get error;

  /// Create a copy of SendTransactionResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendTransactionResponseErrorImplCopyWith<
          _$SendTransactionResponseErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
