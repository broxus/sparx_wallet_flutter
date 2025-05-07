// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConfirmMultisigTransactionRouteData {
  /// Address of wallet which will be used to confirm transaction
  Address get walletAddress => throw _privateConstructorUsedError;

  /// Local custodians that CAN CONFIRM transaction (not all local)
  List<PublicKey> get localCustodians => throw _privateConstructorUsedError;

  /// Transaction that should be confirmed
  String get transactionId => throw _privateConstructorUsedError;

  /// Amount of transaction
  BigInt get amount => throw _privateConstructorUsedError;

  /// Destination where funds should be sent
  Address get destination => throw _privateConstructorUsedError;

  /// Transaction id hash
  String? get transactionIdHash => throw _privateConstructorUsedError;

  /// Comment of transaction
  String? get comment => throw _privateConstructorUsedError;

  /// Create a copy of ConfirmMultisigTransactionRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfirmMultisigTransactionRouteDataCopyWith<
          ConfirmMultisigTransactionRouteData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmMultisigTransactionRouteDataCopyWith<$Res> {
  factory $ConfirmMultisigTransactionRouteDataCopyWith(
          ConfirmMultisigTransactionRouteData value,
          $Res Function(ConfirmMultisigTransactionRouteData) then) =
      _$ConfirmMultisigTransactionRouteDataCopyWithImpl<$Res,
          ConfirmMultisigTransactionRouteData>;
  @useResult
  $Res call(
      {Address walletAddress,
      List<PublicKey> localCustodians,
      String transactionId,
      BigInt amount,
      Address destination,
      String? transactionIdHash,
      String? comment});

  $AddressCopyWith<$Res> get walletAddress;
  $AddressCopyWith<$Res> get destination;
}

/// @nodoc
class _$ConfirmMultisigTransactionRouteDataCopyWithImpl<$Res,
        $Val extends ConfirmMultisigTransactionRouteData>
    implements $ConfirmMultisigTransactionRouteDataCopyWith<$Res> {
  _$ConfirmMultisigTransactionRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfirmMultisigTransactionRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletAddress = null,
    Object? localCustodians = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? destination = null,
    Object? transactionIdHash = freezed,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      localCustodians: null == localCustodians
          ? _value.localCustodians
          : localCustodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address,
      transactionIdHash: freezed == transactionIdHash
          ? _value.transactionIdHash
          : transactionIdHash // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ConfirmMultisigTransactionRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get walletAddress {
    return $AddressCopyWith<$Res>(_value.walletAddress, (value) {
      return _then(_value.copyWith(walletAddress: value) as $Val);
    });
  }

  /// Create a copy of ConfirmMultisigTransactionRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get destination {
    return $AddressCopyWith<$Res>(_value.destination, (value) {
      return _then(_value.copyWith(destination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConfirmMultisigTransactionRouteDataImplCopyWith<$Res>
    implements $ConfirmMultisigTransactionRouteDataCopyWith<$Res> {
  factory _$$ConfirmMultisigTransactionRouteDataImplCopyWith(
          _$ConfirmMultisigTransactionRouteDataImpl value,
          $Res Function(_$ConfirmMultisigTransactionRouteDataImpl) then) =
      __$$ConfirmMultisigTransactionRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Address walletAddress,
      List<PublicKey> localCustodians,
      String transactionId,
      BigInt amount,
      Address destination,
      String? transactionIdHash,
      String? comment});

  @override
  $AddressCopyWith<$Res> get walletAddress;
  @override
  $AddressCopyWith<$Res> get destination;
}

/// @nodoc
class __$$ConfirmMultisigTransactionRouteDataImplCopyWithImpl<$Res>
    extends _$ConfirmMultisigTransactionRouteDataCopyWithImpl<$Res,
        _$ConfirmMultisigTransactionRouteDataImpl>
    implements _$$ConfirmMultisigTransactionRouteDataImplCopyWith<$Res> {
  __$$ConfirmMultisigTransactionRouteDataImplCopyWithImpl(
      _$ConfirmMultisigTransactionRouteDataImpl _value,
      $Res Function(_$ConfirmMultisigTransactionRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConfirmMultisigTransactionRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletAddress = null,
    Object? localCustodians = null,
    Object? transactionId = null,
    Object? amount = null,
    Object? destination = null,
    Object? transactionIdHash = freezed,
    Object? comment = freezed,
  }) {
    return _then(_$ConfirmMultisigTransactionRouteDataImpl(
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      localCustodians: null == localCustodians
          ? _value._localCustodians
          : localCustodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address,
      transactionIdHash: freezed == transactionIdHash
          ? _value.transactionIdHash
          : transactionIdHash // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ConfirmMultisigTransactionRouteDataImpl
    extends _ConfirmMultisigTransactionRouteData {
  const _$ConfirmMultisigTransactionRouteDataImpl(
      {required this.walletAddress,
      required final List<PublicKey> localCustodians,
      required this.transactionId,
      required this.amount,
      required this.destination,
      this.transactionIdHash,
      this.comment})
      : _localCustodians = localCustodians,
        super._();

  /// Address of wallet which will be used to confirm transaction
  @override
  final Address walletAddress;

  /// Local custodians that CAN CONFIRM transaction (not all local)
  final List<PublicKey> _localCustodians;

  /// Local custodians that CAN CONFIRM transaction (not all local)
  @override
  List<PublicKey> get localCustodians {
    if (_localCustodians is EqualUnmodifiableListView) return _localCustodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_localCustodians);
  }

  /// Transaction that should be confirmed
  @override
  final String transactionId;

  /// Amount of transaction
  @override
  final BigInt amount;

  /// Destination where funds should be sent
  @override
  final Address destination;

  /// Transaction id hash
  @override
  final String? transactionIdHash;

  /// Comment of transaction
  @override
  final String? comment;

  @override
  String toString() {
    return 'ConfirmMultisigTransactionRouteData(walletAddress: $walletAddress, localCustodians: $localCustodians, transactionId: $transactionId, amount: $amount, destination: $destination, transactionIdHash: $transactionIdHash, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmMultisigTransactionRouteDataImpl &&
            (identical(other.walletAddress, walletAddress) ||
                other.walletAddress == walletAddress) &&
            const DeepCollectionEquality()
                .equals(other._localCustodians, _localCustodians) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.transactionIdHash, transactionIdHash) ||
                other.transactionIdHash == transactionIdHash) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      walletAddress,
      const DeepCollectionEquality().hash(_localCustodians),
      transactionId,
      amount,
      destination,
      transactionIdHash,
      comment);

  /// Create a copy of ConfirmMultisigTransactionRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmMultisigTransactionRouteDataImplCopyWith<
          _$ConfirmMultisigTransactionRouteDataImpl>
      get copyWith => __$$ConfirmMultisigTransactionRouteDataImplCopyWithImpl<
          _$ConfirmMultisigTransactionRouteDataImpl>(this, _$identity);
}

abstract class _ConfirmMultisigTransactionRouteData
    extends ConfirmMultisigTransactionRouteData {
  const factory _ConfirmMultisigTransactionRouteData(
      {required final Address walletAddress,
      required final List<PublicKey> localCustodians,
      required final String transactionId,
      required final BigInt amount,
      required final Address destination,
      final String? transactionIdHash,
      final String? comment}) = _$ConfirmMultisigTransactionRouteDataImpl;
  const _ConfirmMultisigTransactionRouteData._() : super._();

  /// Address of wallet which will be used to confirm transaction
  @override
  Address get walletAddress;

  /// Local custodians that CAN CONFIRM transaction (not all local)
  @override
  List<PublicKey> get localCustodians;

  /// Transaction that should be confirmed
  @override
  String get transactionId;

  /// Amount of transaction
  @override
  BigInt get amount;

  /// Destination where funds should be sent
  @override
  Address get destination;

  /// Transaction id hash
  @override
  String? get transactionIdHash;

  /// Comment of transaction
  @override
  String? get comment;

  /// Create a copy of ConfirmMultisigTransactionRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmMultisigTransactionRouteDataImplCopyWith<
          _$ConfirmMultisigTransactionRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
