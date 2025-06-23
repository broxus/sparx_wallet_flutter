// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_transactions_tab_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountTransactionsTabState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountTransactionsTabState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountTransactionsTabState()';
  }
}

/// @nodoc
class $AccountTransactionsTabStateCopyWith<$Res> {
  $AccountTransactionsTabStateCopyWith(AccountTransactionsTabState _,
      $Res Function(AccountTransactionsTabState) __);
}

/// @nodoc

class AccountTransactionsTabStateEmpty implements AccountTransactionsTabState {
  const AccountTransactionsTabStateEmpty();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountTransactionsTabStateEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountTransactionsTabState.empty()';
  }
}

/// @nodoc

class AccountTransactionsTabStateLoading
    implements AccountTransactionsTabState {
  const AccountTransactionsTabStateLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountTransactionsTabStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountTransactionsTabState.loading()';
  }
}

/// @nodoc

class AccountTransactionsTabStateTransactions
    implements AccountTransactionsTabState {
  const AccountTransactionsTabStateTransactions(
      {required final List<AccountTransactionItem<Object>> transactions,
      required this.isLoading,
      required this.canLoadMore,
      required this.price})
      : _transactions = transactions;

  final List<AccountTransactionItem<Object>> _transactions;
  List<AccountTransactionItem<Object>> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  final bool isLoading;
  final bool canLoadMore;
  final Fixed price;

  /// Create a copy of AccountTransactionsTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountTransactionsTabStateTransactionsCopyWith<
          AccountTransactionsTabStateTransactions>
      get copyWith => _$AccountTransactionsTabStateTransactionsCopyWithImpl<
          AccountTransactionsTabStateTransactions>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountTransactionsTabStateTransactions &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.canLoadMore, canLoadMore) ||
                other.canLoadMore == canLoadMore) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_transactions),
      isLoading,
      canLoadMore,
      price);

  @override
  String toString() {
    return 'AccountTransactionsTabState.transactions(transactions: $transactions, isLoading: $isLoading, canLoadMore: $canLoadMore, price: $price)';
  }
}

/// @nodoc
abstract mixin class $AccountTransactionsTabStateTransactionsCopyWith<$Res>
    implements $AccountTransactionsTabStateCopyWith<$Res> {
  factory $AccountTransactionsTabStateTransactionsCopyWith(
          AccountTransactionsTabStateTransactions value,
          $Res Function(AccountTransactionsTabStateTransactions) _then) =
      _$AccountTransactionsTabStateTransactionsCopyWithImpl;
  @useResult
  $Res call(
      {List<AccountTransactionItem<Object>> transactions,
      bool isLoading,
      bool canLoadMore,
      Fixed price});
}

/// @nodoc
class _$AccountTransactionsTabStateTransactionsCopyWithImpl<$Res>
    implements $AccountTransactionsTabStateTransactionsCopyWith<$Res> {
  _$AccountTransactionsTabStateTransactionsCopyWithImpl(this._self, this._then);

  final AccountTransactionsTabStateTransactions _self;
  final $Res Function(AccountTransactionsTabStateTransactions) _then;

  /// Create a copy of AccountTransactionsTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? transactions = null,
    Object? isLoading = null,
    Object? canLoadMore = null,
    Object? price = null,
  }) {
    return _then(AccountTransactionsTabStateTransactions(
      transactions: null == transactions
          ? _self._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<AccountTransactionItem<Object>>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      canLoadMore: null == canLoadMore
          ? _self.canLoadMore
          : canLoadMore // ignore: cast_nullable_to_non_nullable
              as bool,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as Fixed,
    ));
  }
}

// dart format on
