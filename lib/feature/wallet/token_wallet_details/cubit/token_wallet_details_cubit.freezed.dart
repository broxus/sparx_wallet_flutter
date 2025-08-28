// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

/// Adds pattern-matching-related methods to [TokenWalletDetailsState].
extension TokenWalletDetailsStatePatterns on TokenWalletDetailsState {
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
    TResult Function(TokenWalletDetailsStateInitial value)? initial,
    TResult Function(TokenWalletDetailsStateEmpty value)? empty,
    TResult Function(TokenWalletDetailsStateSubscribeError value)?
        subscribeError,
    TResult Function(TokenWalletDetailsStateData value)? data,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletDetailsStateInitial() when initial != null:
        return initial(_that);
      case TokenWalletDetailsStateEmpty() when empty != null:
        return empty(_that);
      case TokenWalletDetailsStateSubscribeError() when subscribeError != null:
        return subscribeError(_that);
      case TokenWalletDetailsStateData() when data != null:
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
    required TResult Function(TokenWalletDetailsStateInitial value) initial,
    required TResult Function(TokenWalletDetailsStateEmpty value) empty,
    required TResult Function(TokenWalletDetailsStateSubscribeError value)
        subscribeError,
    required TResult Function(TokenWalletDetailsStateData value) data,
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletDetailsStateInitial():
        return initial(_that);
      case TokenWalletDetailsStateEmpty():
        return empty(_that);
      case TokenWalletDetailsStateSubscribeError():
        return subscribeError(_that);
      case TokenWalletDetailsStateData():
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
    TResult? Function(TokenWalletDetailsStateInitial value)? initial,
    TResult? Function(TokenWalletDetailsStateEmpty value)? empty,
    TResult? Function(TokenWalletDetailsStateSubscribeError value)?
        subscribeError,
    TResult? Function(TokenWalletDetailsStateData value)? data,
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletDetailsStateInitial() when initial != null:
        return initial(_that);
      case TokenWalletDetailsStateEmpty() when empty != null:
        return empty(_that);
      case TokenWalletDetailsStateSubscribeError() when subscribeError != null:
        return subscribeError(_that);
      case TokenWalletDetailsStateData() when data != null:
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
    TResult Function(String contractName, Object error, bool isLoading)?
        subscribeError,
    TResult Function(String contractName, Money tokenBalance, Money fiatBalance,
            bool canSend)?
        data,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletDetailsStateInitial() when initial != null:
        return initial();
      case TokenWalletDetailsStateEmpty() when empty != null:
        return empty();
      case TokenWalletDetailsStateSubscribeError() when subscribeError != null:
        return subscribeError(_that.contractName, _that.error, _that.isLoading);
      case TokenWalletDetailsStateData() when data != null:
        return data(_that.contractName, _that.tokenBalance, _that.fiatBalance,
            _that.canSend);
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
    required TResult Function(String contractName, Object error, bool isLoading)
        subscribeError,
    required TResult Function(String contractName, Money tokenBalance,
            Money fiatBalance, bool canSend)
        data,
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletDetailsStateInitial():
        return initial();
      case TokenWalletDetailsStateEmpty():
        return empty();
      case TokenWalletDetailsStateSubscribeError():
        return subscribeError(_that.contractName, _that.error, _that.isLoading);
      case TokenWalletDetailsStateData():
        return data(_that.contractName, _that.tokenBalance, _that.fiatBalance,
            _that.canSend);
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
    TResult? Function(String contractName, Object error, bool isLoading)?
        subscribeError,
    TResult? Function(String contractName, Money tokenBalance,
            Money fiatBalance, bool canSend)?
        data,
  }) {
    final _that = this;
    switch (_that) {
      case TokenWalletDetailsStateInitial() when initial != null:
        return initial();
      case TokenWalletDetailsStateEmpty() when empty != null:
        return empty();
      case TokenWalletDetailsStateSubscribeError() when subscribeError != null:
        return subscribeError(_that.contractName, _that.error, _that.isLoading);
      case TokenWalletDetailsStateData() when data != null:
        return data(_that.contractName, _that.tokenBalance, _that.fiatBalance,
            _that.canSend);
      case _:
        return null;
    }
  }
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
