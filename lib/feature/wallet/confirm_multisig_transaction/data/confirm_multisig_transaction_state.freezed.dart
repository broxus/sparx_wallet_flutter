// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
