// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_wallet_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TonWalletDetailsState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TonWalletDetailsState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TonWalletDetailsState()';
  }
}

/// @nodoc
class $TonWalletDetailsStateCopyWith<$Res> {
  $TonWalletDetailsStateCopyWith(
      TonWalletDetailsState _, $Res Function(TonWalletDetailsState) __);
}

/// @nodoc

class TonWalletDetailsStateInitial implements TonWalletDetailsState {
  const TonWalletDetailsStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonWalletDetailsStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TonWalletDetailsState.initial()';
  }
}

/// @nodoc

class TonWalletDetailsStateEmpty implements TonWalletDetailsState {
  const TonWalletDetailsStateEmpty();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonWalletDetailsStateEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TonWalletDetailsState.empty()';
  }
}

/// @nodoc

class TonWalletDetailsStateSubscribeError implements TonWalletDetailsState {
  const TonWalletDetailsStateSubscribeError(
      {required this.symbol,
      required this.account,
      required this.error,
      required this.isLoading});

  final String symbol;
  final KeyAccount account;
  final Object error;
  final bool isLoading;

  /// Create a copy of TonWalletDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonWalletDetailsStateSubscribeErrorCopyWith<
          TonWalletDetailsStateSubscribeError>
      get copyWith => _$TonWalletDetailsStateSubscribeErrorCopyWithImpl<
          TonWalletDetailsStateSubscribeError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonWalletDetailsStateSubscribeError &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.account, account) || other.account == account) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, symbol, account,
      const DeepCollectionEquality().hash(error), isLoading);

  @override
  String toString() {
    return 'TonWalletDetailsState.subscribeError(symbol: $symbol, account: $account, error: $error, isLoading: $isLoading)';
  }
}

/// @nodoc
abstract mixin class $TonWalletDetailsStateSubscribeErrorCopyWith<$Res>
    implements $TonWalletDetailsStateCopyWith<$Res> {
  factory $TonWalletDetailsStateSubscribeErrorCopyWith(
          TonWalletDetailsStateSubscribeError value,
          $Res Function(TonWalletDetailsStateSubscribeError) _then) =
      _$TonWalletDetailsStateSubscribeErrorCopyWithImpl;
  @useResult
  $Res call({String symbol, KeyAccount account, Object error, bool isLoading});
}

/// @nodoc
class _$TonWalletDetailsStateSubscribeErrorCopyWithImpl<$Res>
    implements $TonWalletDetailsStateSubscribeErrorCopyWith<$Res> {
  _$TonWalletDetailsStateSubscribeErrorCopyWithImpl(this._self, this._then);

  final TonWalletDetailsStateSubscribeError _self;
  final $Res Function(TonWalletDetailsStateSubscribeError) _then;

  /// Create a copy of TonWalletDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? symbol = null,
    Object? account = null,
    Object? error = null,
    Object? isLoading = null,
  }) {
    return _then(TonWalletDetailsStateSubscribeError(
      symbol: null == symbol
          ? _self.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      error: null == error ? _self.error : error,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class TonWalletDetailsStateData implements TonWalletDetailsState {
  const TonWalletDetailsStateData(
      {required this.symbol,
      required this.account,
      required this.tokenBalance,
      required this.fiatBalance});

  final String symbol;
  final KeyAccount account;
  final Money tokenBalance;
  final Money fiatBalance;

  /// Create a copy of TonWalletDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonWalletDetailsStateDataCopyWith<TonWalletDetailsStateData> get copyWith =>
      _$TonWalletDetailsStateDataCopyWithImpl<TonWalletDetailsStateData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonWalletDetailsStateData &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.tokenBalance, tokenBalance) ||
                other.tokenBalance == tokenBalance) &&
            (identical(other.fiatBalance, fiatBalance) ||
                other.fiatBalance == fiatBalance));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, symbol, account, tokenBalance, fiatBalance);

  @override
  String toString() {
    return 'TonWalletDetailsState.data(symbol: $symbol, account: $account, tokenBalance: $tokenBalance, fiatBalance: $fiatBalance)';
  }
}

/// @nodoc
abstract mixin class $TonWalletDetailsStateDataCopyWith<$Res>
    implements $TonWalletDetailsStateCopyWith<$Res> {
  factory $TonWalletDetailsStateDataCopyWith(TonWalletDetailsStateData value,
          $Res Function(TonWalletDetailsStateData) _then) =
      _$TonWalletDetailsStateDataCopyWithImpl;
  @useResult
  $Res call(
      {String symbol,
      KeyAccount account,
      Money tokenBalance,
      Money fiatBalance});
}

/// @nodoc
class _$TonWalletDetailsStateDataCopyWithImpl<$Res>
    implements $TonWalletDetailsStateDataCopyWith<$Res> {
  _$TonWalletDetailsStateDataCopyWithImpl(this._self, this._then);

  final TonWalletDetailsStateData _self;
  final $Res Function(TonWalletDetailsStateData) _then;

  /// Create a copy of TonWalletDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? symbol = null,
    Object? account = null,
    Object? tokenBalance = null,
    Object? fiatBalance = null,
  }) {
    return _then(TonWalletDetailsStateData(
      symbol: null == symbol
          ? _self.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      tokenBalance: null == tokenBalance
          ? _self.tokenBalance
          : tokenBalance // ignore: cast_nullable_to_non_nullable
              as Money,
      fiatBalance: null == fiatBalance
          ? _self.fiatBalance
          : fiatBalance // ignore: cast_nullable_to_non_nullable
              as Money,
    ));
  }
}

// dart format on
