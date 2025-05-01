// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_wallet_send_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TokenWalletSendState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) error,
    required TResult Function() ready,
    required TResult Function(bool canClose) sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Object error)? error,
    TResult? Function()? ready,
    TResult? Function(bool canClose)? sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? error,
    TResult Function()? ready,
    TResult Function(bool canClose)? sending,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokenWalletSendStateError value) error,
    required TResult Function(TokenWalletSendStateReady value) ready,
    required TResult Function(TokenWalletSendStateSending value) sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TokenWalletSendStateError value)? error,
    TResult? Function(TokenWalletSendStateReady value)? ready,
    TResult? Function(TokenWalletSendStateSending value)? sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokenWalletSendStateError value)? error,
    TResult Function(TokenWalletSendStateReady value)? ready,
    TResult Function(TokenWalletSendStateSending value)? sending,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenWalletSendStateCopyWith<$Res> {
  factory $TokenWalletSendStateCopyWith(TokenWalletSendState value,
          $Res Function(TokenWalletSendState) then) =
      _$TokenWalletSendStateCopyWithImpl<$Res, TokenWalletSendState>;
}

/// @nodoc
class _$TokenWalletSendStateCopyWithImpl<$Res,
        $Val extends TokenWalletSendState>
    implements $TokenWalletSendStateCopyWith<$Res> {
  _$TokenWalletSendStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TokenWalletSendStateErrorImplCopyWith<$Res> {
  factory _$$TokenWalletSendStateErrorImplCopyWith(
          _$TokenWalletSendStateErrorImpl value,
          $Res Function(_$TokenWalletSendStateErrorImpl) then) =
      __$$TokenWalletSendStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class __$$TokenWalletSendStateErrorImplCopyWithImpl<$Res>
    extends _$TokenWalletSendStateCopyWithImpl<$Res,
        _$TokenWalletSendStateErrorImpl>
    implements _$$TokenWalletSendStateErrorImplCopyWith<$Res> {
  __$$TokenWalletSendStateErrorImplCopyWithImpl(
      _$TokenWalletSendStateErrorImpl _value,
      $Res Function(_$TokenWalletSendStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$TokenWalletSendStateErrorImpl(
      error: null == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$TokenWalletSendStateErrorImpl implements TokenWalletSendStateError {
  const _$TokenWalletSendStateErrorImpl({required this.error});

  @override
  final Object error;

  @override
  String toString() {
    return 'TokenWalletSendState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenWalletSendStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenWalletSendStateErrorImplCopyWith<_$TokenWalletSendStateErrorImpl>
      get copyWith => __$$TokenWalletSendStateErrorImplCopyWithImpl<
          _$TokenWalletSendStateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) error,
    required TResult Function() ready,
    required TResult Function(bool canClose) sending,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Object error)? error,
    TResult? Function()? ready,
    TResult? Function(bool canClose)? sending,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? error,
    TResult Function()? ready,
    TResult Function(bool canClose)? sending,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokenWalletSendStateError value) error,
    required TResult Function(TokenWalletSendStateReady value) ready,
    required TResult Function(TokenWalletSendStateSending value) sending,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TokenWalletSendStateError value)? error,
    TResult? Function(TokenWalletSendStateReady value)? ready,
    TResult? Function(TokenWalletSendStateSending value)? sending,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokenWalletSendStateError value)? error,
    TResult Function(TokenWalletSendStateReady value)? ready,
    TResult Function(TokenWalletSendStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TokenWalletSendStateError implements TokenWalletSendState {
  const factory TokenWalletSendStateError({required final Object error}) =
      _$TokenWalletSendStateErrorImpl;

  Object get error;

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenWalletSendStateErrorImplCopyWith<_$TokenWalletSendStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TokenWalletSendStateReadyImplCopyWith<$Res> {
  factory _$$TokenWalletSendStateReadyImplCopyWith(
          _$TokenWalletSendStateReadyImpl value,
          $Res Function(_$TokenWalletSendStateReadyImpl) then) =
      __$$TokenWalletSendStateReadyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TokenWalletSendStateReadyImplCopyWithImpl<$Res>
    extends _$TokenWalletSendStateCopyWithImpl<$Res,
        _$TokenWalletSendStateReadyImpl>
    implements _$$TokenWalletSendStateReadyImplCopyWith<$Res> {
  __$$TokenWalletSendStateReadyImplCopyWithImpl(
      _$TokenWalletSendStateReadyImpl _value,
      $Res Function(_$TokenWalletSendStateReadyImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TokenWalletSendStateReadyImpl implements TokenWalletSendStateReady {
  const _$TokenWalletSendStateReadyImpl();

  @override
  String toString() {
    return 'TokenWalletSendState.ready()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenWalletSendStateReadyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) error,
    required TResult Function() ready,
    required TResult Function(bool canClose) sending,
  }) {
    return ready();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Object error)? error,
    TResult? Function()? ready,
    TResult? Function(bool canClose)? sending,
  }) {
    return ready?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? error,
    TResult Function()? ready,
    TResult Function(bool canClose)? sending,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokenWalletSendStateError value) error,
    required TResult Function(TokenWalletSendStateReady value) ready,
    required TResult Function(TokenWalletSendStateSending value) sending,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TokenWalletSendStateError value)? error,
    TResult? Function(TokenWalletSendStateReady value)? ready,
    TResult? Function(TokenWalletSendStateSending value)? sending,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokenWalletSendStateError value)? error,
    TResult Function(TokenWalletSendStateReady value)? ready,
    TResult Function(TokenWalletSendStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class TokenWalletSendStateReady implements TokenWalletSendState {
  const factory TokenWalletSendStateReady() = _$TokenWalletSendStateReadyImpl;
}

/// @nodoc
abstract class _$$TokenWalletSendStateSendingImplCopyWith<$Res> {
  factory _$$TokenWalletSendStateSendingImplCopyWith(
          _$TokenWalletSendStateSendingImpl value,
          $Res Function(_$TokenWalletSendStateSendingImpl) then) =
      __$$TokenWalletSendStateSendingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool canClose});
}

/// @nodoc
class __$$TokenWalletSendStateSendingImplCopyWithImpl<$Res>
    extends _$TokenWalletSendStateCopyWithImpl<$Res,
        _$TokenWalletSendStateSendingImpl>
    implements _$$TokenWalletSendStateSendingImplCopyWith<$Res> {
  __$$TokenWalletSendStateSendingImplCopyWithImpl(
      _$TokenWalletSendStateSendingImpl _value,
      $Res Function(_$TokenWalletSendStateSendingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canClose = null,
  }) {
    return _then(_$TokenWalletSendStateSendingImpl(
      canClose: null == canClose
          ? _value.canClose
          : canClose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TokenWalletSendStateSendingImpl implements TokenWalletSendStateSending {
  const _$TokenWalletSendStateSendingImpl({required this.canClose});

  @override
  final bool canClose;

  @override
  String toString() {
    return 'TokenWalletSendState.sending(canClose: $canClose)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenWalletSendStateSendingImpl &&
            (identical(other.canClose, canClose) ||
                other.canClose == canClose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canClose);

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenWalletSendStateSendingImplCopyWith<_$TokenWalletSendStateSendingImpl>
      get copyWith => __$$TokenWalletSendStateSendingImplCopyWithImpl<
          _$TokenWalletSendStateSendingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) error,
    required TResult Function() ready,
    required TResult Function(bool canClose) sending,
  }) {
    return sending(canClose);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Object error)? error,
    TResult? Function()? ready,
    TResult? Function(bool canClose)? sending,
  }) {
    return sending?.call(canClose);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? error,
    TResult Function()? ready,
    TResult Function(bool canClose)? sending,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(canClose);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TokenWalletSendStateError value) error,
    required TResult Function(TokenWalletSendStateReady value) ready,
    required TResult Function(TokenWalletSendStateSending value) sending,
  }) {
    return sending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TokenWalletSendStateError value)? error,
    TResult? Function(TokenWalletSendStateReady value)? ready,
    TResult? Function(TokenWalletSendStateSending value)? sending,
  }) {
    return sending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TokenWalletSendStateError value)? error,
    TResult Function(TokenWalletSendStateReady value)? ready,
    TResult Function(TokenWalletSendStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(this);
    }
    return orElse();
  }
}

abstract class TokenWalletSendStateSending implements TokenWalletSendState {
  const factory TokenWalletSendStateSending({required final bool canClose}) =
      _$TokenWalletSendStateSendingImpl;

  bool get canClose;

  /// Create a copy of TokenWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenWalletSendStateSendingImplCopyWith<_$TokenWalletSendStateSendingImpl>
      get copyWith => throw _privateConstructorUsedError;
}
