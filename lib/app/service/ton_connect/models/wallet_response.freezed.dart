// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WalletResponse _$WalletResponseFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'success':
      return WalletResponseSuccess.fromJson(json);
    case 'error':
      return WalletResponseError.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'WalletResponse',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$WalletResponse {
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
    required TResult Function(WalletResponseSuccess value) success,
    required TResult Function(WalletResponseError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletResponseSuccess value)? success,
    TResult? Function(WalletResponseError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletResponseSuccess value)? success,
    TResult Function(WalletResponseError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this WalletResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletResponseCopyWith<WalletResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletResponseCopyWith<$Res> {
  factory $WalletResponseCopyWith(
          WalletResponse value, $Res Function(WalletResponse) then) =
      _$WalletResponseCopyWithImpl<$Res, WalletResponse>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$WalletResponseCopyWithImpl<$Res, $Val extends WalletResponse>
    implements $WalletResponseCopyWith<$Res> {
  _$WalletResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletResponse
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
abstract class _$$WalletResponseSuccessImplCopyWith<$Res>
    implements $WalletResponseCopyWith<$Res> {
  factory _$$WalletResponseSuccessImplCopyWith(
          _$WalletResponseSuccessImpl value,
          $Res Function(_$WalletResponseSuccessImpl) then) =
      __$$WalletResponseSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String result});
}

/// @nodoc
class __$$WalletResponseSuccessImplCopyWithImpl<$Res>
    extends _$WalletResponseCopyWithImpl<$Res, _$WalletResponseSuccessImpl>
    implements _$$WalletResponseSuccessImplCopyWith<$Res> {
  __$$WalletResponseSuccessImplCopyWithImpl(_$WalletResponseSuccessImpl _value,
      $Res Function(_$WalletResponseSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? result = null,
  }) {
    return _then(_$WalletResponseSuccessImpl(
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
@Deprecated('Unused due to TonConnect API inconsistency')
class _$WalletResponseSuccessImpl implements WalletResponseSuccess {
  const _$WalletResponseSuccessImpl(
      {required this.id, required this.result, final String? $type})
      : $type = $type ?? 'success';

  factory _$WalletResponseSuccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletResponseSuccessImplFromJson(json);

  @override
  final String id;
  @override
  final String result;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WalletResponse.success(id: $id, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletResponseSuccessImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, result);

  /// Create a copy of WalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletResponseSuccessImplCopyWith<_$WalletResponseSuccessImpl>
      get copyWith => __$$WalletResponseSuccessImplCopyWithImpl<
          _$WalletResponseSuccessImpl>(this, _$identity);

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
    required TResult Function(WalletResponseSuccess value) success,
    required TResult Function(WalletResponseError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletResponseSuccess value)? success,
    TResult? Function(WalletResponseError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletResponseSuccess value)? success,
    TResult Function(WalletResponseError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletResponseSuccessImplToJson(
      this,
    );
  }
}

abstract class WalletResponseSuccess implements WalletResponse {
  const factory WalletResponseSuccess(
      {required final String id,
      required final String result}) = _$WalletResponseSuccessImpl;

  factory WalletResponseSuccess.fromJson(Map<String, dynamic> json) =
      _$WalletResponseSuccessImpl.fromJson;

  @override
  String get id;
  String get result;

  /// Create a copy of WalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletResponseSuccessImplCopyWith<_$WalletResponseSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WalletResponseErrorImplCopyWith<$Res>
    implements $WalletResponseCopyWith<$Res> {
  factory _$$WalletResponseErrorImplCopyWith(_$WalletResponseErrorImpl value,
          $Res Function(_$WalletResponseErrorImpl) then) =
      __$$WalletResponseErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, TonConnectError error});

  $TonConnectErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$WalletResponseErrorImplCopyWithImpl<$Res>
    extends _$WalletResponseCopyWithImpl<$Res, _$WalletResponseErrorImpl>
    implements _$$WalletResponseErrorImplCopyWith<$Res> {
  __$$WalletResponseErrorImplCopyWithImpl(_$WalletResponseErrorImpl _value,
      $Res Function(_$WalletResponseErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? error = null,
  }) {
    return _then(_$WalletResponseErrorImpl(
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

  /// Create a copy of WalletResponse
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
class _$WalletResponseErrorImpl implements WalletResponseError {
  const _$WalletResponseErrorImpl(
      {required this.id, required this.error, final String? $type})
      : $type = $type ?? 'error';

  factory _$WalletResponseErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletResponseErrorImplFromJson(json);

  @override
  final String id;
  @override
  final TonConnectError error;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WalletResponse.error(id: $id, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletResponseErrorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, error);

  /// Create a copy of WalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletResponseErrorImplCopyWith<_$WalletResponseErrorImpl> get copyWith =>
      __$$WalletResponseErrorImplCopyWithImpl<_$WalletResponseErrorImpl>(
          this, _$identity);

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
    required TResult Function(WalletResponseSuccess value) success,
    required TResult Function(WalletResponseError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletResponseSuccess value)? success,
    TResult? Function(WalletResponseError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletResponseSuccess value)? success,
    TResult Function(WalletResponseError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletResponseErrorImplToJson(
      this,
    );
  }
}

abstract class WalletResponseError implements WalletResponse {
  const factory WalletResponseError(
      {required final String id,
      required final TonConnectError error}) = _$WalletResponseErrorImpl;

  factory WalletResponseError.fromJson(Map<String, dynamic> json) =
      _$WalletResponseErrorImpl.fromJson;

  @override
  String get id;
  TonConnectError get error;

  /// Create a copy of WalletResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletResponseErrorImplCopyWith<_$WalletResponseErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
