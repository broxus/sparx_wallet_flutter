// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_multisig_transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConfirmMultisigTransactionState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConfirmMultisigTransactionState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConfirmMultisigTransactionState()';
  }
}

/// @nodoc
class $ConfirmMultisigTransactionStateCopyWith<$Res> {
  $ConfirmMultisigTransactionStateCopyWith(ConfirmMultisigTransactionState _,
      $Res Function(ConfirmMultisigTransactionState) __);
}

/// Adds pattern-matching-related methods to [ConfirmMultisigTransactionState].
extension ConfirmMultisigTransactionStatePatterns
    on ConfirmMultisigTransactionState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult Function(ConfirmMultisigTransactionStateError value)? error,
    TResult Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult Function(ConfirmMultisigTransactionStateSending value)? sending,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ConfirmMultisigTransactionStatePrepare() when prepare != null:
        return prepare(_that);
      case ConfirmMultisigTransactionStateError() when error != null:
        return error(_that);
      case ConfirmMultisigTransactionStateReady() when ready != null:
        return ready(_that);
      case ConfirmMultisigTransactionStateSending() when sending != null:
        return sending(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConfirmMultisigTransactionStatePrepare value)
        prepare,
    required TResult Function(ConfirmMultisigTransactionStateError value) error,
    required TResult Function(ConfirmMultisigTransactionStateReady value) ready,
    required TResult Function(ConfirmMultisigTransactionStateSending value)
        sending,
  }) {
    final _that = this;
    switch (_that) {
      case ConfirmMultisigTransactionStatePrepare():
        return prepare(_that);
      case ConfirmMultisigTransactionStateError():
        return error(_that);
      case ConfirmMultisigTransactionStateReady():
        return ready(_that);
      case ConfirmMultisigTransactionStateSending():
        return sending(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConfirmMultisigTransactionStatePrepare value)? prepare,
    TResult? Function(ConfirmMultisigTransactionStateError value)? error,
    TResult? Function(ConfirmMultisigTransactionStateReady value)? ready,
    TResult? Function(ConfirmMultisigTransactionStateSending value)? sending,
  }) {
    final _that = this;
    switch (_that) {
      case ConfirmMultisigTransactionStatePrepare() when prepare != null:
        return prepare(_that);
      case ConfirmMultisigTransactionStateError() when error != null:
        return error(_that);
      case ConfirmMultisigTransactionStateReady() when ready != null:
        return ready(_that);
      case ConfirmMultisigTransactionStateSending() when sending != null:
        return sending(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prepare,
    TResult Function(Object error)? error,
    TResult Function(PublicKey custodian)? ready,
    TResult Function(bool canClose)? sending,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ConfirmMultisigTransactionStatePrepare() when prepare != null:
        return prepare();
      case ConfirmMultisigTransactionStateError() when error != null:
        return error(_that.error);
      case ConfirmMultisigTransactionStateReady() when ready != null:
        return ready(_that.custodian);
      case ConfirmMultisigTransactionStateSending() when sending != null:
        return sending(_that.canClose);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prepare,
    required TResult Function(Object error) error,
    required TResult Function(PublicKey custodian) ready,
    required TResult Function(bool canClose) sending,
  }) {
    final _that = this;
    switch (_that) {
      case ConfirmMultisigTransactionStatePrepare():
        return prepare();
      case ConfirmMultisigTransactionStateError():
        return error(_that.error);
      case ConfirmMultisigTransactionStateReady():
        return ready(_that.custodian);
      case ConfirmMultisigTransactionStateSending():
        return sending(_that.canClose);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? prepare,
    TResult? Function(Object error)? error,
    TResult? Function(PublicKey custodian)? ready,
    TResult? Function(bool canClose)? sending,
  }) {
    final _that = this;
    switch (_that) {
      case ConfirmMultisigTransactionStatePrepare() when prepare != null:
        return prepare();
      case ConfirmMultisigTransactionStateError() when error != null:
        return error(_that.error);
      case ConfirmMultisigTransactionStateReady() when ready != null:
        return ready(_that.custodian);
      case ConfirmMultisigTransactionStateSending() when sending != null:
        return sending(_that.canClose);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ConfirmMultisigTransactionStatePrepare
    implements ConfirmMultisigTransactionState {
  const ConfirmMultisigTransactionStatePrepare();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConfirmMultisigTransactionStatePrepare);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConfirmMultisigTransactionState.prepare()';
  }
}

/// @nodoc

class ConfirmMultisigTransactionStateError
    implements ConfirmMultisigTransactionState {
  const ConfirmMultisigTransactionStateError({required this.error});

  final Object error;

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConfirmMultisigTransactionStateErrorCopyWith<
          ConfirmMultisigTransactionStateError>
      get copyWith => _$ConfirmMultisigTransactionStateErrorCopyWithImpl<
          ConfirmMultisigTransactionStateError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConfirmMultisigTransactionStateError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'ConfirmMultisigTransactionState.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $ConfirmMultisigTransactionStateErrorCopyWith<$Res>
    implements $ConfirmMultisigTransactionStateCopyWith<$Res> {
  factory $ConfirmMultisigTransactionStateErrorCopyWith(
          ConfirmMultisigTransactionStateError value,
          $Res Function(ConfirmMultisigTransactionStateError) _then) =
      _$ConfirmMultisigTransactionStateErrorCopyWithImpl;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class _$ConfirmMultisigTransactionStateErrorCopyWithImpl<$Res>
    implements $ConfirmMultisigTransactionStateErrorCopyWith<$Res> {
  _$ConfirmMultisigTransactionStateErrorCopyWithImpl(this._self, this._then);

  final ConfirmMultisigTransactionStateError _self;
  final $Res Function(ConfirmMultisigTransactionStateError) _then;

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(ConfirmMultisigTransactionStateError(
      error: null == error ? _self.error : error,
    ));
  }
}

/// @nodoc

class ConfirmMultisigTransactionStateReady
    implements ConfirmMultisigTransactionState {
  const ConfirmMultisigTransactionStateReady({required this.custodian});

  final PublicKey custodian;

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConfirmMultisigTransactionStateReadyCopyWith<
          ConfirmMultisigTransactionStateReady>
      get copyWith => _$ConfirmMultisigTransactionStateReadyCopyWithImpl<
          ConfirmMultisigTransactionStateReady>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConfirmMultisigTransactionStateReady &&
            (identical(other.custodian, custodian) ||
                other.custodian == custodian));
  }

  @override
  int get hashCode => Object.hash(runtimeType, custodian);

  @override
  String toString() {
    return 'ConfirmMultisigTransactionState.ready(custodian: $custodian)';
  }
}

/// @nodoc
abstract mixin class $ConfirmMultisigTransactionStateReadyCopyWith<$Res>
    implements $ConfirmMultisigTransactionStateCopyWith<$Res> {
  factory $ConfirmMultisigTransactionStateReadyCopyWith(
          ConfirmMultisigTransactionStateReady value,
          $Res Function(ConfirmMultisigTransactionStateReady) _then) =
      _$ConfirmMultisigTransactionStateReadyCopyWithImpl;
  @useResult
  $Res call({PublicKey custodian});

  $PublicKeyCopyWith<$Res> get custodian;
}

/// @nodoc
class _$ConfirmMultisigTransactionStateReadyCopyWithImpl<$Res>
    implements $ConfirmMultisigTransactionStateReadyCopyWith<$Res> {
  _$ConfirmMultisigTransactionStateReadyCopyWithImpl(this._self, this._then);

  final ConfirmMultisigTransactionStateReady _self;
  final $Res Function(ConfirmMultisigTransactionStateReady) _then;

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? custodian = null,
  }) {
    return _then(ConfirmMultisigTransactionStateReady(
      custodian: null == custodian
          ? _self.custodian
          : custodian // ignore: cast_nullable_to_non_nullable
              as PublicKey,
    ));
  }

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get custodian {
    return $PublicKeyCopyWith<$Res>(_self.custodian, (value) {
      return _then(_self.copyWith(custodian: value));
    });
  }
}

/// @nodoc

class ConfirmMultisigTransactionStateSending
    implements ConfirmMultisigTransactionState {
  const ConfirmMultisigTransactionStateSending({required this.canClose});

  final bool canClose;

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConfirmMultisigTransactionStateSendingCopyWith<
          ConfirmMultisigTransactionStateSending>
      get copyWith => _$ConfirmMultisigTransactionStateSendingCopyWithImpl<
          ConfirmMultisigTransactionStateSending>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConfirmMultisigTransactionStateSending &&
            (identical(other.canClose, canClose) ||
                other.canClose == canClose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canClose);

  @override
  String toString() {
    return 'ConfirmMultisigTransactionState.sending(canClose: $canClose)';
  }
}

/// @nodoc
abstract mixin class $ConfirmMultisigTransactionStateSendingCopyWith<$Res>
    implements $ConfirmMultisigTransactionStateCopyWith<$Res> {
  factory $ConfirmMultisigTransactionStateSendingCopyWith(
          ConfirmMultisigTransactionStateSending value,
          $Res Function(ConfirmMultisigTransactionStateSending) _then) =
      _$ConfirmMultisigTransactionStateSendingCopyWithImpl;
  @useResult
  $Res call({bool canClose});
}

/// @nodoc
class _$ConfirmMultisigTransactionStateSendingCopyWithImpl<$Res>
    implements $ConfirmMultisigTransactionStateSendingCopyWith<$Res> {
  _$ConfirmMultisigTransactionStateSendingCopyWithImpl(this._self, this._then);

  final ConfirmMultisigTransactionStateSending _self;
  final $Res Function(ConfirmMultisigTransactionStateSending) _then;

  /// Create a copy of ConfirmMultisigTransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? canClose = null,
  }) {
    return _then(ConfirmMultisigTransactionStateSending(
      canClose: null == canClose
          ? _self.canClose
          : canClose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
