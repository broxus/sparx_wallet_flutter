// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_transactions_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountTransactionsUiState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountTransactionsUiState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountTransactionsUiState()';
  }
}

/// @nodoc
class $AccountTransactionsUiStateCopyWith<$Res> {
  $AccountTransactionsUiStateCopyWith(AccountTransactionsUiState _,
      $Res Function(AccountTransactionsUiState) __);
}

/// @nodoc

class AccountTransactionsUiLoading implements AccountTransactionsUiState {
  const AccountTransactionsUiLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountTransactionsUiLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountTransactionsUiState.loading()';
  }
}

/// @nodoc

class AccountTransactionsUiEmpty implements AccountTransactionsUiState {
  const AccountTransactionsUiEmpty();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountTransactionsUiEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountTransactionsUiState.empty()';
  }
}

/// @nodoc

class AccountTransactionsUiData implements AccountTransactionsUiState {
  const AccountTransactionsUiData(
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

  /// Create a copy of AccountTransactionsUiState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountTransactionsUiDataCopyWith<AccountTransactionsUiData> get copyWith =>
      _$AccountTransactionsUiDataCopyWithImpl<AccountTransactionsUiData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountTransactionsUiData &&
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
    return 'AccountTransactionsUiState.data(transactions: $transactions, isLoading: $isLoading, canLoadMore: $canLoadMore, price: $price)';
  }
}

/// @nodoc
abstract mixin class $AccountTransactionsUiDataCopyWith<$Res>
    implements $AccountTransactionsUiStateCopyWith<$Res> {
  factory $AccountTransactionsUiDataCopyWith(AccountTransactionsUiData value,
          $Res Function(AccountTransactionsUiData) _then) =
      _$AccountTransactionsUiDataCopyWithImpl;
  @useResult
  $Res call(
      {List<AccountTransactionItem<Object>> transactions,
      bool isLoading,
      bool canLoadMore,
      Fixed price});
}

/// @nodoc
class _$AccountTransactionsUiDataCopyWithImpl<$Res>
    implements $AccountTransactionsUiDataCopyWith<$Res> {
  _$AccountTransactionsUiDataCopyWithImpl(this._self, this._then);

  final AccountTransactionsUiData _self;
  final $Res Function(AccountTransactionsUiData) _then;

  /// Create a copy of AccountTransactionsUiState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? transactions = null,
    Object? isLoading = null,
    Object? canLoadMore = null,
    Object? price = null,
  }) {
    return _then(AccountTransactionsUiData(
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
