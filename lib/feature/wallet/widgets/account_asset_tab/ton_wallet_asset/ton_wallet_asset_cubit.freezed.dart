// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_wallet_asset_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TonWalletAssetState {
  String get tokenName;
  String get iconPath;

  /// Create a copy of TonWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonWalletAssetStateCopyWith<TonWalletAssetState> get copyWith =>
      _$TonWalletAssetStateCopyWithImpl<TonWalletAssetState>(
          this as TonWalletAssetState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonWalletAssetState &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tokenName, iconPath);

  @override
  String toString() {
    return 'TonWalletAssetState(tokenName: $tokenName, iconPath: $iconPath)';
  }
}

/// @nodoc
abstract mixin class $TonWalletAssetStateCopyWith<$Res> {
  factory $TonWalletAssetStateCopyWith(
          TonWalletAssetState value, $Res Function(TonWalletAssetState) _then) =
      _$TonWalletAssetStateCopyWithImpl;
  @useResult
  $Res call({String tokenName, String iconPath});
}

/// @nodoc
class _$TonWalletAssetStateCopyWithImpl<$Res>
    implements $TonWalletAssetStateCopyWith<$Res> {
  _$TonWalletAssetStateCopyWithImpl(this._self, this._then);

  final TonWalletAssetState _self;
  final $Res Function(TonWalletAssetState) _then;

  /// Create a copy of TonWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenName = null,
    Object? iconPath = null,
  }) {
    return _then(_self.copyWith(
      tokenName: null == tokenName
          ? _self.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: null == iconPath
          ? _self.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TonWalletAssetState].
extension TonWalletAssetStatePatterns on TonWalletAssetState {
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
    TResult Function(TonWalletAssetStateData value)? data,
    TResult Function(TonWalletAssetStateSubscribeError value)? subscribeError,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TonWalletAssetStateData() when data != null:
        return data(_that);
      case TonWalletAssetStateSubscribeError() when subscribeError != null:
        return subscribeError(_that);
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
    required TResult Function(TonWalletAssetStateData value) data,
    required TResult Function(TonWalletAssetStateSubscribeError value)
        subscribeError,
  }) {
    final _that = this;
    switch (_that) {
      case TonWalletAssetStateData():
        return data(_that);
      case TonWalletAssetStateSubscribeError():
        return subscribeError(_that);
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
    TResult? Function(TonWalletAssetStateData value)? data,
    TResult? Function(TonWalletAssetStateSubscribeError value)? subscribeError,
  }) {
    final _that = this;
    switch (_that) {
      case TonWalletAssetStateData() when data != null:
        return data(_that);
      case TonWalletAssetStateSubscribeError() when subscribeError != null:
        return subscribeError(_that);
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
    TResult Function(String tokenName, String iconPath, Money? fiatBalance,
            Money? tokenBalance)?
        data,
    TResult Function(
            String tokenName, String iconPath, Object error, bool isLoading)?
        subscribeError,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TonWalletAssetStateData() when data != null:
        return data(_that.tokenName, _that.iconPath, _that.fiatBalance,
            _that.tokenBalance);
      case TonWalletAssetStateSubscribeError() when subscribeError != null:
        return subscribeError(
            _that.tokenName, _that.iconPath, _that.error, _that.isLoading);
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
    required TResult Function(String tokenName, String iconPath,
            Money? fiatBalance, Money? tokenBalance)
        data,
    required TResult Function(
            String tokenName, String iconPath, Object error, bool isLoading)
        subscribeError,
  }) {
    final _that = this;
    switch (_that) {
      case TonWalletAssetStateData():
        return data(_that.tokenName, _that.iconPath, _that.fiatBalance,
            _that.tokenBalance);
      case TonWalletAssetStateSubscribeError():
        return subscribeError(
            _that.tokenName, _that.iconPath, _that.error, _that.isLoading);
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
    TResult? Function(String tokenName, String iconPath, Money? fiatBalance,
            Money? tokenBalance)?
        data,
    TResult? Function(
            String tokenName, String iconPath, Object error, bool isLoading)?
        subscribeError,
  }) {
    final _that = this;
    switch (_that) {
      case TonWalletAssetStateData() when data != null:
        return data(_that.tokenName, _that.iconPath, _that.fiatBalance,
            _that.tokenBalance);
      case TonWalletAssetStateSubscribeError() when subscribeError != null:
        return subscribeError(
            _that.tokenName, _that.iconPath, _that.error, _that.isLoading);
      case _:
        return null;
    }
  }
}

/// @nodoc

class TonWalletAssetStateData implements TonWalletAssetState {
  const TonWalletAssetStateData(
      {required this.tokenName,
      required this.iconPath,
      this.fiatBalance,
      this.tokenBalance});

  @override
  final String tokenName;
  @override
  final String iconPath;
  final Money? fiatBalance;
  final Money? tokenBalance;

  /// Create a copy of TonWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonWalletAssetStateDataCopyWith<TonWalletAssetStateData> get copyWith =>
      _$TonWalletAssetStateDataCopyWithImpl<TonWalletAssetStateData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonWalletAssetStateData &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.fiatBalance, fiatBalance) ||
                other.fiatBalance == fiatBalance) &&
            (identical(other.tokenBalance, tokenBalance) ||
                other.tokenBalance == tokenBalance));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tokenName, iconPath, fiatBalance, tokenBalance);

  @override
  String toString() {
    return 'TonWalletAssetState.data(tokenName: $tokenName, iconPath: $iconPath, fiatBalance: $fiatBalance, tokenBalance: $tokenBalance)';
  }
}

/// @nodoc
abstract mixin class $TonWalletAssetStateDataCopyWith<$Res>
    implements $TonWalletAssetStateCopyWith<$Res> {
  factory $TonWalletAssetStateDataCopyWith(TonWalletAssetStateData value,
          $Res Function(TonWalletAssetStateData) _then) =
      _$TonWalletAssetStateDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String tokenName,
      String iconPath,
      Money? fiatBalance,
      Money? tokenBalance});
}

/// @nodoc
class _$TonWalletAssetStateDataCopyWithImpl<$Res>
    implements $TonWalletAssetStateDataCopyWith<$Res> {
  _$TonWalletAssetStateDataCopyWithImpl(this._self, this._then);

  final TonWalletAssetStateData _self;
  final $Res Function(TonWalletAssetStateData) _then;

  /// Create a copy of TonWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tokenName = null,
    Object? iconPath = null,
    Object? fiatBalance = freezed,
    Object? tokenBalance = freezed,
  }) {
    return _then(TonWalletAssetStateData(
      tokenName: null == tokenName
          ? _self.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: null == iconPath
          ? _self.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
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

class TonWalletAssetStateSubscribeError implements TonWalletAssetState {
  const TonWalletAssetStateSubscribeError(
      {required this.tokenName,
      required this.iconPath,
      required this.error,
      required this.isLoading});

  @override
  final String tokenName;
  @override
  final String iconPath;
  final Object error;
  final bool isLoading;

  /// Create a copy of TonWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonWalletAssetStateSubscribeErrorCopyWith<TonWalletAssetStateSubscribeError>
      get copyWith => _$TonWalletAssetStateSubscribeErrorCopyWithImpl<
          TonWalletAssetStateSubscribeError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonWalletAssetStateSubscribeError &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tokenName, iconPath,
      const DeepCollectionEquality().hash(error), isLoading);

  @override
  String toString() {
    return 'TonWalletAssetState.subscribeError(tokenName: $tokenName, iconPath: $iconPath, error: $error, isLoading: $isLoading)';
  }
}

/// @nodoc
abstract mixin class $TonWalletAssetStateSubscribeErrorCopyWith<$Res>
    implements $TonWalletAssetStateCopyWith<$Res> {
  factory $TonWalletAssetStateSubscribeErrorCopyWith(
          TonWalletAssetStateSubscribeError value,
          $Res Function(TonWalletAssetStateSubscribeError) _then) =
      _$TonWalletAssetStateSubscribeErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String tokenName, String iconPath, Object error, bool isLoading});
}

/// @nodoc
class _$TonWalletAssetStateSubscribeErrorCopyWithImpl<$Res>
    implements $TonWalletAssetStateSubscribeErrorCopyWith<$Res> {
  _$TonWalletAssetStateSubscribeErrorCopyWithImpl(this._self, this._then);

  final TonWalletAssetStateSubscribeError _self;
  final $Res Function(TonWalletAssetStateSubscribeError) _then;

  /// Create a copy of TonWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tokenName = null,
    Object? iconPath = null,
    Object? error = null,
    Object? isLoading = null,
  }) {
    return _then(TonWalletAssetStateSubscribeError(
      tokenName: null == tokenName
          ? _self.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: null == iconPath
          ? _self.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error ? _self.error : error,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
