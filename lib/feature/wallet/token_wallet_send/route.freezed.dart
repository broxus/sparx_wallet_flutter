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
mixin _$TokenWalletSendRouteData {
  /// Owner address
  Address get owner => throw _privateConstructorUsedError;

  /// Token contract address
  Address get rootTokenContract => throw _privateConstructorUsedError;

  /// Public key
  PublicKey get publicKey => throw _privateConstructorUsedError;

  /// Destination address
  Address get destination => throw _privateConstructorUsedError;

  /// Amount to send
  BigInt get amount => throw _privateConstructorUsedError;

  /// Attached amount (optional)
  BigInt? get attachedAmount => throw _privateConstructorUsedError;

  /// Comment for transaction (optional)
  String? get comment => throw _privateConstructorUsedError;

  /// Result message (optional)
  String? get resultMessage => throw _privateConstructorUsedError;

  /// Notify receiver flag (optional)
  bool? get notifyReceiver => throw _privateConstructorUsedError;

  /// Create a copy of TokenWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenWalletSendRouteDataCopyWith<TokenWalletSendRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenWalletSendRouteDataCopyWith<$Res> {
  factory $TokenWalletSendRouteDataCopyWith(TokenWalletSendRouteData value,
          $Res Function(TokenWalletSendRouteData) then) =
      _$TokenWalletSendRouteDataCopyWithImpl<$Res, TokenWalletSendRouteData>;
  @useResult
  $Res call(
      {Address owner,
      Address rootTokenContract,
      PublicKey publicKey,
      Address destination,
      BigInt amount,
      BigInt? attachedAmount,
      String? comment,
      String? resultMessage,
      bool? notifyReceiver});

  $AddressCopyWith<$Res> get owner;
  $AddressCopyWith<$Res> get rootTokenContract;
  $PublicKeyCopyWith<$Res> get publicKey;
  $AddressCopyWith<$Res> get destination;
}

/// @nodoc
class _$TokenWalletSendRouteDataCopyWithImpl<$Res,
        $Val extends TokenWalletSendRouteData>
    implements $TokenWalletSendRouteDataCopyWith<$Res> {
  _$TokenWalletSendRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owner = null,
    Object? rootTokenContract = null,
    Object? publicKey = null,
    Object? destination = null,
    Object? amount = null,
    Object? attachedAmount = freezed,
    Object? comment = freezed,
    Object? resultMessage = freezed,
    Object? notifyReceiver = freezed,
  }) {
    return _then(_value.copyWith(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Address,
      rootTokenContract: null == rootTokenContract
          ? _value.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
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
      attachedAmount: freezed == attachedAmount
          ? _value.attachedAmount
          : attachedAmount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      resultMessage: freezed == resultMessage
          ? _value.resultMessage
          : resultMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      notifyReceiver: freezed == notifyReceiver
          ? _value.notifyReceiver
          : notifyReceiver // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of TokenWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get owner {
    return $AddressCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }

  /// Create a copy of TokenWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get rootTokenContract {
    return $AddressCopyWith<$Res>(_value.rootTokenContract, (value) {
      return _then(_value.copyWith(rootTokenContract: value) as $Val);
    });
  }

  /// Create a copy of TokenWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get publicKey {
    return $PublicKeyCopyWith<$Res>(_value.publicKey, (value) {
      return _then(_value.copyWith(publicKey: value) as $Val);
    });
  }

  /// Create a copy of TokenWalletSendRouteData
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
abstract class _$$TokenWalletSendRouteDataImplCopyWith<$Res>
    implements $TokenWalletSendRouteDataCopyWith<$Res> {
  factory _$$TokenWalletSendRouteDataImplCopyWith(
          _$TokenWalletSendRouteDataImpl value,
          $Res Function(_$TokenWalletSendRouteDataImpl) then) =
      __$$TokenWalletSendRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Address owner,
      Address rootTokenContract,
      PublicKey publicKey,
      Address destination,
      BigInt amount,
      BigInt? attachedAmount,
      String? comment,
      String? resultMessage,
      bool? notifyReceiver});

  @override
  $AddressCopyWith<$Res> get owner;
  @override
  $AddressCopyWith<$Res> get rootTokenContract;
  @override
  $PublicKeyCopyWith<$Res> get publicKey;
  @override
  $AddressCopyWith<$Res> get destination;
}

/// @nodoc
class __$$TokenWalletSendRouteDataImplCopyWithImpl<$Res>
    extends _$TokenWalletSendRouteDataCopyWithImpl<$Res,
        _$TokenWalletSendRouteDataImpl>
    implements _$$TokenWalletSendRouteDataImplCopyWith<$Res> {
  __$$TokenWalletSendRouteDataImplCopyWithImpl(
      _$TokenWalletSendRouteDataImpl _value,
      $Res Function(_$TokenWalletSendRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owner = null,
    Object? rootTokenContract = null,
    Object? publicKey = null,
    Object? destination = null,
    Object? amount = null,
    Object? attachedAmount = freezed,
    Object? comment = freezed,
    Object? resultMessage = freezed,
    Object? notifyReceiver = freezed,
  }) {
    return _then(_$TokenWalletSendRouteDataImpl(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Address,
      rootTokenContract: null == rootTokenContract
          ? _value.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
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
      attachedAmount: freezed == attachedAmount
          ? _value.attachedAmount
          : attachedAmount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      resultMessage: freezed == resultMessage
          ? _value.resultMessage
          : resultMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      notifyReceiver: freezed == notifyReceiver
          ? _value.notifyReceiver
          : notifyReceiver // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$TokenWalletSendRouteDataImpl extends _TokenWalletSendRouteData {
  const _$TokenWalletSendRouteDataImpl(
      {required this.owner,
      required this.rootTokenContract,
      required this.publicKey,
      required this.destination,
      required this.amount,
      this.attachedAmount,
      this.comment,
      this.resultMessage,
      this.notifyReceiver})
      : super._();

  /// Owner address
  @override
  final Address owner;

  /// Token contract address
  @override
  final Address rootTokenContract;

  /// Public key
  @override
  final PublicKey publicKey;

  /// Destination address
  @override
  final Address destination;

  /// Amount to send
  @override
  final BigInt amount;

  /// Attached amount (optional)
  @override
  final BigInt? attachedAmount;

  /// Comment for transaction (optional)
  @override
  final String? comment;

  /// Result message (optional)
  @override
  final String? resultMessage;

  /// Notify receiver flag (optional)
  @override
  final bool? notifyReceiver;

  @override
  String toString() {
    return 'TokenWalletSendRouteData(owner: $owner, rootTokenContract: $rootTokenContract, publicKey: $publicKey, destination: $destination, amount: $amount, attachedAmount: $attachedAmount, comment: $comment, resultMessage: $resultMessage, notifyReceiver: $notifyReceiver)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenWalletSendRouteDataImpl &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.rootTokenContract, rootTokenContract) ||
                other.rootTokenContract == rootTokenContract) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.attachedAmount, attachedAmount) ||
                other.attachedAmount == attachedAmount) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.resultMessage, resultMessage) ||
                other.resultMessage == resultMessage) &&
            (identical(other.notifyReceiver, notifyReceiver) ||
                other.notifyReceiver == notifyReceiver));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      owner,
      rootTokenContract,
      publicKey,
      destination,
      amount,
      attachedAmount,
      comment,
      resultMessage,
      notifyReceiver);

  /// Create a copy of TokenWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenWalletSendRouteDataImplCopyWith<_$TokenWalletSendRouteDataImpl>
      get copyWith => __$$TokenWalletSendRouteDataImplCopyWithImpl<
          _$TokenWalletSendRouteDataImpl>(this, _$identity);
}

abstract class _TokenWalletSendRouteData extends TokenWalletSendRouteData {
  const factory _TokenWalletSendRouteData(
      {required final Address owner,
      required final Address rootTokenContract,
      required final PublicKey publicKey,
      required final Address destination,
      required final BigInt amount,
      final BigInt? attachedAmount,
      final String? comment,
      final String? resultMessage,
      final bool? notifyReceiver}) = _$TokenWalletSendRouteDataImpl;
  const _TokenWalletSendRouteData._() : super._();

  /// Owner address
  @override
  Address get owner;

  /// Token contract address
  @override
  Address get rootTokenContract;

  /// Public key
  @override
  PublicKey get publicKey;

  /// Destination address
  @override
  Address get destination;

  /// Amount to send
  @override
  BigInt get amount;

  /// Attached amount (optional)
  @override
  BigInt? get attachedAmount;

  /// Comment for transaction (optional)
  @override
  String? get comment;

  /// Result message (optional)
  @override
  String? get resultMessage;

  /// Notify receiver flag (optional)
  @override
  bool? get notifyReceiver;

  /// Create a copy of TokenWalletSendRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenWalletSendRouteDataImplCopyWith<_$TokenWalletSendRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
