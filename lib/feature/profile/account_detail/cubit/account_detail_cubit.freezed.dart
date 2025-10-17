// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountDetailState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AccountDetailState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountDetailState()';
  }
}

/// @nodoc
class $AccountDetailStateCopyWith<$Res> {
  $AccountDetailStateCopyWith(
      AccountDetailState _, $Res Function(AccountDetailState) __);
}

/// Adds pattern-matching-related methods to [AccountDetailState].
extension AccountDetailStatePatterns on AccountDetailState {
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
    TResult Function(AccountDetailStateInitial value)? initial,
    TResult Function(AccountDetailStateEmpty value)? empty,
    TResult Function(AccountDetailStateData value)? data,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AccountDetailStateInitial() when initial != null:
        return initial(_that);
      case AccountDetailStateEmpty() when empty != null:
        return empty(_that);
      case AccountDetailStateData() when data != null:
        return data(_that);
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
    required TResult Function(AccountDetailStateInitial value) initial,
    required TResult Function(AccountDetailStateEmpty value) empty,
    required TResult Function(AccountDetailStateData value) data,
  }) {
    final _that = this;
    switch (_that) {
      case AccountDetailStateInitial():
        return initial(_that);
      case AccountDetailStateEmpty():
        return empty(_that);
      case AccountDetailStateData():
        return data(_that);
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
    TResult? Function(AccountDetailStateInitial value)? initial,
    TResult? Function(AccountDetailStateEmpty value)? empty,
    TResult? Function(AccountDetailStateData value)? data,
  }) {
    final _that = this;
    switch (_that) {
      case AccountDetailStateInitial() when initial != null:
        return initial(_that);
      case AccountDetailStateEmpty() when empty != null:
        return empty(_that);
      case AccountDetailStateData() when data != null:
        return data(_that);
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
    TResult Function()? initial,
    TResult Function()? empty,
    TResult Function(
            KeyAccount account, Money balance, List<SeedKey> custodians)?
        data,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AccountDetailStateInitial() when initial != null:
        return initial();
      case AccountDetailStateEmpty() when empty != null:
        return empty();
      case AccountDetailStateData() when data != null:
        return data(_that.account, _that.balance, _that.custodians);
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
    required TResult Function() initial,
    required TResult Function() empty,
    required TResult Function(
            KeyAccount account, Money balance, List<SeedKey> custodians)
        data,
  }) {
    final _that = this;
    switch (_that) {
      case AccountDetailStateInitial():
        return initial();
      case AccountDetailStateEmpty():
        return empty();
      case AccountDetailStateData():
        return data(_that.account, _that.balance, _that.custodians);
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
    TResult? Function()? initial,
    TResult? Function()? empty,
    TResult? Function(
            KeyAccount account, Money balance, List<SeedKey> custodians)?
        data,
  }) {
    final _that = this;
    switch (_that) {
      case AccountDetailStateInitial() when initial != null:
        return initial();
      case AccountDetailStateEmpty() when empty != null:
        return empty();
      case AccountDetailStateData() when data != null:
        return data(_that.account, _that.balance, _that.custodians);
      case _:
        return null;
    }
  }
}

/// @nodoc

class AccountDetailStateInitial implements AccountDetailState {
  const AccountDetailStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountDetailStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountDetailState.initial()';
  }
}

/// @nodoc

class AccountDetailStateEmpty implements AccountDetailState {
  const AccountDetailStateEmpty();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AccountDetailStateEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountDetailState.empty()';
  }
}

/// @nodoc

class AccountDetailStateData implements AccountDetailState {
  const AccountDetailStateData(
      this.account, this.balance, final List<SeedKey> custodians)
      : _custodians = custodians;

  final KeyAccount account;
  final Money balance;
  final List<SeedKey> _custodians;
  List<SeedKey> get custodians {
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_custodians);
  }

  /// Create a copy of AccountDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountDetailStateDataCopyWith<AccountDetailStateData> get copyWith =>
      _$AccountDetailStateDataCopyWithImpl<AccountDetailStateData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountDetailStateData &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account, balance,
      const DeepCollectionEquality().hash(_custodians));

  @override
  String toString() {
    return 'AccountDetailState.data(account: $account, balance: $balance, custodians: $custodians)';
  }
}

/// @nodoc
abstract mixin class $AccountDetailStateDataCopyWith<$Res>
    implements $AccountDetailStateCopyWith<$Res> {
  factory $AccountDetailStateDataCopyWith(AccountDetailStateData value,
          $Res Function(AccountDetailStateData) _then) =
      _$AccountDetailStateDataCopyWithImpl;
  @useResult
  $Res call({KeyAccount account, Money balance, List<SeedKey> custodians});
}

/// @nodoc
class _$AccountDetailStateDataCopyWithImpl<$Res>
    implements $AccountDetailStateDataCopyWith<$Res> {
  _$AccountDetailStateDataCopyWithImpl(this._self, this._then);

  final AccountDetailStateData _self;
  final $Res Function(AccountDetailStateData) _then;

  /// Create a copy of AccountDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? account = null,
    Object? balance = null,
    Object? custodians = null,
  }) {
    return _then(AccountDetailStateData(
      null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      null == balance
          ? _self.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as Money,
      null == custodians
          ? _self._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<SeedKey>,
    ));
  }
}

// dart format on
