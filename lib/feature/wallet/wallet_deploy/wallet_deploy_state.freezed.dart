// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_deploy_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletDeployState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is WalletDeployState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WalletDeployState()';
  }
}

/// @nodoc
class $WalletDeployStateCopyWith<$Res> {
  $WalletDeployStateCopyWith(
      WalletDeployState _, $Res Function(WalletDeployState) __);
}

/// @nodoc

class WalletDeployStateStandard implements WalletDeployState {
  const WalletDeployStateStandard();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WalletDeployStateStandard);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'WalletDeployState.standard()';
  }
}

/// @nodoc

class WalletDeployStateMultisig implements WalletDeployState {
  const WalletDeployStateMultisig(final List<PublicKey> custodians,
      this.requireConfirmations, this.hours, this.walletType)
      : _custodians = custodians;

  final List<PublicKey> _custodians;
  List<PublicKey> get custodians {
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_custodians);
  }

  final int requireConfirmations;
  final int hours;
  final WalletType walletType;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WalletDeployStateMultisigCopyWith<WalletDeployStateMultisig> get copyWith =>
      _$WalletDeployStateMultisigCopyWithImpl<WalletDeployStateMultisig>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WalletDeployStateMultisig &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians) &&
            (identical(other.requireConfirmations, requireConfirmations) ||
                other.requireConfirmations == requireConfirmations) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.walletType, walletType) ||
                other.walletType == walletType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_custodians),
      requireConfirmations,
      hours,
      walletType);

  @override
  String toString() {
    return 'WalletDeployState.multisig(custodians: $custodians, requireConfirmations: $requireConfirmations, hours: $hours, walletType: $walletType)';
  }
}

/// @nodoc
abstract mixin class $WalletDeployStateMultisigCopyWith<$Res>
    implements $WalletDeployStateCopyWith<$Res> {
  factory $WalletDeployStateMultisigCopyWith(WalletDeployStateMultisig value,
          $Res Function(WalletDeployStateMultisig) _then) =
      _$WalletDeployStateMultisigCopyWithImpl;
  @useResult
  $Res call(
      {List<PublicKey> custodians,
      int requireConfirmations,
      int hours,
      WalletType walletType});

  $WalletTypeCopyWith<$Res> get walletType;
}

/// @nodoc
class _$WalletDeployStateMultisigCopyWithImpl<$Res>
    implements $WalletDeployStateMultisigCopyWith<$Res> {
  _$WalletDeployStateMultisigCopyWithImpl(this._self, this._then);

  final WalletDeployStateMultisig _self;
  final $Res Function(WalletDeployStateMultisig) _then;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? custodians = null,
    Object? requireConfirmations = null,
    Object? hours = null,
    Object? walletType = null,
  }) {
    return _then(WalletDeployStateMultisig(
      null == custodians
          ? _self._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>,
      null == requireConfirmations
          ? _self.requireConfirmations
          : requireConfirmations // ignore: cast_nullable_to_non_nullable
              as int,
      null == hours
          ? _self.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int,
      null == walletType
          ? _self.walletType
          : walletType // ignore: cast_nullable_to_non_nullable
              as WalletType,
    ));
  }

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletTypeCopyWith<$Res> get walletType {
    return $WalletTypeCopyWith<$Res>(_self.walletType, (value) {
      return _then(_self.copyWith(walletType: value));
    });
  }
}

/// @nodoc

class WalletDeployStateCalculatingError implements WalletDeployState {
  const WalletDeployStateCalculatingError(
      {required this.error,
      this.fee,
      this.balance,
      final List<PublicKey>? custodians,
      this.requireConfirmations,
      this.tonIconPath,
      this.ticker,
      this.currency})
      : _custodians = custodians;

  final String error;
  final BigInt? fee;
  final BigInt? balance;
  final List<PublicKey>? _custodians;
  List<PublicKey>? get custodians {
    final value = _custodians;
    if (value == null) return null;
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final int? requireConfirmations;
  final String? tonIconPath;
  final String? ticker;
  final CustomCurrency? currency;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WalletDeployStateCalculatingErrorCopyWith<WalletDeployStateCalculatingError>
      get copyWith => _$WalletDeployStateCalculatingErrorCopyWithImpl<
          WalletDeployStateCalculatingError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WalletDeployStateCalculatingError &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians) &&
            (identical(other.requireConfirmations, requireConfirmations) ||
                other.requireConfirmations == requireConfirmations) &&
            (identical(other.tonIconPath, tonIconPath) ||
                other.tonIconPath == tonIconPath) &&
            (identical(other.ticker, ticker) || other.ticker == ticker) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      error,
      fee,
      balance,
      const DeepCollectionEquality().hash(_custodians),
      requireConfirmations,
      tonIconPath,
      ticker,
      currency);

  @override
  String toString() {
    return 'WalletDeployState.calculatingError(error: $error, fee: $fee, balance: $balance, custodians: $custodians, requireConfirmations: $requireConfirmations, tonIconPath: $tonIconPath, ticker: $ticker, currency: $currency)';
  }
}

/// @nodoc
abstract mixin class $WalletDeployStateCalculatingErrorCopyWith<$Res>
    implements $WalletDeployStateCopyWith<$Res> {
  factory $WalletDeployStateCalculatingErrorCopyWith(
          WalletDeployStateCalculatingError value,
          $Res Function(WalletDeployStateCalculatingError) _then) =
      _$WalletDeployStateCalculatingErrorCopyWithImpl;
  @useResult
  $Res call(
      {String error,
      BigInt? fee,
      BigInt? balance,
      List<PublicKey>? custodians,
      int? requireConfirmations,
      String? tonIconPath,
      String? ticker,
      CustomCurrency? currency});

  $CustomCurrencyCopyWith<$Res>? get currency;
}

/// @nodoc
class _$WalletDeployStateCalculatingErrorCopyWithImpl<$Res>
    implements $WalletDeployStateCalculatingErrorCopyWith<$Res> {
  _$WalletDeployStateCalculatingErrorCopyWithImpl(this._self, this._then);

  final WalletDeployStateCalculatingError _self;
  final $Res Function(WalletDeployStateCalculatingError) _then;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
    Object? fee = freezed,
    Object? balance = freezed,
    Object? custodians = freezed,
    Object? requireConfirmations = freezed,
    Object? tonIconPath = freezed,
    Object? ticker = freezed,
    Object? currency = freezed,
  }) {
    return _then(WalletDeployStateCalculatingError(
      error: null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      fee: freezed == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      balance: freezed == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      custodians: freezed == custodians
          ? _self._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>?,
      requireConfirmations: freezed == requireConfirmations
          ? _self.requireConfirmations
          : requireConfirmations // ignore: cast_nullable_to_non_nullable
              as int?,
      tonIconPath: freezed == tonIconPath
          ? _self.tonIconPath
          : tonIconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      ticker: freezed == ticker
          ? _self.ticker
          : ticker // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as CustomCurrency?,
    ));
  }

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomCurrencyCopyWith<$Res>? get currency {
    if (_self.currency == null) {
      return null;
    }

    return $CustomCurrencyCopyWith<$Res>(_self.currency!, (value) {
      return _then(_self.copyWith(currency: value));
    });
  }
}

/// @nodoc

class WalletDeployStateReadyToDeploy implements WalletDeployState {
  const WalletDeployStateReadyToDeploy(
      {required this.fee,
      required this.balance,
      required this.ledgerAuthInput,
      final List<PublicKey>? custodians,
      this.requireConfirmations,
      this.tonIconPath,
      this.ticker,
      this.currency,
      this.account,
      this.hours})
      : _custodians = custodians;

  final BigInt fee;
  final BigInt balance;
  final SignInputAuthLedger ledgerAuthInput;
  final List<PublicKey>? _custodians;
  List<PublicKey>? get custodians {
    final value = _custodians;
    if (value == null) return null;
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final int? requireConfirmations;
  final String? tonIconPath;
  final String? ticker;
  final CustomCurrency? currency;
  final KeyAccount? account;
  final int? hours;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WalletDeployStateReadyToDeployCopyWith<WalletDeployStateReadyToDeploy>
      get copyWith => _$WalletDeployStateReadyToDeployCopyWithImpl<
          WalletDeployStateReadyToDeploy>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WalletDeployStateReadyToDeploy &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.ledgerAuthInput, ledgerAuthInput) ||
                other.ledgerAuthInput == ledgerAuthInput) &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians) &&
            (identical(other.requireConfirmations, requireConfirmations) ||
                other.requireConfirmations == requireConfirmations) &&
            (identical(other.tonIconPath, tonIconPath) ||
                other.tonIconPath == tonIconPath) &&
            (identical(other.ticker, ticker) || other.ticker == ticker) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.hours, hours) || other.hours == hours));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fee,
      balance,
      ledgerAuthInput,
      const DeepCollectionEquality().hash(_custodians),
      requireConfirmations,
      tonIconPath,
      ticker,
      currency,
      account,
      hours);

  @override
  String toString() {
    return 'WalletDeployState.readyToDeploy(fee: $fee, balance: $balance, ledgerAuthInput: $ledgerAuthInput, custodians: $custodians, requireConfirmations: $requireConfirmations, tonIconPath: $tonIconPath, ticker: $ticker, currency: $currency, account: $account, hours: $hours)';
  }
}

/// @nodoc
abstract mixin class $WalletDeployStateReadyToDeployCopyWith<$Res>
    implements $WalletDeployStateCopyWith<$Res> {
  factory $WalletDeployStateReadyToDeployCopyWith(
          WalletDeployStateReadyToDeploy value,
          $Res Function(WalletDeployStateReadyToDeploy) _then) =
      _$WalletDeployStateReadyToDeployCopyWithImpl;
  @useResult
  $Res call(
      {BigInt fee,
      BigInt balance,
      SignInputAuthLedger ledgerAuthInput,
      List<PublicKey>? custodians,
      int? requireConfirmations,
      String? tonIconPath,
      String? ticker,
      CustomCurrency? currency,
      KeyAccount? account,
      int? hours});

  $CustomCurrencyCopyWith<$Res>? get currency;
}

/// @nodoc
class _$WalletDeployStateReadyToDeployCopyWithImpl<$Res>
    implements $WalletDeployStateReadyToDeployCopyWith<$Res> {
  _$WalletDeployStateReadyToDeployCopyWithImpl(this._self, this._then);

  final WalletDeployStateReadyToDeploy _self;
  final $Res Function(WalletDeployStateReadyToDeploy) _then;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fee = null,
    Object? balance = null,
    Object? ledgerAuthInput = null,
    Object? custodians = freezed,
    Object? requireConfirmations = freezed,
    Object? tonIconPath = freezed,
    Object? ticker = freezed,
    Object? currency = freezed,
    Object? account = freezed,
    Object? hours = freezed,
  }) {
    return _then(WalletDeployStateReadyToDeploy(
      fee: null == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as BigInt,
      ledgerAuthInput: null == ledgerAuthInput
          ? _self.ledgerAuthInput
          : ledgerAuthInput // ignore: cast_nullable_to_non_nullable
              as SignInputAuthLedger,
      custodians: freezed == custodians
          ? _self._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>?,
      requireConfirmations: freezed == requireConfirmations
          ? _self.requireConfirmations
          : requireConfirmations // ignore: cast_nullable_to_non_nullable
              as int?,
      tonIconPath: freezed == tonIconPath
          ? _self.tonIconPath
          : tonIconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      ticker: freezed == ticker
          ? _self.ticker
          : ticker // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as CustomCurrency?,
      account: freezed == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount?,
      hours: freezed == hours
          ? _self.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomCurrencyCopyWith<$Res>? get currency {
    if (_self.currency == null) {
      return null;
    }

    return $CustomCurrencyCopyWith<$Res>(_self.currency!, (value) {
      return _then(_self.copyWith(currency: value));
    });
  }
}

/// @nodoc

class WalletDeployStateDeploying implements WalletDeployState {
  const WalletDeployStateDeploying({required this.canClose});

  final bool canClose;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WalletDeployStateDeployingCopyWith<WalletDeployStateDeploying>
      get copyWith =>
          _$WalletDeployStateDeployingCopyWithImpl<WalletDeployStateDeploying>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WalletDeployStateDeploying &&
            (identical(other.canClose, canClose) ||
                other.canClose == canClose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canClose);

  @override
  String toString() {
    return 'WalletDeployState.deploying(canClose: $canClose)';
  }
}

/// @nodoc
abstract mixin class $WalletDeployStateDeployingCopyWith<$Res>
    implements $WalletDeployStateCopyWith<$Res> {
  factory $WalletDeployStateDeployingCopyWith(WalletDeployStateDeploying value,
          $Res Function(WalletDeployStateDeploying) _then) =
      _$WalletDeployStateDeployingCopyWithImpl;
  @useResult
  $Res call({bool canClose});
}

/// @nodoc
class _$WalletDeployStateDeployingCopyWithImpl<$Res>
    implements $WalletDeployStateDeployingCopyWith<$Res> {
  _$WalletDeployStateDeployingCopyWithImpl(this._self, this._then);

  final WalletDeployStateDeploying _self;
  final $Res Function(WalletDeployStateDeploying) _then;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? canClose = null,
  }) {
    return _then(WalletDeployStateDeploying(
      canClose: null == canClose
          ? _self.canClose
          : canClose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class WalletDeployStateDeployed implements WalletDeployState {
  const WalletDeployStateDeployed(
      {required this.fee,
      required this.balance,
      required this.transaction,
      final List<PublicKey>? custodians,
      this.requireConfirmations,
      this.tonIconPath})
      : _custodians = custodians;

  final BigInt fee;
  final BigInt balance;
  final Transaction transaction;
  final List<PublicKey>? _custodians;
  List<PublicKey>? get custodians {
    final value = _custodians;
    if (value == null) return null;
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final int? requireConfirmations;
  final String? tonIconPath;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WalletDeployStateDeployedCopyWith<WalletDeployStateDeployed> get copyWith =>
      _$WalletDeployStateDeployedCopyWithImpl<WalletDeployStateDeployed>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WalletDeployStateDeployed &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians) &&
            (identical(other.requireConfirmations, requireConfirmations) ||
                other.requireConfirmations == requireConfirmations) &&
            (identical(other.tonIconPath, tonIconPath) ||
                other.tonIconPath == tonIconPath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fee,
      balance,
      transaction,
      const DeepCollectionEquality().hash(_custodians),
      requireConfirmations,
      tonIconPath);

  @override
  String toString() {
    return 'WalletDeployState.deployed(fee: $fee, balance: $balance, transaction: $transaction, custodians: $custodians, requireConfirmations: $requireConfirmations, tonIconPath: $tonIconPath)';
  }
}

/// @nodoc
abstract mixin class $WalletDeployStateDeployedCopyWith<$Res>
    implements $WalletDeployStateCopyWith<$Res> {
  factory $WalletDeployStateDeployedCopyWith(WalletDeployStateDeployed value,
          $Res Function(WalletDeployStateDeployed) _then) =
      _$WalletDeployStateDeployedCopyWithImpl;
  @useResult
  $Res call(
      {BigInt fee,
      BigInt balance,
      Transaction transaction,
      List<PublicKey>? custodians,
      int? requireConfirmations,
      String? tonIconPath});

  $TransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class _$WalletDeployStateDeployedCopyWithImpl<$Res>
    implements $WalletDeployStateDeployedCopyWith<$Res> {
  _$WalletDeployStateDeployedCopyWithImpl(this._self, this._then);

  final WalletDeployStateDeployed _self;
  final $Res Function(WalletDeployStateDeployed) _then;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fee = null,
    Object? balance = null,
    Object? transaction = null,
    Object? custodians = freezed,
    Object? requireConfirmations = freezed,
    Object? tonIconPath = freezed,
  }) {
    return _then(WalletDeployStateDeployed(
      fee: null == fee
          ? _self.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      balance: null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as BigInt,
      transaction: null == transaction
          ? _self.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction,
      custodians: freezed == custodians
          ? _self._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>?,
      requireConfirmations: freezed == requireConfirmations
          ? _self.requireConfirmations
          : requireConfirmations // ignore: cast_nullable_to_non_nullable
              as int?,
      tonIconPath: freezed == tonIconPath
          ? _self.tonIconPath
          : tonIconPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res> get transaction {
    return $TransactionCopyWith<$Res>(_self.transaction, (value) {
      return _then(_self.copyWith(transaction: value));
    });
  }
}

/// @nodoc

class WalletDeployStateSubscribeError implements WalletDeployState {
  const WalletDeployStateSubscribeError(this.error);

  final Object error;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WalletDeployStateSubscribeErrorCopyWith<WalletDeployStateSubscribeError>
      get copyWith => _$WalletDeployStateSubscribeErrorCopyWithImpl<
          WalletDeployStateSubscribeError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WalletDeployStateSubscribeError &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'WalletDeployState.subscribeError(error: $error)';
  }
}

/// @nodoc
abstract mixin class $WalletDeployStateSubscribeErrorCopyWith<$Res>
    implements $WalletDeployStateCopyWith<$Res> {
  factory $WalletDeployStateSubscribeErrorCopyWith(
          WalletDeployStateSubscribeError value,
          $Res Function(WalletDeployStateSubscribeError) _then) =
      _$WalletDeployStateSubscribeErrorCopyWithImpl;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class _$WalletDeployStateSubscribeErrorCopyWithImpl<$Res>
    implements $WalletDeployStateSubscribeErrorCopyWith<$Res> {
  _$WalletDeployStateSubscribeErrorCopyWithImpl(this._self, this._then);

  final WalletDeployStateSubscribeError _self;
  final $Res Function(WalletDeployStateSubscribeError) _then;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(WalletDeployStateSubscribeError(
      null == error ? _self.error : error,
    ));
  }
}

// dart format on
