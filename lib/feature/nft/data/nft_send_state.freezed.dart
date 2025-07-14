// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nft_send_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NftSendState {
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
    required TResult Function(NftSendStateError value) error,
    required TResult Function(NftSendStateReady value) ready,
    required TResult Function(NftSendStateSending value) sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NftSendStateError value)? error,
    TResult? Function(NftSendStateReady value)? ready,
    TResult? Function(NftSendStateSending value)? sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NftSendStateError value)? error,
    TResult Function(NftSendStateReady value)? ready,
    TResult Function(NftSendStateSending value)? sending,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NftSendStateCopyWith<$Res> {
  factory $NftSendStateCopyWith(
          NftSendState value, $Res Function(NftSendState) then) =
      _$NftSendStateCopyWithImpl<$Res, NftSendState>;
}

/// @nodoc
class _$NftSendStateCopyWithImpl<$Res, $Val extends NftSendState>
    implements $NftSendStateCopyWith<$Res> {
  _$NftSendStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NftSendStateErrorImplCopyWith<$Res> {
  factory _$$NftSendStateErrorImplCopyWith(_$NftSendStateErrorImpl value,
          $Res Function(_$NftSendStateErrorImpl) then) =
      __$$NftSendStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class __$$NftSendStateErrorImplCopyWithImpl<$Res>
    extends _$NftSendStateCopyWithImpl<$Res, _$NftSendStateErrorImpl>
    implements _$$NftSendStateErrorImplCopyWith<$Res> {
  __$$NftSendStateErrorImplCopyWithImpl(_$NftSendStateErrorImpl _value,
      $Res Function(_$NftSendStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$NftSendStateErrorImpl(
      error: null == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$NftSendStateErrorImpl implements NftSendStateError {
  const _$NftSendStateErrorImpl({required this.error});

  @override
  final Object error;

  @override
  String toString() {
    return 'NftSendState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NftSendStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NftSendStateErrorImplCopyWith<_$NftSendStateErrorImpl> get copyWith =>
      __$$NftSendStateErrorImplCopyWithImpl<_$NftSendStateErrorImpl>(
          this, _$identity);

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
    required TResult Function(NftSendStateError value) error,
    required TResult Function(NftSendStateReady value) ready,
    required TResult Function(NftSendStateSending value) sending,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NftSendStateError value)? error,
    TResult? Function(NftSendStateReady value)? ready,
    TResult? Function(NftSendStateSending value)? sending,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NftSendStateError value)? error,
    TResult Function(NftSendStateReady value)? ready,
    TResult Function(NftSendStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class NftSendStateError implements NftSendState {
  const factory NftSendStateError({required final Object error}) =
      _$NftSendStateErrorImpl;

  Object get error;

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NftSendStateErrorImplCopyWith<_$NftSendStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NftSendStateReadyImplCopyWith<$Res> {
  factory _$$NftSendStateReadyImplCopyWith(_$NftSendStateReadyImpl value,
          $Res Function(_$NftSendStateReadyImpl) then) =
      __$$NftSendStateReadyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NftSendStateReadyImplCopyWithImpl<$Res>
    extends _$NftSendStateCopyWithImpl<$Res, _$NftSendStateReadyImpl>
    implements _$$NftSendStateReadyImplCopyWith<$Res> {
  __$$NftSendStateReadyImplCopyWithImpl(_$NftSendStateReadyImpl _value,
      $Res Function(_$NftSendStateReadyImpl) _then)
      : super(_value, _then);

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NftSendStateReadyImpl implements NftSendStateReady {
  const _$NftSendStateReadyImpl();

  @override
  String toString() {
    return 'NftSendState.ready()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NftSendStateReadyImpl);
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
    required TResult Function(NftSendStateError value) error,
    required TResult Function(NftSendStateReady value) ready,
    required TResult Function(NftSendStateSending value) sending,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NftSendStateError value)? error,
    TResult? Function(NftSendStateReady value)? ready,
    TResult? Function(NftSendStateSending value)? sending,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NftSendStateError value)? error,
    TResult Function(NftSendStateReady value)? ready,
    TResult Function(NftSendStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class NftSendStateReady implements NftSendState {
  const factory NftSendStateReady() = _$NftSendStateReadyImpl;
}

/// @nodoc
abstract class _$$NftSendStateSendingImplCopyWith<$Res> {
  factory _$$NftSendStateSendingImplCopyWith(_$NftSendStateSendingImpl value,
          $Res Function(_$NftSendStateSendingImpl) then) =
      __$$NftSendStateSendingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool canClose});
}

/// @nodoc
class __$$NftSendStateSendingImplCopyWithImpl<$Res>
    extends _$NftSendStateCopyWithImpl<$Res, _$NftSendStateSendingImpl>
    implements _$$NftSendStateSendingImplCopyWith<$Res> {
  __$$NftSendStateSendingImplCopyWithImpl(_$NftSendStateSendingImpl _value,
      $Res Function(_$NftSendStateSendingImpl) _then)
      : super(_value, _then);

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canClose = null,
  }) {
    return _then(_$NftSendStateSendingImpl(
      canClose: null == canClose
          ? _value.canClose
          : canClose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NftSendStateSendingImpl implements NftSendStateSending {
  const _$NftSendStateSendingImpl({required this.canClose});

  @override
  final bool canClose;

  @override
  String toString() {
    return 'NftSendState.sending(canClose: $canClose)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NftSendStateSendingImpl &&
            (identical(other.canClose, canClose) ||
                other.canClose == canClose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canClose);

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NftSendStateSendingImplCopyWith<_$NftSendStateSendingImpl> get copyWith =>
      __$$NftSendStateSendingImplCopyWithImpl<_$NftSendStateSendingImpl>(
          this, _$identity);

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
    required TResult Function(NftSendStateError value) error,
    required TResult Function(NftSendStateReady value) ready,
    required TResult Function(NftSendStateSending value) sending,
  }) {
    return sending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NftSendStateError value)? error,
    TResult? Function(NftSendStateReady value)? ready,
    TResult? Function(NftSendStateSending value)? sending,
  }) {
    return sending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NftSendStateError value)? error,
    TResult Function(NftSendStateReady value)? ready,
    TResult Function(NftSendStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(this);
    }
    return orElse();
  }
}

abstract class NftSendStateSending implements NftSendState {
  const factory NftSendStateSending({required final bool canClose}) =
      _$NftSendStateSendingImpl;

  bool get canClose;

  /// Create a copy of NftSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NftSendStateSendingImplCopyWith<_$NftSendStateSendingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
