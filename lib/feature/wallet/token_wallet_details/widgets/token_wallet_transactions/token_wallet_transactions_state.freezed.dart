// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_wallet_transactions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenWalletTransactionsState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletTransactionsState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenWalletTransactionsState()';
  }
}

/// @nodoc
class $TokenWalletTransactionsStateCopyWith<$Res> {
  $TokenWalletTransactionsStateCopyWith(TokenWalletTransactionsState _,
      $Res Function(TokenWalletTransactionsState) __);
}

/// @nodoc

class TokenWalletTransactionsStateEmpty
    implements TokenWalletTransactionsState {
  const TokenWalletTransactionsStateEmpty();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletTransactionsStateEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenWalletTransactionsState.empty()';
  }
}

/// @nodoc

class TokenWalletTransactionsStateLoading
    implements TokenWalletTransactionsState {
  const TokenWalletTransactionsStateLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletTransactionsStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenWalletTransactionsState.loading()';
  }
}

/// @nodoc

class TokenWalletTransactionsStateTransactions
    implements TokenWalletTransactionsState {
  const TokenWalletTransactionsStateTransactions(
      {required final List<TokenWalletOrdinaryTransaction> transactions,
      required this.tokenCurrency,
      required this.isLoading,
      required this.canLoadMore,
      required this.tokenCustomCurrency})
      : _transactions = transactions;

  final List<TokenWalletOrdinaryTransaction> _transactions;
  List<TokenWalletOrdinaryTransaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  final Currency tokenCurrency;
  final bool isLoading;
  final bool canLoadMore;
  final CustomCurrency? tokenCustomCurrency;

  /// Create a copy of TokenWalletTransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenWalletTransactionsStateTransactionsCopyWith<
          TokenWalletTransactionsStateTransactions>
      get copyWith => _$TokenWalletTransactionsStateTransactionsCopyWithImpl<
          TokenWalletTransactionsStateTransactions>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletTransactionsStateTransactions &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.tokenCurrency, tokenCurrency) ||
                other.tokenCurrency == tokenCurrency) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.canLoadMore, canLoadMore) ||
                other.canLoadMore == canLoadMore) &&
            (identical(other.tokenCustomCurrency, tokenCustomCurrency) ||
                other.tokenCustomCurrency == tokenCustomCurrency));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_transactions),
      tokenCurrency,
      isLoading,
      canLoadMore,
      tokenCustomCurrency);

  @override
  String toString() {
    return 'TokenWalletTransactionsState.transactions(transactions: $transactions, tokenCurrency: $tokenCurrency, isLoading: $isLoading, canLoadMore: $canLoadMore, tokenCustomCurrency: $tokenCustomCurrency)';
  }
}

/// @nodoc
abstract mixin class $TokenWalletTransactionsStateTransactionsCopyWith<$Res>
    implements $TokenWalletTransactionsStateCopyWith<$Res> {
  factory $TokenWalletTransactionsStateTransactionsCopyWith(
          TokenWalletTransactionsStateTransactions value,
          $Res Function(TokenWalletTransactionsStateTransactions) _then) =
      _$TokenWalletTransactionsStateTransactionsCopyWithImpl;
  @useResult
  $Res call(
      {List<TokenWalletOrdinaryTransaction> transactions,
      Currency tokenCurrency,
      bool isLoading,
      bool canLoadMore,
      CustomCurrency? tokenCustomCurrency});

  $CustomCurrencyCopyWith<$Res>? get tokenCustomCurrency;
}

/// @nodoc
class _$TokenWalletTransactionsStateTransactionsCopyWithImpl<$Res>
    implements $TokenWalletTransactionsStateTransactionsCopyWith<$Res> {
  _$TokenWalletTransactionsStateTransactionsCopyWithImpl(
      this._self, this._then);

  final TokenWalletTransactionsStateTransactions _self;
  final $Res Function(TokenWalletTransactionsStateTransactions) _then;

  /// Create a copy of TokenWalletTransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? transactions = null,
    Object? tokenCurrency = null,
    Object? isLoading = null,
    Object? canLoadMore = null,
    Object? tokenCustomCurrency = freezed,
  }) {
    return _then(TokenWalletTransactionsStateTransactions(
      transactions: null == transactions
          ? _self._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TokenWalletOrdinaryTransaction>,
      tokenCurrency: null == tokenCurrency
          ? _self.tokenCurrency
          : tokenCurrency // ignore: cast_nullable_to_non_nullable
              as Currency,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      canLoadMore: null == canLoadMore
          ? _self.canLoadMore
          : canLoadMore // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenCustomCurrency: freezed == tokenCustomCurrency
          ? _self.tokenCustomCurrency
          : tokenCustomCurrency // ignore: cast_nullable_to_non_nullable
              as CustomCurrency?,
    ));
  }

  /// Create a copy of TokenWalletTransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomCurrencyCopyWith<$Res>? get tokenCustomCurrency {
    if (_self.tokenCustomCurrency == null) {
      return null;
    }

    return $CustomCurrencyCopyWith<$Res>(_self.tokenCustomCurrency!, (value) {
      return _then(_self.copyWith(tokenCustomCurrency: value));
    });
  }
}

// dart format on
