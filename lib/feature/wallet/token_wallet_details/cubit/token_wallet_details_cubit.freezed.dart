// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_wallet_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenWalletDetailsState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TokenWalletDetailsState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenWalletDetailsState()';
  }
}

/// @nodoc
class $TokenWalletDetailsStateCopyWith<$Res> {
  $TokenWalletDetailsStateCopyWith(
      TokenWalletDetailsState _, $Res Function(TokenWalletDetailsState) __);
}

/// @nodoc

class TokenWalletDetailsStateInitial implements TokenWalletDetailsState {
  const TokenWalletDetailsStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletDetailsStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenWalletDetailsState.initial()';
  }
}

/// @nodoc

class TokenWalletDetailsStateEmpty implements TokenWalletDetailsState {
  const TokenWalletDetailsStateEmpty();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletDetailsStateEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TokenWalletDetailsState.empty()';
  }
}

/// @nodoc

class TokenWalletDetailsStateSubscribeError implements TokenWalletDetailsState {
  const TokenWalletDetailsStateSubscribeError(
      {required this.contractName,
      required this.error,
      required this.isLoading});

  final String contractName;
  final Object error;
  final bool isLoading;

  /// Create a copy of TokenWalletDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenWalletDetailsStateSubscribeErrorCopyWith<
          TokenWalletDetailsStateSubscribeError>
      get copyWith => _$TokenWalletDetailsStateSubscribeErrorCopyWithImpl<
          TokenWalletDetailsStateSubscribeError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletDetailsStateSubscribeError &&
            (identical(other.contractName, contractName) ||
                other.contractName == contractName) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contractName,
      const DeepCollectionEquality().hash(error), isLoading);

  @override
  String toString() {
    return 'TokenWalletDetailsState.subscribeError(contractName: $contractName, error: $error, isLoading: $isLoading)';
  }
}

/// @nodoc
abstract mixin class $TokenWalletDetailsStateSubscribeErrorCopyWith<$Res>
    implements $TokenWalletDetailsStateCopyWith<$Res> {
  factory $TokenWalletDetailsStateSubscribeErrorCopyWith(
          TokenWalletDetailsStateSubscribeError value,
          $Res Function(TokenWalletDetailsStateSubscribeError) _then) =
      _$TokenWalletDetailsStateSubscribeErrorCopyWithImpl;
  @useResult
  $Res call({String contractName, Object error, bool isLoading});
}

/// @nodoc
class _$TokenWalletDetailsStateSubscribeErrorCopyWithImpl<$Res>
    implements $TokenWalletDetailsStateSubscribeErrorCopyWith<$Res> {
  _$TokenWalletDetailsStateSubscribeErrorCopyWithImpl(this._self, this._then);

  final TokenWalletDetailsStateSubscribeError _self;
  final $Res Function(TokenWalletDetailsStateSubscribeError) _then;

  /// Create a copy of TokenWalletDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? contractName = null,
    Object? error = null,
    Object? isLoading = null,
  }) {
    return _then(TokenWalletDetailsStateSubscribeError(
      contractName: null == contractName
          ? _self.contractName
          : contractName // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error ? _self.error : error,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class TokenWalletDetailsStateData implements TokenWalletDetailsState {
  const TokenWalletDetailsStateData(
      {required this.contractName,
      required this.tokenBalance,
      required this.fiatBalance,
      required this.canSend});

  final String contractName;
  final Money tokenBalance;
  final Money fiatBalance;
  final bool canSend;

  /// Create a copy of TokenWalletDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenWalletDetailsStateDataCopyWith<TokenWalletDetailsStateData>
      get copyWith => _$TokenWalletDetailsStateDataCopyWithImpl<
          TokenWalletDetailsStateData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenWalletDetailsStateData &&
            (identical(other.contractName, contractName) ||
                other.contractName == contractName) &&
            (identical(other.tokenBalance, tokenBalance) ||
                other.tokenBalance == tokenBalance) &&
            (identical(other.fiatBalance, fiatBalance) ||
                other.fiatBalance == fiatBalance) &&
            (identical(other.canSend, canSend) || other.canSend == canSend));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, contractName, tokenBalance, fiatBalance, canSend);

  @override
  String toString() {
    return 'TokenWalletDetailsState.data(contractName: $contractName, tokenBalance: $tokenBalance, fiatBalance: $fiatBalance, canSend: $canSend)';
  }
}

/// @nodoc
abstract mixin class $TokenWalletDetailsStateDataCopyWith<$Res>
    implements $TokenWalletDetailsStateCopyWith<$Res> {
  factory $TokenWalletDetailsStateDataCopyWith(
          TokenWalletDetailsStateData value,
          $Res Function(TokenWalletDetailsStateData) _then) =
      _$TokenWalletDetailsStateDataCopyWithImpl;
  @useResult
  $Res call(
      {String contractName,
      Money tokenBalance,
      Money fiatBalance,
      bool canSend});
}

/// @nodoc
class _$TokenWalletDetailsStateDataCopyWithImpl<$Res>
    implements $TokenWalletDetailsStateDataCopyWith<$Res> {
  _$TokenWalletDetailsStateDataCopyWithImpl(this._self, this._then);

  final TokenWalletDetailsStateData _self;
  final $Res Function(TokenWalletDetailsStateData) _then;

  /// Create a copy of TokenWalletDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? contractName = null,
    Object? tokenBalance = null,
    Object? fiatBalance = null,
    Object? canSend = null,
  }) {
    return _then(TokenWalletDetailsStateData(
      contractName: null == contractName
          ? _self.contractName
          : contractName // ignore: cast_nullable_to_non_nullable
              as String,
      tokenBalance: null == tokenBalance
          ? _self.tokenBalance
          : tokenBalance // ignore: cast_nullable_to_non_nullable
              as Money,
      fiatBalance: null == fiatBalance
          ? _self.fiatBalance
          : fiatBalance // ignore: cast_nullable_to_non_nullable
              as Money,
      canSend: null == canSend
          ? _self.canSend
          : canSend // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
