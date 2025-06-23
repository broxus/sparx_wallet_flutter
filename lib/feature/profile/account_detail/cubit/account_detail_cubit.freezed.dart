// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
