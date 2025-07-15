// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_wallet_ordinary_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenWalletOrdinaryTransaction {
  String get lt;
  bool get isOutgoing;
  Address get address;
  @amountJsonConverter
  BigInt get value;
  DateTime get date;
  @amountJsonConverter
  BigInt get fees;
  String get hash;
  String? get prevTransactionLt;
  TokenIncomingTransfer? get incomingTransfer;
  TokenOutgoingTransfer? get outgoingTransfer;
  TokenSwapBack? get swapBack;
  String? get accept;
  String? get transferBounced;
  String? get swapBackBounced;

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenWalletOrdinaryTransactionCopyWith<TokenWalletOrdinaryTransaction>
      get copyWith => _$TokenWalletOrdinaryTransactionCopyWithImpl<
              TokenWalletOrdinaryTransaction>(
          this as TokenWalletOrdinaryTransaction, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletOrdinaryTransaction &&
            (identical(other.lt, lt) || other.lt == lt) &&
            (identical(other.isOutgoing, isOutgoing) ||
                other.isOutgoing == isOutgoing) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.fees, fees) || other.fees == fees) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.prevTransactionLt, prevTransactionLt) ||
                other.prevTransactionLt == prevTransactionLt) &&
            (identical(other.incomingTransfer, incomingTransfer) ||
                other.incomingTransfer == incomingTransfer) &&
            (identical(other.outgoingTransfer, outgoingTransfer) ||
                other.outgoingTransfer == outgoingTransfer) &&
            (identical(other.swapBack, swapBack) ||
                other.swapBack == swapBack) &&
            (identical(other.accept, accept) || other.accept == accept) &&
            (identical(other.transferBounced, transferBounced) ||
                other.transferBounced == transferBounced) &&
            (identical(other.swapBackBounced, swapBackBounced) ||
                other.swapBackBounced == swapBackBounced));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      lt,
      isOutgoing,
      address,
      value,
      date,
      fees,
      hash,
      prevTransactionLt,
      incomingTransfer,
      outgoingTransfer,
      swapBack,
      accept,
      transferBounced,
      swapBackBounced);

  @override
  String toString() {
    return 'TokenWalletOrdinaryTransaction(lt: $lt, isOutgoing: $isOutgoing, address: $address, value: $value, date: $date, fees: $fees, hash: $hash, prevTransactionLt: $prevTransactionLt, incomingTransfer: $incomingTransfer, outgoingTransfer: $outgoingTransfer, swapBack: $swapBack, accept: $accept, transferBounced: $transferBounced, swapBackBounced: $swapBackBounced)';
  }
}

/// @nodoc
abstract mixin class $TokenWalletOrdinaryTransactionCopyWith<$Res> {
  factory $TokenWalletOrdinaryTransactionCopyWith(
          TokenWalletOrdinaryTransaction value,
          $Res Function(TokenWalletOrdinaryTransaction) _then) =
      _$TokenWalletOrdinaryTransactionCopyWithImpl;
  @useResult
  $Res call(
      {String lt,
      bool isOutgoing,
      Address address,
      @amountJsonConverter BigInt value,
      DateTime date,
      @amountJsonConverter BigInt fees,
      String hash,
      String? prevTransactionLt,
      TokenIncomingTransfer? incomingTransfer,
      TokenOutgoingTransfer? outgoingTransfer,
      TokenSwapBack? swapBack,
      String? accept,
      String? transferBounced,
      String? swapBackBounced});

  $AddressCopyWith<$Res> get address;
  $TokenIncomingTransferCopyWith<$Res>? get incomingTransfer;
  $TokenOutgoingTransferCopyWith<$Res>? get outgoingTransfer;
  $TokenSwapBackCopyWith<$Res>? get swapBack;
}

/// @nodoc
class _$TokenWalletOrdinaryTransactionCopyWithImpl<$Res>
    implements $TokenWalletOrdinaryTransactionCopyWith<$Res> {
  _$TokenWalletOrdinaryTransactionCopyWithImpl(this._self, this._then);

  final TokenWalletOrdinaryTransaction _self;
  final $Res Function(TokenWalletOrdinaryTransaction) _then;

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lt = null,
    Object? isOutgoing = null,
    Object? address = null,
    Object? value = null,
    Object? date = null,
    Object? fees = null,
    Object? hash = null,
    Object? prevTransactionLt = freezed,
    Object? incomingTransfer = freezed,
    Object? outgoingTransfer = freezed,
    Object? swapBack = freezed,
    Object? accept = freezed,
    Object? transferBounced = freezed,
    Object? swapBackBounced = freezed,
  }) {
    return _then(_self.copyWith(
      lt: null == lt
          ? _self.lt
          : lt // ignore: cast_nullable_to_non_nullable
              as String,
      isOutgoing: null == isOutgoing
          ? _self.isOutgoing
          : isOutgoing // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fees: null == fees
          ? _self.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as BigInt,
      hash: null == hash
          ? _self.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      prevTransactionLt: freezed == prevTransactionLt
          ? _self.prevTransactionLt
          : prevTransactionLt // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingTransfer: freezed == incomingTransfer
          ? _self.incomingTransfer
          : incomingTransfer // ignore: cast_nullable_to_non_nullable
              as TokenIncomingTransfer?,
      outgoingTransfer: freezed == outgoingTransfer
          ? _self.outgoingTransfer
          : outgoingTransfer // ignore: cast_nullable_to_non_nullable
              as TokenOutgoingTransfer?,
      swapBack: freezed == swapBack
          ? _self.swapBack
          : swapBack // ignore: cast_nullable_to_non_nullable
              as TokenSwapBack?,
      accept: freezed == accept
          ? _self.accept
          : accept // ignore: cast_nullable_to_non_nullable
              as String?,
      transferBounced: freezed == transferBounced
          ? _self.transferBounced
          : transferBounced // ignore: cast_nullable_to_non_nullable
              as String?,
      swapBackBounced: freezed == swapBackBounced
          ? _self.swapBackBounced
          : swapBackBounced // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenIncomingTransferCopyWith<$Res>? get incomingTransfer {
    if (_self.incomingTransfer == null) {
      return null;
    }

    return $TokenIncomingTransferCopyWith<$Res>(_self.incomingTransfer!,
        (value) {
      return _then(_self.copyWith(incomingTransfer: value));
    });
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenOutgoingTransferCopyWith<$Res>? get outgoingTransfer {
    if (_self.outgoingTransfer == null) {
      return null;
    }

    return $TokenOutgoingTransferCopyWith<$Res>(_self.outgoingTransfer!,
        (value) {
      return _then(_self.copyWith(outgoingTransfer: value));
    });
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenSwapBackCopyWith<$Res>? get swapBack {
    if (_self.swapBack == null) {
      return null;
    }

    return $TokenSwapBackCopyWith<$Res>(_self.swapBack!, (value) {
      return _then(_self.copyWith(swapBack: value));
    });
  }
}

/// @nodoc

class _TokenWalletOrdinaryTransaction
    implements TokenWalletOrdinaryTransaction {
  const _TokenWalletOrdinaryTransaction(
      {required this.lt,
      required this.isOutgoing,
      required this.address,
      @amountJsonConverter required this.value,
      required this.date,
      @amountJsonConverter required this.fees,
      required this.hash,
      this.prevTransactionLt,
      this.incomingTransfer,
      this.outgoingTransfer,
      this.swapBack,
      this.accept,
      this.transferBounced,
      this.swapBackBounced});

  @override
  final String lt;
  @override
  final bool isOutgoing;
  @override
  final Address address;
  @override
  @amountJsonConverter
  final BigInt value;
  @override
  final DateTime date;
  @override
  @amountJsonConverter
  final BigInt fees;
  @override
  final String hash;
  @override
  final String? prevTransactionLt;
  @override
  final TokenIncomingTransfer? incomingTransfer;
  @override
  final TokenOutgoingTransfer? outgoingTransfer;
  @override
  final TokenSwapBack? swapBack;
  @override
  final String? accept;
  @override
  final String? transferBounced;
  @override
  final String? swapBackBounced;

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokenWalletOrdinaryTransactionCopyWith<_TokenWalletOrdinaryTransaction>
      get copyWith => __$TokenWalletOrdinaryTransactionCopyWithImpl<
          _TokenWalletOrdinaryTransaction>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokenWalletOrdinaryTransaction &&
            (identical(other.lt, lt) || other.lt == lt) &&
            (identical(other.isOutgoing, isOutgoing) ||
                other.isOutgoing == isOutgoing) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.fees, fees) || other.fees == fees) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.prevTransactionLt, prevTransactionLt) ||
                other.prevTransactionLt == prevTransactionLt) &&
            (identical(other.incomingTransfer, incomingTransfer) ||
                other.incomingTransfer == incomingTransfer) &&
            (identical(other.outgoingTransfer, outgoingTransfer) ||
                other.outgoingTransfer == outgoingTransfer) &&
            (identical(other.swapBack, swapBack) ||
                other.swapBack == swapBack) &&
            (identical(other.accept, accept) || other.accept == accept) &&
            (identical(other.transferBounced, transferBounced) ||
                other.transferBounced == transferBounced) &&
            (identical(other.swapBackBounced, swapBackBounced) ||
                other.swapBackBounced == swapBackBounced));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      lt,
      isOutgoing,
      address,
      value,
      date,
      fees,
      hash,
      prevTransactionLt,
      incomingTransfer,
      outgoingTransfer,
      swapBack,
      accept,
      transferBounced,
      swapBackBounced);

  @override
  String toString() {
    return 'TokenWalletOrdinaryTransaction(lt: $lt, isOutgoing: $isOutgoing, address: $address, value: $value, date: $date, fees: $fees, hash: $hash, prevTransactionLt: $prevTransactionLt, incomingTransfer: $incomingTransfer, outgoingTransfer: $outgoingTransfer, swapBack: $swapBack, accept: $accept, transferBounced: $transferBounced, swapBackBounced: $swapBackBounced)';
  }
}

/// @nodoc
abstract mixin class _$TokenWalletOrdinaryTransactionCopyWith<$Res>
    implements $TokenWalletOrdinaryTransactionCopyWith<$Res> {
  factory _$TokenWalletOrdinaryTransactionCopyWith(
          _TokenWalletOrdinaryTransaction value,
          $Res Function(_TokenWalletOrdinaryTransaction) _then) =
      __$TokenWalletOrdinaryTransactionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String lt,
      bool isOutgoing,
      Address address,
      @amountJsonConverter BigInt value,
      DateTime date,
      @amountJsonConverter BigInt fees,
      String hash,
      String? prevTransactionLt,
      TokenIncomingTransfer? incomingTransfer,
      TokenOutgoingTransfer? outgoingTransfer,
      TokenSwapBack? swapBack,
      String? accept,
      String? transferBounced,
      String? swapBackBounced});

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $TokenIncomingTransferCopyWith<$Res>? get incomingTransfer;
  @override
  $TokenOutgoingTransferCopyWith<$Res>? get outgoingTransfer;
  @override
  $TokenSwapBackCopyWith<$Res>? get swapBack;
}

/// @nodoc
class __$TokenWalletOrdinaryTransactionCopyWithImpl<$Res>
    implements _$TokenWalletOrdinaryTransactionCopyWith<$Res> {
  __$TokenWalletOrdinaryTransactionCopyWithImpl(this._self, this._then);

  final _TokenWalletOrdinaryTransaction _self;
  final $Res Function(_TokenWalletOrdinaryTransaction) _then;

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lt = null,
    Object? isOutgoing = null,
    Object? address = null,
    Object? value = null,
    Object? date = null,
    Object? fees = null,
    Object? hash = null,
    Object? prevTransactionLt = freezed,
    Object? incomingTransfer = freezed,
    Object? outgoingTransfer = freezed,
    Object? swapBack = freezed,
    Object? accept = freezed,
    Object? transferBounced = freezed,
    Object? swapBackBounced = freezed,
  }) {
    return _then(_TokenWalletOrdinaryTransaction(
      lt: null == lt
          ? _self.lt
          : lt // ignore: cast_nullable_to_non_nullable
              as String,
      isOutgoing: null == isOutgoing
          ? _self.isOutgoing
          : isOutgoing // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fees: null == fees
          ? _self.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as BigInt,
      hash: null == hash
          ? _self.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      prevTransactionLt: freezed == prevTransactionLt
          ? _self.prevTransactionLt
          : prevTransactionLt // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingTransfer: freezed == incomingTransfer
          ? _self.incomingTransfer
          : incomingTransfer // ignore: cast_nullable_to_non_nullable
              as TokenIncomingTransfer?,
      outgoingTransfer: freezed == outgoingTransfer
          ? _self.outgoingTransfer
          : outgoingTransfer // ignore: cast_nullable_to_non_nullable
              as TokenOutgoingTransfer?,
      swapBack: freezed == swapBack
          ? _self.swapBack
          : swapBack // ignore: cast_nullable_to_non_nullable
              as TokenSwapBack?,
      accept: freezed == accept
          ? _self.accept
          : accept // ignore: cast_nullable_to_non_nullable
              as String?,
      transferBounced: freezed == transferBounced
          ? _self.transferBounced
          : transferBounced // ignore: cast_nullable_to_non_nullable
              as String?,
      swapBackBounced: freezed == swapBackBounced
          ? _self.swapBackBounced
          : swapBackBounced // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenIncomingTransferCopyWith<$Res>? get incomingTransfer {
    if (_self.incomingTransfer == null) {
      return null;
    }

    return $TokenIncomingTransferCopyWith<$Res>(_self.incomingTransfer!,
        (value) {
      return _then(_self.copyWith(incomingTransfer: value));
    });
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenOutgoingTransferCopyWith<$Res>? get outgoingTransfer {
    if (_self.outgoingTransfer == null) {
      return null;
    }

    return $TokenOutgoingTransferCopyWith<$Res>(_self.outgoingTransfer!,
        (value) {
      return _then(_self.copyWith(outgoingTransfer: value));
    });
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenSwapBackCopyWith<$Res>? get swapBack {
    if (_self.swapBack == null) {
      return null;
    }

    return $TokenSwapBackCopyWith<$Res>(_self.swapBack!, (value) {
      return _then(_self.copyWith(swapBack: value));
    });
  }
}

// dart format on
