// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
