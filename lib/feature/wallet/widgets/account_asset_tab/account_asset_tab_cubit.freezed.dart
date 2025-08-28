// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_asset_tab_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountAssetTabState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AccountAssetTabState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountAssetTabState()';
  }
}

/// @nodoc
class $AccountAssetTabStateCopyWith<$Res> {
  $AccountAssetTabStateCopyWith(
      AccountAssetTabState _, $Res Function(AccountAssetTabState) __);
}

/// Adds pattern-matching-related methods to [AccountAssetTabState].
extension AccountAssetTabStatePatterns on AccountAssetTabState {
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
    TResult Function(AccountAssetTabStateEmpty value)? empty,
    TResult Function(AccountAssetTabStateAccounts value)? accounts,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AccountAssetTabStateEmpty() when empty != null:
        return empty(_that);
      case AccountAssetTabStateAccounts() when accounts != null:
        return accounts(_that);
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
    required TResult Function(AccountAssetTabStateEmpty value) empty,
    required TResult Function(AccountAssetTabStateAccounts value) accounts,
  }) {
    final _that = this;
    switch (_that) {
      case AccountAssetTabStateEmpty():
        return empty(_that);
      case AccountAssetTabStateAccounts():
        return accounts(_that);
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
    TResult? Function(AccountAssetTabStateEmpty value)? empty,
    TResult? Function(AccountAssetTabStateAccounts value)? accounts,
  }) {
    final _that = this;
    switch (_that) {
      case AccountAssetTabStateEmpty() when empty != null:
        return empty(_that);
      case AccountAssetTabStateAccounts() when accounts != null:
        return accounts(_that);
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
    TResult Function(TonWalletAsset tonWallet, List<TokenContractAsset>? tokens,
            int? numberNewTokens)?
        accounts,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AccountAssetTabStateEmpty() when empty != null:
        return empty();
      case AccountAssetTabStateAccounts() when accounts != null:
        return accounts(_that.tonWallet, _that.tokens, _that.numberNewTokens);
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
    required TResult Function(TonWalletAsset tonWallet,
            List<TokenContractAsset>? tokens, int? numberNewTokens)
        accounts,
  }) {
    final _that = this;
    switch (_that) {
      case AccountAssetTabStateEmpty():
        return empty();
      case AccountAssetTabStateAccounts():
        return accounts(_that.tonWallet, _that.tokens, _that.numberNewTokens);
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
    TResult? Function(TonWalletAsset tonWallet,
            List<TokenContractAsset>? tokens, int? numberNewTokens)?
        accounts,
  }) {
    final _that = this;
    switch (_that) {
      case AccountAssetTabStateEmpty() when empty != null:
        return empty();
      case AccountAssetTabStateAccounts() when accounts != null:
        return accounts(_that.tonWallet, _that.tokens, _that.numberNewTokens);
      case _:
        return null;
    }
  }
}

/// @nodoc

class AccountAssetTabStateEmpty implements AccountAssetTabState {
  const AccountAssetTabStateEmpty();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountAssetTabStateEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AccountAssetTabState.empty()';
  }
}

/// @nodoc

class AccountAssetTabStateAccounts implements AccountAssetTabState {
  const AccountAssetTabStateAccounts(this.tonWallet,
      final List<TokenContractAsset>? tokens, this.numberNewTokens)
      : _tokens = tokens;

  final TonWalletAsset tonWallet;
  final List<TokenContractAsset>? _tokens;
  List<TokenContractAsset>? get tokens {
    final value = _tokens;
    if (value == null) return null;
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final int? numberNewTokens;

  /// Create a copy of AccountAssetTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountAssetTabStateAccountsCopyWith<AccountAssetTabStateAccounts>
      get copyWith => _$AccountAssetTabStateAccountsCopyWithImpl<
          AccountAssetTabStateAccounts>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountAssetTabStateAccounts &&
            (identical(other.tonWallet, tonWallet) ||
                other.tonWallet == tonWallet) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens) &&
            (identical(other.numberNewTokens, numberNewTokens) ||
                other.numberNewTokens == numberNewTokens));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tonWallet,
      const DeepCollectionEquality().hash(_tokens), numberNewTokens);

  @override
  String toString() {
    return 'AccountAssetTabState.accounts(tonWallet: $tonWallet, tokens: $tokens, numberNewTokens: $numberNewTokens)';
  }
}

/// @nodoc
abstract mixin class $AccountAssetTabStateAccountsCopyWith<$Res>
    implements $AccountAssetTabStateCopyWith<$Res> {
  factory $AccountAssetTabStateAccountsCopyWith(
          AccountAssetTabStateAccounts value,
          $Res Function(AccountAssetTabStateAccounts) _then) =
      _$AccountAssetTabStateAccountsCopyWithImpl;
  @useResult
  $Res call(
      {TonWalletAsset tonWallet,
      List<TokenContractAsset>? tokens,
      int? numberNewTokens});

  $TonWalletAssetCopyWith<$Res> get tonWallet;
}

/// @nodoc
class _$AccountAssetTabStateAccountsCopyWithImpl<$Res>
    implements $AccountAssetTabStateAccountsCopyWith<$Res> {
  _$AccountAssetTabStateAccountsCopyWithImpl(this._self, this._then);

  final AccountAssetTabStateAccounts _self;
  final $Res Function(AccountAssetTabStateAccounts) _then;

  /// Create a copy of AccountAssetTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tonWallet = null,
    Object? tokens = freezed,
    Object? numberNewTokens = freezed,
  }) {
    return _then(AccountAssetTabStateAccounts(
      null == tonWallet
          ? _self.tonWallet
          : tonWallet // ignore: cast_nullable_to_non_nullable
              as TonWalletAsset,
      freezed == tokens
          ? _self._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<TokenContractAsset>?,
      freezed == numberNewTokens
          ? _self.numberNewTokens
          : numberNewTokens // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of AccountAssetTabState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonWalletAssetCopyWith<$Res> get tonWallet {
    return $TonWalletAssetCopyWith<$Res>(_self.tonWallet, (value) {
      return _then(_self.copyWith(tonWallet: value));
    });
  }
}

// dart format on
