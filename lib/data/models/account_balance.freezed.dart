// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountBalanceModel {
  @NekotonAddressConverter()
  Address get rootTokenContract;
  @moneyFromStringJsonConverter
  Money get fiatBalance;
  @moneyFromStringJsonConverter
  Money get tokenBalance;
  @JsonKey(defaultValue: false)
  bool get isNative;

  /// Create a copy of AccountBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountBalanceModelCopyWith<AccountBalanceModel> get copyWith =>
      _$AccountBalanceModelCopyWithImpl<AccountBalanceModel>(
          this as AccountBalanceModel, _$identity);

  /// Serializes this AccountBalanceModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountBalanceModel &&
            (identical(other.rootTokenContract, rootTokenContract) ||
                other.rootTokenContract == rootTokenContract) &&
            (identical(other.fiatBalance, fiatBalance) ||
                other.fiatBalance == fiatBalance) &&
            (identical(other.tokenBalance, tokenBalance) ||
                other.tokenBalance == tokenBalance) &&
            (identical(other.isNative, isNative) ||
                other.isNative == isNative));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, rootTokenContract, fiatBalance, tokenBalance, isNative);

  @override
  String toString() {
    return 'AccountBalanceModel(rootTokenContract: $rootTokenContract, fiatBalance: $fiatBalance, tokenBalance: $tokenBalance, isNative: $isNative)';
  }
}

/// @nodoc
abstract mixin class $AccountBalanceModelCopyWith<$Res> {
  factory $AccountBalanceModelCopyWith(
          AccountBalanceModel value, $Res Function(AccountBalanceModel) _then) =
      _$AccountBalanceModelCopyWithImpl;
  @useResult
  $Res call(
      {@NekotonAddressConverter() Address rootTokenContract,
      @moneyFromStringJsonConverter Money fiatBalance,
      @moneyFromStringJsonConverter Money tokenBalance,
      @JsonKey(defaultValue: false) bool isNative});

  $AddressCopyWith<$Res> get rootTokenContract;
}

/// @nodoc
class _$AccountBalanceModelCopyWithImpl<$Res>
    implements $AccountBalanceModelCopyWith<$Res> {
  _$AccountBalanceModelCopyWithImpl(this._self, this._then);

  final AccountBalanceModel _self;
  final $Res Function(AccountBalanceModel) _then;

  /// Create a copy of AccountBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rootTokenContract = null,
    Object? fiatBalance = null,
    Object? tokenBalance = null,
    Object? isNative = null,
  }) {
    return _then(_self.copyWith(
      rootTokenContract: null == rootTokenContract
          ? _self.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
              as Address,
      fiatBalance: null == fiatBalance
          ? _self.fiatBalance
          : fiatBalance // ignore: cast_nullable_to_non_nullable
              as Money,
      tokenBalance: null == tokenBalance
          ? _self.tokenBalance
          : tokenBalance // ignore: cast_nullable_to_non_nullable
              as Money,
      isNative: null == isNative
          ? _self.isNative
          : isNative // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of AccountBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get rootTokenContract {
    return $AddressCopyWith<$Res>(_self.rootTokenContract, (value) {
      return _then(_self.copyWith(rootTokenContract: value));
    });
  }
}

/// Adds pattern-matching-related methods to [AccountBalanceModel].
extension AccountBalanceModelPatterns on AccountBalanceModel {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AccountBalanceModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccountBalanceModel() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_AccountBalanceModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccountBalanceModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AccountBalanceModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccountBalanceModel() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @NekotonAddressConverter() Address rootTokenContract,
            @moneyFromStringJsonConverter Money fiatBalance,
            @moneyFromStringJsonConverter Money tokenBalance,
            @JsonKey(defaultValue: false) bool isNative)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccountBalanceModel() when $default != null:
        return $default(_that.rootTokenContract, _that.fiatBalance,
            _that.tokenBalance, _that.isNative);
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
  TResult when<TResult extends Object?>(
    TResult Function(
            @NekotonAddressConverter() Address rootTokenContract,
            @moneyFromStringJsonConverter Money fiatBalance,
            @moneyFromStringJsonConverter Money tokenBalance,
            @JsonKey(defaultValue: false) bool isNative)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccountBalanceModel():
        return $default(_that.rootTokenContract, _that.fiatBalance,
            _that.tokenBalance, _that.isNative);
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @NekotonAddressConverter() Address rootTokenContract,
            @moneyFromStringJsonConverter Money fiatBalance,
            @moneyFromStringJsonConverter Money tokenBalance,
            @JsonKey(defaultValue: false) bool isNative)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccountBalanceModel() when $default != null:
        return $default(_that.rootTokenContract, _that.fiatBalance,
            _that.tokenBalance, _that.isNative);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AccountBalanceModel implements AccountBalanceModel {
  const _AccountBalanceModel(
      {@NekotonAddressConverter() required this.rootTokenContract,
      @moneyFromStringJsonConverter required this.fiatBalance,
      @moneyFromStringJsonConverter required this.tokenBalance,
      @JsonKey(defaultValue: false) required this.isNative});
  factory _AccountBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$AccountBalanceModelFromJson(json);

  @override
  @NekotonAddressConverter()
  final Address rootTokenContract;
  @override
  @moneyFromStringJsonConverter
  final Money fiatBalance;
  @override
  @moneyFromStringJsonConverter
  final Money tokenBalance;
  @override
  @JsonKey(defaultValue: false)
  final bool isNative;

  /// Create a copy of AccountBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AccountBalanceModelCopyWith<_AccountBalanceModel> get copyWith =>
      __$AccountBalanceModelCopyWithImpl<_AccountBalanceModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AccountBalanceModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AccountBalanceModel &&
            (identical(other.rootTokenContract, rootTokenContract) ||
                other.rootTokenContract == rootTokenContract) &&
            (identical(other.fiatBalance, fiatBalance) ||
                other.fiatBalance == fiatBalance) &&
            (identical(other.tokenBalance, tokenBalance) ||
                other.tokenBalance == tokenBalance) &&
            (identical(other.isNative, isNative) ||
                other.isNative == isNative));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, rootTokenContract, fiatBalance, tokenBalance, isNative);

  @override
  String toString() {
    return 'AccountBalanceModel(rootTokenContract: $rootTokenContract, fiatBalance: $fiatBalance, tokenBalance: $tokenBalance, isNative: $isNative)';
  }
}

/// @nodoc
abstract mixin class _$AccountBalanceModelCopyWith<$Res>
    implements $AccountBalanceModelCopyWith<$Res> {
  factory _$AccountBalanceModelCopyWith(_AccountBalanceModel value,
          $Res Function(_AccountBalanceModel) _then) =
      __$AccountBalanceModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@NekotonAddressConverter() Address rootTokenContract,
      @moneyFromStringJsonConverter Money fiatBalance,
      @moneyFromStringJsonConverter Money tokenBalance,
      @JsonKey(defaultValue: false) bool isNative});

  @override
  $AddressCopyWith<$Res> get rootTokenContract;
}

/// @nodoc
class __$AccountBalanceModelCopyWithImpl<$Res>
    implements _$AccountBalanceModelCopyWith<$Res> {
  __$AccountBalanceModelCopyWithImpl(this._self, this._then);

  final _AccountBalanceModel _self;
  final $Res Function(_AccountBalanceModel) _then;

  /// Create a copy of AccountBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? rootTokenContract = null,
    Object? fiatBalance = null,
    Object? tokenBalance = null,
    Object? isNative = null,
  }) {
    return _then(_AccountBalanceModel(
      rootTokenContract: null == rootTokenContract
          ? _self.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
              as Address,
      fiatBalance: null == fiatBalance
          ? _self.fiatBalance
          : fiatBalance // ignore: cast_nullable_to_non_nullable
              as Money,
      tokenBalance: null == tokenBalance
          ? _self.tokenBalance
          : tokenBalance // ignore: cast_nullable_to_non_nullable
              as Money,
      isNative: null == isNative
          ? _self.isNative
          : isNative // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of AccountBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get rootTokenContract {
    return $AddressCopyWith<$Res>(_self.rootTokenContract, (value) {
      return _then(_self.copyWith(rootTokenContract: value));
    });
  }
}

// dart format on
