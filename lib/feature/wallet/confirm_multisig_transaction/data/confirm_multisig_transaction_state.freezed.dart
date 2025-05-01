// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_multisig_transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConfirmMultisigTransactionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prepare,
    required TResult Function(Object error) error,
    required TResult Function(PublicKey custodian) ready,
    required TResult Function(bool canClose) sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? prepare,
    TResult? Function(Object error)? error,
    TResult? Function(PublicKey custodian)? ready,
    TResult? Function(bool canClose)? sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prepare,
    TResult Function(Object error)? error,
    TResult Function(PublicKey custodian)? ready,
    TResult Function(bool canClose)? sending,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmMultisigTransactionStatePrepare value)
        prepare,
    required TResult Function(ConfirmMultisigTransactionStateError value) error,
    required TResult Function(ConfirmMultisigTransactionStateReady value) ready,
    required TResult Function(ConfirmMultisigTransactionStateSending value)
        sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult? Function(ConfirmMultisigTransactionStateError value)? error,
    TResult? Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult? Function(ConfirmMultisigTransactionStateSending value)? sending,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult Function(ConfirmMultisigTransactionStateError value)? error,
    TResult Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult Function(ConfirmMultisigTransactionStateSending value)? sending,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmMultisigTransactionStateCopyWith<$Res> {
  factory $ConfirmMultisigTransactionStateCopyWith(
          ConfirmMultisigTransactionState value,
          $Res Function(ConfirmMultisigTransactionState) then) =
      _$ConfirmMultisigTransactionStateCopyWithImpl<$Res,
          ConfirmMultisigTransactionState>;
}

/// @nodoc
class _$ConfirmMultisigTransactionStateCopyWithImpl<$Res,
        $Val extends ConfirmMultisigTransactionState>
    implements $ConfirmMultisigTransactionStateCopyWith<$Res> {
  _$ConfirmMultisigTransactionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConfirmMultisigTransactionStatePrepareImplCopyWith<$Res> {
  factory _$$ConfirmMultisigTransactionStatePrepareImplCopyWith(
          _$ConfirmMultisigTransactionStatePrepareImpl value,
          $Res Function(_$ConfirmMultisigTransactionStatePrepareImpl) then) =
      __$$ConfirmMultisigTransactionStatePrepareImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConfirmMultisigTransactionStatePrepareImplCopyWithImpl<$Res>
    extends _$ConfirmMultisigTransactionStateCopyWithImpl<$Res,
        _$ConfirmMultisigTransactionStatePrepareImpl>
    implements _$$ConfirmMultisigTransactionStatePrepareImplCopyWith<$Res> {
  __$$ConfirmMultisigTransactionStatePrepareImplCopyWithImpl(
      _$ConfirmMultisigTransactionStatePrepareImpl _value,
      $Res Function(_$ConfirmMultisigTransactionStatePrepareImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConfirmMultisigTransactionStatePrepareImpl
    implements ConfirmMultisigTransactionStatePrepare {
  const _$ConfirmMultisigTransactionStatePrepareImpl();

  @override
  String toString() {
    return 'ConfirmMultisigTransactionState.prepare()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmMultisigTransactionStatePrepareImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prepare,
    required TResult Function(Object error) error,
    required TResult Function(PublicKey custodian) ready,
    required TResult Function(bool canClose) sending,
  }) {
    return prepare();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? prepare,
    TResult? Function(Object error)? error,
    TResult? Function(PublicKey custodian)? ready,
    TResult? Function(bool canClose)? sending,
  }) {
    return prepare?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prepare,
    TResult Function(Object error)? error,
    TResult Function(PublicKey custodian)? ready,
    TResult Function(bool canClose)? sending,
    required TResult orElse(),
  }) {
    if (prepare != null) {
      return prepare();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmMultisigTransactionStatePrepare value)
        prepare,
    required TResult Function(ConfirmMultisigTransactionStateError value) error,
    required TResult Function(ConfirmMultisigTransactionStateReady value) ready,
    required TResult Function(ConfirmMultisigTransactionStateSending value)
        sending,
  }) {
    return prepare(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult? Function(ConfirmMultisigTransactionStateError value)? error,
    TResult? Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult? Function(ConfirmMultisigTransactionStateSending value)? sending,
  }) {
    return prepare?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult Function(ConfirmMultisigTransactionStateError value)? error,
    TResult Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult Function(ConfirmMultisigTransactionStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (prepare != null) {
      return prepare(this);
    }
    return orElse();
  }
}

abstract class ConfirmMultisigTransactionStatePrepare
    implements ConfirmMultisigTransactionState {
  const factory ConfirmMultisigTransactionStatePrepare() =
      _$ConfirmMultisigTransactionStatePrepareImpl;
}

/// @nodoc
abstract class _$$ConfirmMultisigTransactionStateErrorImplCopyWith<$Res> {
  factory _$$ConfirmMultisigTransactionStateErrorImplCopyWith(
          _$ConfirmMultisigTransactionStateErrorImpl value,
          $Res Function(_$ConfirmMultisigTransactionStateErrorImpl) then) =
      __$$ConfirmMultisigTransactionStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class __$$ConfirmMultisigTransactionStateErrorImplCopyWithImpl<$Res>
    extends _$ConfirmMultisigTransactionStateCopyWithImpl<$Res,
        _$ConfirmMultisigTransactionStateErrorImpl>
    implements _$$ConfirmMultisigTransactionStateErrorImplCopyWith<$Res> {
  __$$ConfirmMultisigTransactionStateErrorImplCopyWithImpl(
      _$ConfirmMultisigTransactionStateErrorImpl _value,
      $Res Function(_$ConfirmMultisigTransactionStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ConfirmMultisigTransactionStateErrorImpl(
      error: null == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$ConfirmMultisigTransactionStateErrorImpl
    implements ConfirmMultisigTransactionStateError {
  const _$ConfirmMultisigTransactionStateErrorImpl({required this.error});

  @override
  final Object error;

  @override
  String toString() {
    return 'ConfirmMultisigTransactionState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmMultisigTransactionStateErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmMultisigTransactionStateErrorImplCopyWith<
          _$ConfirmMultisigTransactionStateErrorImpl>
      get copyWith => __$$ConfirmMultisigTransactionStateErrorImplCopyWithImpl<
          _$ConfirmMultisigTransactionStateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prepare,
    required TResult Function(Object error) error,
    required TResult Function(PublicKey custodian) ready,
    required TResult Function(bool canClose) sending,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? prepare,
    TResult? Function(Object error)? error,
    TResult? Function(PublicKey custodian)? ready,
    TResult? Function(bool canClose)? sending,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prepare,
    TResult Function(Object error)? error,
    TResult Function(PublicKey custodian)? ready,
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
    required TResult Function(ConfirmMultisigTransactionStatePrepare value)
        prepare,
    required TResult Function(ConfirmMultisigTransactionStateError value) error,
    required TResult Function(ConfirmMultisigTransactionStateReady value) ready,
    required TResult Function(ConfirmMultisigTransactionStateSending value)
        sending,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult? Function(ConfirmMultisigTransactionStateError value)? error,
    TResult? Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult? Function(ConfirmMultisigTransactionStateSending value)? sending,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult Function(ConfirmMultisigTransactionStateError value)? error,
    TResult Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult Function(ConfirmMultisigTransactionStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ConfirmMultisigTransactionStateError
    implements ConfirmMultisigTransactionState {
  const factory ConfirmMultisigTransactionStateError(
          {required final Object error}) =
      _$ConfirmMultisigTransactionStateErrorImpl;

  Object get error;

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmMultisigTransactionStateErrorImplCopyWith<
          _$ConfirmMultisigTransactionStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmMultisigTransactionStateReadyImplCopyWith<$Res> {
  factory _$$ConfirmMultisigTransactionStateReadyImplCopyWith(
          _$ConfirmMultisigTransactionStateReadyImpl value,
          $Res Function(_$ConfirmMultisigTransactionStateReadyImpl) then) =
      __$$ConfirmMultisigTransactionStateReadyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PublicKey custodian});

  $PublicKeyCopyWith<$Res> get custodian;
}

/// @nodoc
class __$$ConfirmMultisigTransactionStateReadyImplCopyWithImpl<$Res>
    extends _$ConfirmMultisigTransactionStateCopyWithImpl<$Res,
        _$ConfirmMultisigTransactionStateReadyImpl>
    implements _$$ConfirmMultisigTransactionStateReadyImplCopyWith<$Res> {
  __$$ConfirmMultisigTransactionStateReadyImplCopyWithImpl(
      _$ConfirmMultisigTransactionStateReadyImpl _value,
      $Res Function(_$ConfirmMultisigTransactionStateReadyImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? custodian = null,
  }) {
    return _then(_$ConfirmMultisigTransactionStateReadyImpl(
      custodian: null == custodian
          ? _value.custodian
          : custodian // ignore: cast_nullable_to_non_nullable
              as PublicKey,
    ));
  }

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get custodian {
    return $PublicKeyCopyWith<$Res>(_value.custodian, (value) {
      return _then(_value.copyWith(custodian: value));
    });
  }
}

/// @nodoc

class _$ConfirmMultisigTransactionStateReadyImpl
    implements ConfirmMultisigTransactionStateReady {
  const _$ConfirmMultisigTransactionStateReadyImpl({required this.custodian});

  @override
  final PublicKey custodian;

  @override
  String toString() {
    return 'ConfirmMultisigTransactionState.ready(custodian: $custodian)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmMultisigTransactionStateReadyImpl &&
            (identical(other.custodian, custodian) ||
                other.custodian == custodian));
  }

  @override
  int get hashCode => Object.hash(runtimeType, custodian);

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmMultisigTransactionStateReadyImplCopyWith<
          _$ConfirmMultisigTransactionStateReadyImpl>
      get copyWith => __$$ConfirmMultisigTransactionStateReadyImplCopyWithImpl<
          _$ConfirmMultisigTransactionStateReadyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prepare,
    required TResult Function(Object error) error,
    required TResult Function(PublicKey custodian) ready,
    required TResult Function(bool canClose) sending,
  }) {
    return ready(custodian);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? prepare,
    TResult? Function(Object error)? error,
    TResult? Function(PublicKey custodian)? ready,
    TResult? Function(bool canClose)? sending,
  }) {
    return ready?.call(custodian);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prepare,
    TResult Function(Object error)? error,
    TResult Function(PublicKey custodian)? ready,
    TResult Function(bool canClose)? sending,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(custodian);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmMultisigTransactionStatePrepare value)
        prepare,
    required TResult Function(ConfirmMultisigTransactionStateError value) error,
    required TResult Function(ConfirmMultisigTransactionStateReady value) ready,
    required TResult Function(ConfirmMultisigTransactionStateSending value)
        sending,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult? Function(ConfirmMultisigTransactionStateError value)? error,
    TResult? Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult? Function(ConfirmMultisigTransactionStateSending value)? sending,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult Function(ConfirmMultisigTransactionStateError value)? error,
    TResult Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult Function(ConfirmMultisigTransactionStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class ConfirmMultisigTransactionStateReady
    implements ConfirmMultisigTransactionState {
  const factory ConfirmMultisigTransactionStateReady(
          {required final PublicKey custodian}) =
      _$ConfirmMultisigTransactionStateReadyImpl;

  PublicKey get custodian;

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmMultisigTransactionStateReadyImplCopyWith<
          _$ConfirmMultisigTransactionStateReadyImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmMultisigTransactionStateSendingImplCopyWith<$Res> {
  factory _$$ConfirmMultisigTransactionStateSendingImplCopyWith(
          _$ConfirmMultisigTransactionStateSendingImpl value,
          $Res Function(_$ConfirmMultisigTransactionStateSendingImpl) then) =
      __$$ConfirmMultisigTransactionStateSendingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool canClose});
}

/// @nodoc
class __$$ConfirmMultisigTransactionStateSendingImplCopyWithImpl<$Res>
    extends _$ConfirmMultisigTransactionStateCopyWithImpl<$Res,
        _$ConfirmMultisigTransactionStateSendingImpl>
    implements _$$ConfirmMultisigTransactionStateSendingImplCopyWith<$Res> {
  __$$ConfirmMultisigTransactionStateSendingImplCopyWithImpl(
      _$ConfirmMultisigTransactionStateSendingImpl _value,
      $Res Function(_$ConfirmMultisigTransactionStateSendingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canClose = null,
  }) {
    return _then(_$ConfirmMultisigTransactionStateSendingImpl(
      canClose: null == canClose
          ? _value.canClose
          : canClose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ConfirmMultisigTransactionStateSendingImpl
    implements ConfirmMultisigTransactionStateSending {
  const _$ConfirmMultisigTransactionStateSendingImpl({required this.canClose});

  @override
  final bool canClose;

  @override
  String toString() {
    return 'ConfirmMultisigTransactionState.sending(canClose: $canClose)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmMultisigTransactionStateSendingImpl &&
            (identical(other.canClose, canClose) ||
                other.canClose == canClose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canClose);

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmMultisigTransactionStateSendingImplCopyWith<
          _$ConfirmMultisigTransactionStateSendingImpl>
      get copyWith =>
          __$$ConfirmMultisigTransactionStateSendingImplCopyWithImpl<
              _$ConfirmMultisigTransactionStateSendingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prepare,
    required TResult Function(Object error) error,
    required TResult Function(PublicKey custodian) ready,
    required TResult Function(bool canClose) sending,
  }) {
    return sending(canClose);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? prepare,
    TResult? Function(Object error)? error,
    TResult? Function(PublicKey custodian)? ready,
    TResult? Function(bool canClose)? sending,
  }) {
    return sending?.call(canClose);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prepare,
    TResult Function(Object error)? error,
    TResult Function(PublicKey custodian)? ready,
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
    required TResult Function(ConfirmMultisigTransactionStatePrepare value)
        prepare,
    required TResult Function(ConfirmMultisigTransactionStateError value) error,
    required TResult Function(ConfirmMultisigTransactionStateReady value) ready,
    required TResult Function(ConfirmMultisigTransactionStateSending value)
        sending,
  }) {
    return sending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult? Function(ConfirmMultisigTransactionStateError value)? error,
    TResult? Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult? Function(ConfirmMultisigTransactionStateSending value)? sending,
  }) {
    return sending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult Function(ConfirmMultisigTransactionStateError value)? error,
    TResult Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult Function(ConfirmMultisigTransactionStateSending value)? sending,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(this);
    }
    return orElse();
  }
}

abstract class ConfirmMultisigTransactionStateSending
    implements ConfirmMultisigTransactionState {
  const factory ConfirmMultisigTransactionStateSending(
          {required final bool canClose}) =
      _$ConfirmMultisigTransactionStateSendingImpl;

  bool get canClose;

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmMultisigTransactionStateSendingImplCopyWith<
          _$ConfirmMultisigTransactionStateSendingImpl>
      get copyWith => throw _privateConstructorUsedError;
}
