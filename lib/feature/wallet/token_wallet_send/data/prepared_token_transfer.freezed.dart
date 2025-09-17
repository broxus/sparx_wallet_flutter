// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prepared_token_transfer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PreparedTokenTransfer {
  Address get destination;
  Address get owner;
  Address get rootTokenContract;

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PreparedTokenTransferCopyWith<PreparedTokenTransfer> get copyWith =>
      _$PreparedTokenTransferCopyWithImpl<PreparedTokenTransfer>(
          this as PreparedTokenTransfer, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PreparedTokenTransfer &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.rootTokenContract, rootTokenContract) ||
                other.rootTokenContract == rootTokenContract));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, destination, owner, rootTokenContract);

  @override
  String toString() {
    return 'PreparedTokenTransfer(destination: $destination, owner: $owner, rootTokenContract: $rootTokenContract)';
  }
}

/// @nodoc
abstract mixin class $PreparedTokenTransferCopyWith<$Res> {
  factory $PreparedTokenTransferCopyWith(PreparedTokenTransfer value,
          $Res Function(PreparedTokenTransfer) _then) =
      _$PreparedTokenTransferCopyWithImpl;
  @useResult
  $Res call({Address destination, Address owner, Address rootTokenContract});

  $AddressCopyWith<$Res> get destination;
  $AddressCopyWith<$Res> get owner;
  $AddressCopyWith<$Res> get rootTokenContract;
}

/// @nodoc
class _$PreparedTokenTransferCopyWithImpl<$Res>
    implements $PreparedTokenTransferCopyWith<$Res> {
  _$PreparedTokenTransferCopyWithImpl(this._self, this._then);

  final PreparedTokenTransfer _self;
  final $Res Function(PreparedTokenTransfer) _then;

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? destination = null,
    Object? owner = null,
    Object? rootTokenContract = null,
  }) {
    return _then(_self.copyWith(
      destination: null == destination
          ? _self.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address,
      owner: null == owner
          ? _self.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Address,
      rootTokenContract: null == rootTokenContract
          ? _self.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get destination {
    return $AddressCopyWith<$Res>(_self.destination, (value) {
      return _then(_self.copyWith(destination: value));
    });
  }

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get owner {
    return $AddressCopyWith<$Res>(_self.owner, (value) {
      return _then(_self.copyWith(owner: value));
    });
  }

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get rootTokenContract {
    return $AddressCopyWith<$Res>(_self.rootTokenContract, (value) {
      return _then(_self.copyWith(rootTokenContract: value));
    });
  }
}

/// @nodoc

class PreparedTokenTransferBasic implements PreparedTokenTransfer {
  const PreparedTokenTransferBasic(
      {required this.unsignedMessage,
      required this.destination,
      required this.attachedAmount,
      required this.owner,
      required this.rootTokenContract});

  final UnsignedMessage unsignedMessage;
  @override
  final Address destination;
  final BigInt attachedAmount;
  @override
  final Address owner;
  @override
  final Address rootTokenContract;

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PreparedTokenTransferBasicCopyWith<PreparedTokenTransferBasic>
      get copyWith =>
          _$PreparedTokenTransferBasicCopyWithImpl<PreparedTokenTransferBasic>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PreparedTokenTransferBasic &&
            (identical(other.unsignedMessage, unsignedMessage) ||
                other.unsignedMessage == unsignedMessage) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.attachedAmount, attachedAmount) ||
                other.attachedAmount == attachedAmount) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.rootTokenContract, rootTokenContract) ||
                other.rootTokenContract == rootTokenContract));
  }

  @override
  int get hashCode => Object.hash(runtimeType, unsignedMessage, destination,
      attachedAmount, owner, rootTokenContract);

  @override
  String toString() {
    return 'PreparedTokenTransfer.basic(unsignedMessage: $unsignedMessage, destination: $destination, attachedAmount: $attachedAmount, owner: $owner, rootTokenContract: $rootTokenContract)';
  }
}

/// @nodoc
abstract mixin class $PreparedTokenTransferBasicCopyWith<$Res>
    implements $PreparedTokenTransferCopyWith<$Res> {
  factory $PreparedTokenTransferBasicCopyWith(PreparedTokenTransferBasic value,
          $Res Function(PreparedTokenTransferBasic) _then) =
      _$PreparedTokenTransferBasicCopyWithImpl;
  @override
  @useResult
  $Res call(
      {UnsignedMessage unsignedMessage,
      Address destination,
      BigInt attachedAmount,
      Address owner,
      Address rootTokenContract});

  @override
  $AddressCopyWith<$Res> get destination;
  @override
  $AddressCopyWith<$Res> get owner;
  @override
  $AddressCopyWith<$Res> get rootTokenContract;
}

/// @nodoc
class _$PreparedTokenTransferBasicCopyWithImpl<$Res>
    implements $PreparedTokenTransferBasicCopyWith<$Res> {
  _$PreparedTokenTransferBasicCopyWithImpl(this._self, this._then);

  final PreparedTokenTransferBasic _self;
  final $Res Function(PreparedTokenTransferBasic) _then;

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? unsignedMessage = null,
    Object? destination = null,
    Object? attachedAmount = null,
    Object? owner = null,
    Object? rootTokenContract = null,
  }) {
    return _then(PreparedTokenTransferBasic(
      unsignedMessage: null == unsignedMessage
          ? _self.unsignedMessage
          : unsignedMessage // ignore: cast_nullable_to_non_nullable
              as UnsignedMessage,
      destination: null == destination
          ? _self.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address,
      attachedAmount: null == attachedAmount
          ? _self.attachedAmount
          : attachedAmount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      owner: null == owner
          ? _self.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Address,
      rootTokenContract: null == rootTokenContract
          ? _self.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get destination {
    return $AddressCopyWith<$Res>(_self.destination, (value) {
      return _then(_self.copyWith(destination: value));
    });
  }

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get owner {
    return $AddressCopyWith<$Res>(_self.owner, (value) {
      return _then(_self.copyWith(owner: value));
    });
  }

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get rootTokenContract {
    return $AddressCopyWith<$Res>(_self.rootTokenContract, (value) {
      return _then(_self.copyWith(rootTokenContract: value));
    });
  }
}

/// @nodoc

class PreparedTokenTransferGasless implements PreparedTokenTransfer {
  const PreparedTokenTransferGasless(
      {required this.amount,
      required this.hash,
      required this.payload,
      required this.destination,
      required this.owner,
      required this.rootTokenContract,
      required this.fee,
      required this.publicKey});

  final BigInt amount;
  final String hash;
  final String payload;
  @override
  final Address destination;
  @override
  final Address owner;
  @override
  final Address rootTokenContract;
  final Fee fee;
  final PublicKey publicKey;

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PreparedTokenTransferGaslessCopyWith<PreparedTokenTransferGasless>
      get copyWith => _$PreparedTokenTransferGaslessCopyWithImpl<
          PreparedTokenTransferGasless>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PreparedTokenTransferGasless &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.rootTokenContract, rootTokenContract) ||
                other.rootTokenContract == rootTokenContract) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, hash, payload,
      destination, owner, rootTokenContract, fee, publicKey);

  @override
  String toString() {
    return 'PreparedTokenTransfer.gasless(amount: $amount, hash: $hash, payload: $payload, destination: $destination, owner: $owner, rootTokenContract: $rootTokenContract, fee: $fee, publicKey: $publicKey)';
  }
}

/// @nodoc
abstract mixin class $PreparedTokenTransferGaslessCopyWith<$Res>
    implements $PreparedTokenTransferCopyWith<$Res> {
  factory $PreparedTokenTransferGaslessCopyWith(
          PreparedTokenTransferGasless value,
          $Res Function(PreparedTokenTransferGasless) _then) =
      _$PreparedTokenTransferGaslessCopyWithImpl;
  @override
  @useResult
  $Res call(
      {BigInt amount,
      String hash,
      String payload,
      Address destination,
      Address owner,
      Address rootTokenContract,
      Fee fee,
      PublicKey publicKey});

  @override
  $AddressCopyWith<$Res> get destination;
  @override
  $AddressCopyWith<$Res> get owner;
  @override
  $AddressCopyWith<$Res> get rootTokenContract;
  $FeeCopyWith<$Res> get fee;
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class _$PreparedTokenTransferGaslessCopyWithImpl<$Res>
    implements $PreparedTokenTransferGaslessCopyWith<$Res> {
  _$PreparedTokenTransferGaslessCopyWithImpl(this._self, this._then);

  final PreparedTokenTransferGasless _self;
  final $Res Function(PreparedTokenTransferGasless) _then;

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? amount = null,
    Object? hash = null,
    Object? payload = null,
    Object? destination = null,
    Object? owner = null,
    Object? rootTokenContract = null,
    Object? fee = null,
    Object? publicKey = null,
  }) {
    return _then(PreparedTokenTransferGasless(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      hash: null == hash
          ? _self.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _self.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address,
      owner: null == owner
          ? _self.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Address,
      rootTokenContract: null == rootTokenContract
          ? _self.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
              as Address,
      fee: null == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as Fee,
      publicKey: null == publicKey
          ? _self.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
    ));
  }

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get destination {
    return $AddressCopyWith<$Res>(_self.destination, (value) {
      return _then(_self.copyWith(destination: value));
    });
  }

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get owner {
    return $AddressCopyWith<$Res>(_self.owner, (value) {
      return _then(_self.copyWith(owner: value));
    });
  }

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get rootTokenContract {
    return $AddressCopyWith<$Res>(_self.rootTokenContract, (value) {
      return _then(_self.copyWith(rootTokenContract: value));
    });
  }

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeeCopyWith<$Res> get fee {
    return $FeeCopyWith<$Res>(_self.fee, (value) {
      return _then(_self.copyWith(fee: value));
    });
  }

  /// Create a copy of PreparedTokenTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get publicKey {
    return $PublicKeyCopyWith<$Res>(_self.publicKey, (value) {
      return _then(_self.copyWith(publicKey: value));
    });
  }
}

// dart format on
