// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_wallet_asset_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenWalletAssetState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TokenWalletAssetState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenWalletAssetState()';
  }
}

/// @nodoc
class $TokenWalletAssetStateCopyWith<$Res> {
  $TokenWalletAssetStateCopyWith(
      TokenWalletAssetState _, $Res Function(TokenWalletAssetState) __);
}

/// @nodoc

class TokenWalletAssetStateData implements TokenWalletAssetState {
  const TokenWalletAssetStateData({this.fiatBalance, this.tokenBalance});

  final Money? fiatBalance;
  final Money? tokenBalance;

  /// Create a copy of TokenWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenWalletAssetStateDataCopyWith<TokenWalletAssetStateData> get copyWith =>
      _$TokenWalletAssetStateDataCopyWithImpl<TokenWalletAssetStateData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletAssetStateData &&
            (identical(other.fiatBalance, fiatBalance) ||
                other.fiatBalance == fiatBalance) &&
            (identical(other.tokenBalance, tokenBalance) ||
                other.tokenBalance == tokenBalance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fiatBalance, tokenBalance);

  @override
  String toString() {
    return 'TokenWalletAssetState.data(fiatBalance: $fiatBalance, tokenBalance: $tokenBalance)';
  }
}

/// @nodoc
abstract mixin class $TokenWalletAssetStateDataCopyWith<$Res>
    implements $TokenWalletAssetStateCopyWith<$Res> {
  factory $TokenWalletAssetStateDataCopyWith(TokenWalletAssetStateData value,
          $Res Function(TokenWalletAssetStateData) _then) =
      _$TokenWalletAssetStateDataCopyWithImpl;
  @useResult
  $Res call({Money? fiatBalance, Money? tokenBalance});
}

/// @nodoc
class _$TokenWalletAssetStateDataCopyWithImpl<$Res>
    implements $TokenWalletAssetStateDataCopyWith<$Res> {
  _$TokenWalletAssetStateDataCopyWithImpl(this._self, this._then);

  final TokenWalletAssetStateData _self;
  final $Res Function(TokenWalletAssetStateData) _then;

  /// Create a copy of TokenWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fiatBalance = freezed,
    Object? tokenBalance = freezed,
  }) {
    return _then(TokenWalletAssetStateData(
      fiatBalance: freezed == fiatBalance
          ? _self.fiatBalance
          : fiatBalance // ignore: cast_nullable_to_non_nullable
              as Money?,
      tokenBalance: freezed == tokenBalance
          ? _self.tokenBalance
          : tokenBalance // ignore: cast_nullable_to_non_nullable
              as Money?,
    ));
  }
}

/// @nodoc

class TokenWalletAssetStateSubscribeError implements TokenWalletAssetState {
  const TokenWalletAssetStateSubscribeError(
      {required this.error, required this.isLoading});

  final Object error;
  final bool isLoading;

  /// Create a copy of TokenWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenWalletAssetStateSubscribeErrorCopyWith<
          TokenWalletAssetStateSubscribeError>
      get copyWith => _$TokenWalletAssetStateSubscribeErrorCopyWithImpl<
          TokenWalletAssetStateSubscribeError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletAssetStateSubscribeError &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(error), isLoading);

  @override
  String toString() {
    return 'TokenWalletAssetState.subscribeError(error: $error, isLoading: $isLoading)';
  }
}

/// @nodoc
abstract mixin class $TokenWalletAssetStateSubscribeErrorCopyWith<$Res>
    implements $TokenWalletAssetStateCopyWith<$Res> {
  factory $TokenWalletAssetStateSubscribeErrorCopyWith(
          TokenWalletAssetStateSubscribeError value,
          $Res Function(TokenWalletAssetStateSubscribeError) _then) =
      _$TokenWalletAssetStateSubscribeErrorCopyWithImpl;
  @useResult
  $Res call({Object error, bool isLoading});
}

/// @nodoc
class _$TokenWalletAssetStateSubscribeErrorCopyWithImpl<$Res>
    implements $TokenWalletAssetStateSubscribeErrorCopyWith<$Res> {
  _$TokenWalletAssetStateSubscribeErrorCopyWithImpl(this._self, this._then);

  final TokenWalletAssetStateSubscribeError _self;
  final $Res Function(TokenWalletAssetStateSubscribeError) _then;

  /// Create a copy of TokenWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
    Object? isLoading = null,
  }) {
    return _then(TokenWalletAssetStateSubscribeError(
      error: null == error ? _self.error : error,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
