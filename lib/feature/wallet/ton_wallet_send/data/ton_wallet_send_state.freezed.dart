// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_wallet_send_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TonWalletSendState {
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
    required TResult Function(TonWalletSendStateError value) error,
    required TResult Function(TonWalletSendStateReady value) ready,
    required TResult Function(TonWalletSendStateSending value) sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonWalletSendStateError value)? error,
    TResult? Function(TonWalletSendStateReady value)? ready,
    TResult? Function(TonWalletSendStateSending value)? sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonWalletSendStateError value)? error,
    TResult Function(TonWalletSendStateReady value)? ready,
    TResult Function(TonWalletSendStateSending value)? sending,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonWalletSendStateCopyWith<$Res> {
  factory $TonWalletSendStateCopyWith(
          TonWalletSendState value, $Res Function(TonWalletSendState) then) =
      _$TonWalletSendStateCopyWithImpl<$Res, TonWalletSendState>;
}

/// @nodoc
class _$TonWalletSendStateCopyWithImpl<$Res, $Val extends TonWalletSendState>
    implements $TonWalletSendStateCopyWith<$Res> {
  _$TonWalletSendStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TonWalletSendStateErrorImplCopyWith<$Res> {
  factory _$$TonWalletSendStateErrorImplCopyWith(
          _$TonWalletSendStateErrorImpl value,
          $Res Function(_$TonWalletSendStateErrorImpl) then) =
      __$$TonWalletSendStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class __$$TonWalletSendStateErrorImplCopyWithImpl<$Res>
    extends _$TonWalletSendStateCopyWithImpl<$Res,
        _$TonWalletSendStateErrorImpl>
    implements _$$TonWalletSendStateErrorImplCopyWith<$Res> {
  __$$TonWalletSendStateErrorImplCopyWithImpl(
      _$TonWalletSendStateErrorImpl _value,
      $Res Function(_$TonWalletSendStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$TonWalletSendStateErrorImpl(
      error: null == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$TonWalletSendStateErrorImpl implements TonWalletSendStateError {
  const _$TonWalletSendStateErrorImpl({required this.error});

  @override
  final Object error;

  @override
  String toString() {
    return 'TonWalletSendState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonWalletSendStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonWalletSendStateErrorImplCopyWith<_$TonWalletSendStateErrorImpl>
      get copyWith => __$$TonWalletSendStateErrorImplCopyWithImpl<
          _$TonWalletSendStateErrorImpl>(this, _$identity);

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
    required TResult Function(TonWalletSendStateError value) error,
    required TResult Function(TonWalletSendStateReady value) ready,
    required TResult Function(TonWalletSendStateSending value) sending,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonWalletSendStateError value)? error,
    TResult? Function(TonWalletSendStateReady value)? ready,
    TResult? Function(TonWalletSendStateSending value)? sending,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonWalletSendStateError value)? error,
    TResult Function(TonWalletSendStateReady value)? ready,
    TResult Function(TonWalletSendStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TonWalletSendStateError implements TonWalletSendState {
  const factory TonWalletSendStateError({required final Object error}) =
      _$TonWalletSendStateErrorImpl;

  Object get error;

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonWalletSendStateErrorImplCopyWith<_$TonWalletSendStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TonWalletSendStateReadyImplCopyWith<$Res> {
  factory _$$TonWalletSendStateReadyImplCopyWith(
          _$TonWalletSendStateReadyImpl value,
          $Res Function(_$TonWalletSendStateReadyImpl) then) =
      __$$TonWalletSendStateReadyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TonWalletSendStateReadyImplCopyWithImpl<$Res>
    extends _$TonWalletSendStateCopyWithImpl<$Res,
        _$TonWalletSendStateReadyImpl>
    implements _$$TonWalletSendStateReadyImplCopyWith<$Res> {
  __$$TonWalletSendStateReadyImplCopyWithImpl(
      _$TonWalletSendStateReadyImpl _value,
      $Res Function(_$TonWalletSendStateReadyImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TonWalletSendStateReadyImpl implements TonWalletSendStateReady {
  const _$TonWalletSendStateReadyImpl();

  @override
  String toString() {
    return 'TonWalletSendState.ready()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonWalletSendStateReadyImpl);
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
    required TResult Function(TonWalletSendStateError value) error,
    required TResult Function(TonWalletSendStateReady value) ready,
    required TResult Function(TonWalletSendStateSending value) sending,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonWalletSendStateError value)? error,
    TResult? Function(TonWalletSendStateReady value)? ready,
    TResult? Function(TonWalletSendStateSending value)? sending,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonWalletSendStateError value)? error,
    TResult Function(TonWalletSendStateReady value)? ready,
    TResult Function(TonWalletSendStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class TonWalletSendStateReady implements TonWalletSendState {
  const factory TonWalletSendStateReady() = _$TonWalletSendStateReadyImpl;
}

/// @nodoc
abstract class _$$TonWalletSendStateSendingImplCopyWith<$Res> {
  factory _$$TonWalletSendStateSendingImplCopyWith(
          _$TonWalletSendStateSendingImpl value,
          $Res Function(_$TonWalletSendStateSendingImpl) then) =
      __$$TonWalletSendStateSendingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool canClose});
}

/// @nodoc
class __$$TonWalletSendStateSendingImplCopyWithImpl<$Res>
    extends _$TonWalletSendStateCopyWithImpl<$Res,
        _$TonWalletSendStateSendingImpl>
    implements _$$TonWalletSendStateSendingImplCopyWith<$Res> {
  __$$TonWalletSendStateSendingImplCopyWithImpl(
      _$TonWalletSendStateSendingImpl _value,
      $Res Function(_$TonWalletSendStateSendingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canClose = null,
  }) {
    return _then(_$TonWalletSendStateSendingImpl(
      canClose: null == canClose
          ? _value.canClose
          : canClose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TonWalletSendStateSendingImpl implements TonWalletSendStateSending {
  const _$TonWalletSendStateSendingImpl({required this.canClose});

  @override
  final bool canClose;

  @override
  String toString() {
    return 'TonWalletSendState.sending(canClose: $canClose)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonWalletSendStateSendingImpl &&
            (identical(other.canClose, canClose) ||
                other.canClose == canClose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canClose);

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonWalletSendStateSendingImplCopyWith<_$TonWalletSendStateSendingImpl>
      get copyWith => __$$TonWalletSendStateSendingImplCopyWithImpl<
          _$TonWalletSendStateSendingImpl>(this, _$identity);

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
    required TResult Function(TonWalletSendStateError value) error,
    required TResult Function(TonWalletSendStateReady value) ready,
    required TResult Function(TonWalletSendStateSending value) sending,
  }) {
    return sending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonWalletSendStateError value)? error,
    TResult? Function(TonWalletSendStateReady value)? ready,
    TResult? Function(TonWalletSendStateSending value)? sending,
  }) {
    return sending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonWalletSendStateError value)? error,
    TResult Function(TonWalletSendStateReady value)? ready,
    TResult Function(TonWalletSendStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(this);
    }
    return orElse();
  }
}

abstract class TonWalletSendStateSending implements TonWalletSendState {
  const factory TonWalletSendStateSending({required final bool canClose}) =
      _$TonWalletSendStateSendingImpl;

  bool get canClose;

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonWalletSendStateSendingImplCopyWith<_$TonWalletSendStateSendingImpl>
      get copyWith => throw _privateConstructorUsedError;
}
