// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

/// Adds pattern-matching-related methods to [AccountTransactionsTabState].
extension AccountTransactionsTabStatePatterns on AccountTransactionsTabState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountTransactionsTabStateEmpty value)? empty,
    TResult Function(AccountTransactionsTabStateLoading value)? loading,
    TResult Function(AccountTransactionsTabStateTransactions value)?
        transactions,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AccountTransactionsTabStateEmpty() when empty != null:
        return empty(_that);
      case AccountTransactionsTabStateLoading() when loading != null:
        return loading(_that);
      case AccountTransactionsTabStateTransactions() when transactions != null:
        return transactions(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountTransactionsTabStateEmpty value) empty,
    required TResult Function(AccountTransactionsTabStateLoading value) loading,
    required TResult Function(AccountTransactionsTabStateTransactions value)
        transactions,
  }) {
    final _that = this;
    switch (_that) {
      case AccountTransactionsTabStateEmpty():
        return empty(_that);
      case AccountTransactionsTabStateLoading():
        return loading(_that);
      case AccountTransactionsTabStateTransactions():
        return transactions(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountTransactionsTabStateEmpty value)? empty,
    TResult? Function(AccountTransactionsTabStateLoading value)? loading,
    TResult? Function(AccountTransactionsTabStateTransactions value)?
        transactions,
  }) {
    final _that = this;
    switch (_that) {
      case AccountTransactionsTabStateEmpty() when empty != null:
        return empty(_that);
      case AccountTransactionsTabStateLoading() when loading != null:
        return loading(_that);
      case AccountTransactionsTabStateTransactions() when transactions != null:
        return transactions(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function()? loading,
    TResult Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)?
        transactions,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AccountTransactionsTabStateEmpty() when empty != null:
        return empty();
      case AccountTransactionsTabStateLoading() when loading != null:
        return loading();
      case AccountTransactionsTabStateTransactions() when transactions != null:
        return transactions(_that.transactions, _that.isLoading,
            _that.canLoadMore, _that.price);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function() loading,
    required TResult Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)
        transactions,
  }) {
    final _that = this;
    switch (_that) {
      case AccountTransactionsTabStateEmpty():
        return empty();
      case AccountTransactionsTabStateLoading():
        return loading();
      case AccountTransactionsTabStateTransactions():
        return transactions(_that.transactions, _that.isLoading,
            _that.canLoadMore, _that.price);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function()? loading,
    TResult? Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)?
        transactions,
  }) {
    final _that = this;
    switch (_that) {
      case AccountTransactionsTabStateEmpty() when empty != null:
        return empty();
      case AccountTransactionsTabStateLoading() when loading != null:
        return loading();
      case AccountTransactionsTabStateTransactions() when transactions != null:
        return transactions(_that.transactions, _that.isLoading,
            _that.canLoadMore, _that.price);
      case _:
        return null;
    }
  }
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
