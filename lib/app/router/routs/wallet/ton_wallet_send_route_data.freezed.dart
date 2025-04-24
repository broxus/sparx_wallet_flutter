// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_wallet_send_route_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TonWalletSendRouteData {
  /// Address of TonWallet that will be used to send funds
  Address get address => throw _privateConstructorUsedError;

  /// Custodian of [address] that will be initiator of transaction (for not
  /// multisig this is main key).
  PublicKey get publicKey => throw _privateConstructorUsedError;

  /// Address where funds should be sent
  Address get destination => throw _privateConstructorUsedError;

  /// Amount of tokens that should be sent, to convert Fixed to BigInt, use
  /// [Fixed.minorUnits].
  BigInt get amount => throw _privateConstructorUsedError;

  /// If true - after transaction send screen will be popped with true-result
  /// else - navigate to wallet
  bool get popOnComplete => throw _privateConstructorUsedError;

  /// Ammount that will be just added to [amount]
  BigInt? get attachedAmount => throw _privateConstructorUsedError;

  /// Comment for transaction
  String? get comment => throw _privateConstructorUsedError;

  /// Transaction payload
  String? get payload => throw _privateConstructorUsedError;

  /// Message that will be shown when transaction sending completed
  String? get resultMessage => throw _privateConstructorUsedError;

  /// Create a copy of TonWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TonWalletSendRouteDataCopyWith<TonWalletSendRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonWalletSendRouteDataCopyWith<$Res> {
  factory $TonWalletSendRouteDataCopyWith(TonWalletSendRouteData value,
          $Res Function(TonWalletSendRouteData) then) =
      _$TonWalletSendRouteDataCopyWithImpl<$Res, TonWalletSendRouteData>;
  @useResult
  $Res call(
      {Address address,
      PublicKey publicKey,
      Address destination,
      BigInt amount,
      bool popOnComplete,
      BigInt? attachedAmount,
      String? comment,
      String? payload,
      String? resultMessage});

  $AddressCopyWith<$Res> get address;
  $PublicKeyCopyWith<$Res> get publicKey;
  $AddressCopyWith<$Res> get destination;
}

/// @nodoc
class _$TonWalletSendRouteDataCopyWithImpl<$Res,
        $Val extends TonWalletSendRouteData>
    implements $TonWalletSendRouteDataCopyWith<$Res> {
  _$TonWalletSendRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TonWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? publicKey = null,
    Object? destination = null,
    Object? amount = null,
    Object? popOnComplete = null,
    Object? attachedAmount = freezed,
    Object? comment = freezed,
    Object? payload = freezed,
    Object? resultMessage = freezed,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      popOnComplete: null == popOnComplete
          ? _value.popOnComplete
          : popOnComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      attachedAmount: freezed == attachedAmount
          ? _value.attachedAmount
          : attachedAmount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String?,
      resultMessage: freezed == resultMessage
          ? _value.resultMessage
          : resultMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of TonWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of TonWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get publicKey {
    return $PublicKeyCopyWith<$Res>(_value.publicKey, (value) {
      return _then(_value.copyWith(publicKey: value) as $Val);
    });
  }

  /// Create a copy of TonWalletSendRouteData
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
abstract class _$$TonWalletSendRouteDataImplCopyWith<$Res>
    implements $TonWalletSendRouteDataCopyWith<$Res> {
  factory _$$TonWalletSendRouteDataImplCopyWith(
          _$TonWalletSendRouteDataImpl value,
          $Res Function(_$TonWalletSendRouteDataImpl) then) =
      __$$TonWalletSendRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Address address,
      PublicKey publicKey,
      Address destination,
      BigInt amount,
      bool popOnComplete,
      BigInt? attachedAmount,
      String? comment,
      String? payload,
      String? resultMessage});

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $PublicKeyCopyWith<$Res> get publicKey;
  @override
  $AddressCopyWith<$Res> get destination;
}

/// @nodoc
class __$$TonWalletSendRouteDataImplCopyWithImpl<$Res>
    extends _$TonWalletSendRouteDataCopyWithImpl<$Res,
        _$TonWalletSendRouteDataImpl>
    implements _$$TonWalletSendRouteDataImplCopyWith<$Res> {
  __$$TonWalletSendRouteDataImplCopyWithImpl(
      _$TonWalletSendRouteDataImpl _value,
      $Res Function(_$TonWalletSendRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? publicKey = null,
    Object? destination = null,
    Object? amount = null,
    Object? popOnComplete = null,
    Object? attachedAmount = freezed,
    Object? comment = freezed,
    Object? payload = freezed,
    Object? resultMessage = freezed,
  }) {
    return _then(_$TonWalletSendRouteDataImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      popOnComplete: null == popOnComplete
          ? _value.popOnComplete
          : popOnComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      attachedAmount: freezed == attachedAmount
          ? _value.attachedAmount
          : attachedAmount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String?,
      resultMessage: freezed == resultMessage
          ? _value.resultMessage
          : resultMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TonWalletSendRouteDataImpl extends _TonWalletSendRouteData {
  const _$TonWalletSendRouteDataImpl(
      {required this.address,
      required this.publicKey,
      required this.destination,
      required this.amount,
      required this.popOnComplete,
      this.attachedAmount,
      this.comment,
      this.payload,
      this.resultMessage})
      : super._();

  /// Address of TonWallet that will be used to send funds
  @override
  final Address address;

  /// Custodian of [address] that will be initiator of transaction (for not
  /// multisig this is main key).
  @override
  final PublicKey publicKey;

  /// Address where funds should be sent
  @override
  final Address destination;

  /// Amount of tokens that should be sent, to convert Fixed to BigInt, use
  /// [Fixed.minorUnits].
  @override
  final BigInt amount;

  /// If true - after transaction send screen will be popped with true-result
  /// else - navigate to wallet
  @override
  final bool popOnComplete;

  /// Ammount that will be just added to [amount]
  @override
  final BigInt? attachedAmount;

  /// Comment for transaction
  @override
  final String? comment;

  /// Transaction payload
  @override
  final String? payload;

  /// Message that will be shown when transaction sending completed
  @override
  final String? resultMessage;

  @override
  String toString() {
    return 'TonWalletSendRouteData(address: $address, publicKey: $publicKey, destination: $destination, amount: $amount, popOnComplete: $popOnComplete, attachedAmount: $attachedAmount, comment: $comment, payload: $payload, resultMessage: $resultMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonWalletSendRouteDataImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.popOnComplete, popOnComplete) ||
                other.popOnComplete == popOnComplete) &&
            (identical(other.attachedAmount, attachedAmount) ||
                other.attachedAmount == attachedAmount) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.resultMessage, resultMessage) ||
                other.resultMessage == resultMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, publicKey, destination,
      amount, popOnComplete, attachedAmount, comment, payload, resultMessage);

  /// Create a copy of TonWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonWalletSendRouteDataImplCopyWith<_$TonWalletSendRouteDataImpl>
      get copyWith => __$$TonWalletSendRouteDataImplCopyWithImpl<
          _$TonWalletSendRouteDataImpl>(this, _$identity);
}

abstract class _TonWalletSendRouteData extends TonWalletSendRouteData {
  const factory _TonWalletSendRouteData(
      {required final Address address,
      required final PublicKey publicKey,
      required final Address destination,
      required final BigInt amount,
      required final bool popOnComplete,
      final BigInt? attachedAmount,
      final String? comment,
      final String? payload,
      final String? resultMessage}) = _$TonWalletSendRouteDataImpl;
  const _TonWalletSendRouteData._() : super._();

  /// Address of TonWallet that will be used to send funds
  @override
  Address get address;

  /// Custodian of [address] that will be initiator of transaction (for not
  /// multisig this is main key).
  @override
  PublicKey get publicKey;

  /// Address where funds should be sent
  @override
  Address get destination;

  /// Amount of tokens that should be sent, to convert Fixed to BigInt, use
  /// [Fixed.minorUnits].
  @override
  BigInt get amount;

  /// If true - after transaction send screen will be popped with true-result
  /// else - navigate to wallet
  @override
  bool get popOnComplete;

  /// Ammount that will be just added to [amount]
  @override
  BigInt? get attachedAmount;

  /// Comment for transaction
  @override
  String? get comment;

  /// Transaction payload
  @override
  String? get payload;

  /// Message that will be shown when transaction sending completed
  @override
  String? get resultMessage;

  /// Create a copy of TonWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonWalletSendRouteDataImplCopyWith<_$TonWalletSendRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
