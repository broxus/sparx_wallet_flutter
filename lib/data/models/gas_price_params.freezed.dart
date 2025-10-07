// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gas_price_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GasPriceParams {
  /// Flat tag
  String get tag1;

  /// Ext tag
  String get tag2;

  /// The price of gas unit
  BigInt get gasPrice;

  /// The maximum amount of gas available for a compute phase of
  /// an ordinary transaction
  BigInt get gasLimit;

  /// The maximum amount of gas available for a compute phase of
  /// a special transaction
  BigInt get specialGasLimit;

  /// The maximum amount of gas available before `ACCEPT`
  BigInt get gasCredit;

  /// The maximum amount of gas units per block
  BigInt get blockGasLimit;

  /// Amount of debt (in tokens) after which the account will be frozen
  BigInt get freezeDueLimit;

  /// Amount of debt (in tokens) after which the contract will be deleted
  BigInt get deleteDueLimit;

  /// Size of the first portion of gas with different price
  BigInt get flatGasLimit;

  /// The gas price for the first portion determinted by flatGasLimit
  BigInt get flatGasPrice;

  /// Create a copy of GasPriceParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GasPriceParamsCopyWith<GasPriceParams> get copyWith =>
      _$GasPriceParamsCopyWithImpl<GasPriceParams>(
          this as GasPriceParams, _$identity);

  /// Serializes this GasPriceParams to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GasPriceParams &&
            (identical(other.tag1, tag1) || other.tag1 == tag1) &&
            (identical(other.tag2, tag2) || other.tag2 == tag2) &&
            (identical(other.gasPrice, gasPrice) ||
                other.gasPrice == gasPrice) &&
            (identical(other.gasLimit, gasLimit) ||
                other.gasLimit == gasLimit) &&
            (identical(other.specialGasLimit, specialGasLimit) ||
                other.specialGasLimit == specialGasLimit) &&
            (identical(other.gasCredit, gasCredit) ||
                other.gasCredit == gasCredit) &&
            (identical(other.blockGasLimit, blockGasLimit) ||
                other.blockGasLimit == blockGasLimit) &&
            (identical(other.freezeDueLimit, freezeDueLimit) ||
                other.freezeDueLimit == freezeDueLimit) &&
            (identical(other.deleteDueLimit, deleteDueLimit) ||
                other.deleteDueLimit == deleteDueLimit) &&
            (identical(other.flatGasLimit, flatGasLimit) ||
                other.flatGasLimit == flatGasLimit) &&
            (identical(other.flatGasPrice, flatGasPrice) ||
                other.flatGasPrice == flatGasPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      tag1,
      tag2,
      gasPrice,
      gasLimit,
      specialGasLimit,
      gasCredit,
      blockGasLimit,
      freezeDueLimit,
      deleteDueLimit,
      flatGasLimit,
      flatGasPrice);

  @override
  String toString() {
    return 'GasPriceParams(tag1: $tag1, tag2: $tag2, gasPrice: $gasPrice, gasLimit: $gasLimit, specialGasLimit: $specialGasLimit, gasCredit: $gasCredit, blockGasLimit: $blockGasLimit, freezeDueLimit: $freezeDueLimit, deleteDueLimit: $deleteDueLimit, flatGasLimit: $flatGasLimit, flatGasPrice: $flatGasPrice)';
  }
}

/// @nodoc
abstract mixin class $GasPriceParamsCopyWith<$Res> {
  factory $GasPriceParamsCopyWith(
          GasPriceParams value, $Res Function(GasPriceParams) _then) =
      _$GasPriceParamsCopyWithImpl;
  @useResult
  $Res call(
      {String tag1,
      String tag2,
      BigInt gasPrice,
      BigInt gasLimit,
      BigInt specialGasLimit,
      BigInt gasCredit,
      BigInt blockGasLimit,
      BigInt freezeDueLimit,
      BigInt deleteDueLimit,
      BigInt flatGasLimit,
      BigInt flatGasPrice});
}

/// @nodoc
class _$GasPriceParamsCopyWithImpl<$Res>
    implements $GasPriceParamsCopyWith<$Res> {
  _$GasPriceParamsCopyWithImpl(this._self, this._then);

  final GasPriceParams _self;
  final $Res Function(GasPriceParams) _then;

  /// Create a copy of GasPriceParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tag1 = null,
    Object? tag2 = null,
    Object? gasPrice = null,
    Object? gasLimit = null,
    Object? specialGasLimit = null,
    Object? gasCredit = null,
    Object? blockGasLimit = null,
    Object? freezeDueLimit = null,
    Object? deleteDueLimit = null,
    Object? flatGasLimit = null,
    Object? flatGasPrice = null,
  }) {
    return _then(_self.copyWith(
      tag1: null == tag1
          ? _self.tag1
          : tag1 // ignore: cast_nullable_to_non_nullable
              as String,
      tag2: null == tag2
          ? _self.tag2
          : tag2 // ignore: cast_nullable_to_non_nullable
              as String,
      gasPrice: null == gasPrice
          ? _self.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as BigInt,
      gasLimit: null == gasLimit
          ? _self.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      specialGasLimit: null == specialGasLimit
          ? _self.specialGasLimit
          : specialGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      gasCredit: null == gasCredit
          ? _self.gasCredit
          : gasCredit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      blockGasLimit: null == blockGasLimit
          ? _self.blockGasLimit
          : blockGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      freezeDueLimit: null == freezeDueLimit
          ? _self.freezeDueLimit
          : freezeDueLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      deleteDueLimit: null == deleteDueLimit
          ? _self.deleteDueLimit
          : deleteDueLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      flatGasLimit: null == flatGasLimit
          ? _self.flatGasLimit
          : flatGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      flatGasPrice: null == flatGasPrice
          ? _self.flatGasPrice
          : flatGasPrice // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// Adds pattern-matching-related methods to [GasPriceParams].
extension GasPriceParamsPatterns on GasPriceParams {
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
    TResult Function(_GasPriceParams value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GasPriceParams() when $default != null:
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
    TResult Function(_GasPriceParams value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GasPriceParams():
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
    TResult? Function(_GasPriceParams value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GasPriceParams() when $default != null:
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
            String tag1,
            String tag2,
            @amountJsonConverter BigInt gasPrice,
            @amountJsonConverter BigInt gasLimit,
            @amountJsonConverter BigInt specialGasLimit,
            @amountJsonConverter BigInt gasCredit,
            @amountJsonConverter BigInt blockGasLimit,
            @amountJsonConverter BigInt freezeDueLimit,
            @amountJsonConverter BigInt deleteDueLimit,
            @amountJsonConverter BigInt flatGasLimit,
            @amountJsonConverter BigInt flatGasPrice)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GasPriceParams() when $default != null:
        return $default(
            _that.tag1,
            _that.tag2,
            _that.gasPrice,
            _that.gasLimit,
            _that.specialGasLimit,
            _that.gasCredit,
            _that.blockGasLimit,
            _that.freezeDueLimit,
            _that.deleteDueLimit,
            _that.flatGasLimit,
            _that.flatGasPrice);
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
            String tag1,
            String tag2,
            @amountJsonConverter BigInt gasPrice,
            @amountJsonConverter BigInt gasLimit,
            @amountJsonConverter BigInt specialGasLimit,
            @amountJsonConverter BigInt gasCredit,
            @amountJsonConverter BigInt blockGasLimit,
            @amountJsonConverter BigInt freezeDueLimit,
            @amountJsonConverter BigInt deleteDueLimit,
            @amountJsonConverter BigInt flatGasLimit,
            @amountJsonConverter BigInt flatGasPrice)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GasPriceParams():
        return $default(
            _that.tag1,
            _that.tag2,
            _that.gasPrice,
            _that.gasLimit,
            _that.specialGasLimit,
            _that.gasCredit,
            _that.blockGasLimit,
            _that.freezeDueLimit,
            _that.deleteDueLimit,
            _that.flatGasLimit,
            _that.flatGasPrice);
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
            String tag1,
            String tag2,
            @amountJsonConverter BigInt gasPrice,
            @amountJsonConverter BigInt gasLimit,
            @amountJsonConverter BigInt specialGasLimit,
            @amountJsonConverter BigInt gasCredit,
            @amountJsonConverter BigInt blockGasLimit,
            @amountJsonConverter BigInt freezeDueLimit,
            @amountJsonConverter BigInt deleteDueLimit,
            @amountJsonConverter BigInt flatGasLimit,
            @amountJsonConverter BigInt flatGasPrice)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GasPriceParams() when $default != null:
        return $default(
            _that.tag1,
            _that.tag2,
            _that.gasPrice,
            _that.gasLimit,
            _that.specialGasLimit,
            _that.gasCredit,
            _that.blockGasLimit,
            _that.freezeDueLimit,
            _that.deleteDueLimit,
            _that.flatGasLimit,
            _that.flatGasPrice);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GasPriceParams implements GasPriceParams {
  const _GasPriceParams(
      {required this.tag1,
      required this.tag2,
      required this.gasPrice,
      required this.gasLimit,
      required this.specialGasLimit,
      required this.gasCredit,
      required this.blockGasLimit,
      required this.freezeDueLimit,
      required this.deleteDueLimit,
      required this.flatGasLimit,
      required this.flatGasPrice});
  factory _GasPriceParams.fromJson(Map<String, dynamic> json) =>
      _$GasPriceParamsFromJson(json);

  /// Flat tag
  @override
  final String tag1;

  /// Ext tag
  @override
  final String tag2;

  /// The price of gas unit
  @override
  final BigInt gasPrice;

  /// The maximum amount of gas available for a compute phase of
  /// an ordinary transaction
  @override
  final BigInt gasLimit;

  /// The maximum amount of gas available for a compute phase of
  /// a special transaction
  @override
  final BigInt specialGasLimit;

  /// The maximum amount of gas available before `ACCEPT`
  @override
  final BigInt gasCredit;

  /// The maximum amount of gas units per block
  @override
  final BigInt blockGasLimit;

  /// Amount of debt (in tokens) after which the account will be frozen
  @override
  final BigInt freezeDueLimit;

  /// Amount of debt (in tokens) after which the contract will be deleted
  @override
  final BigInt deleteDueLimit;

  /// Size of the first portion of gas with different price
  @override
  final BigInt flatGasLimit;

  /// The gas price for the first portion determinted by flatGasLimit
  @override
  final BigInt flatGasPrice;

  /// Create a copy of GasPriceParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GasPriceParamsCopyWith<_GasPriceParams> get copyWith =>
      __$GasPriceParamsCopyWithImpl<_GasPriceParams>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GasPriceParamsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GasPriceParams &&
            (identical(other.tag1, tag1) || other.tag1 == tag1) &&
            (identical(other.tag2, tag2) || other.tag2 == tag2) &&
            (identical(other.gasPrice, gasPrice) ||
                other.gasPrice == gasPrice) &&
            (identical(other.gasLimit, gasLimit) ||
                other.gasLimit == gasLimit) &&
            (identical(other.specialGasLimit, specialGasLimit) ||
                other.specialGasLimit == specialGasLimit) &&
            (identical(other.gasCredit, gasCredit) ||
                other.gasCredit == gasCredit) &&
            (identical(other.blockGasLimit, blockGasLimit) ||
                other.blockGasLimit == blockGasLimit) &&
            (identical(other.freezeDueLimit, freezeDueLimit) ||
                other.freezeDueLimit == freezeDueLimit) &&
            (identical(other.deleteDueLimit, deleteDueLimit) ||
                other.deleteDueLimit == deleteDueLimit) &&
            (identical(other.flatGasLimit, flatGasLimit) ||
                other.flatGasLimit == flatGasLimit) &&
            (identical(other.flatGasPrice, flatGasPrice) ||
                other.flatGasPrice == flatGasPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      tag1,
      tag2,
      gasPrice,
      gasLimit,
      specialGasLimit,
      gasCredit,
      blockGasLimit,
      freezeDueLimit,
      deleteDueLimit,
      flatGasLimit,
      flatGasPrice);

  @override
  String toString() {
    return 'GasPriceParams(tag1: $tag1, tag2: $tag2, gasPrice: $gasPrice, gasLimit: $gasLimit, specialGasLimit: $specialGasLimit, gasCredit: $gasCredit, blockGasLimit: $blockGasLimit, freezeDueLimit: $freezeDueLimit, deleteDueLimit: $deleteDueLimit, flatGasLimit: $flatGasLimit, flatGasPrice: $flatGasPrice)';
  }
}

/// @nodoc
abstract mixin class _$GasPriceParamsCopyWith<$Res>
    implements $GasPriceParamsCopyWith<$Res> {
  factory _$GasPriceParamsCopyWith(
          _GasPriceParams value, $Res Function(_GasPriceParams) _then) =
      __$GasPriceParamsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String tag1,
      String tag2,
      BigInt gasPrice,
      BigInt gasLimit,
      BigInt specialGasLimit,
      BigInt gasCredit,
      BigInt blockGasLimit,
      BigInt freezeDueLimit,
      BigInt deleteDueLimit,
      BigInt flatGasLimit,
      BigInt flatGasPrice});
}

/// @nodoc
class __$GasPriceParamsCopyWithImpl<$Res>
    implements _$GasPriceParamsCopyWith<$Res> {
  __$GasPriceParamsCopyWithImpl(this._self, this._then);

  final _GasPriceParams _self;
  final $Res Function(_GasPriceParams) _then;

  /// Create a copy of GasPriceParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tag1 = null,
    Object? tag2 = null,
    Object? gasPrice = null,
    Object? gasLimit = null,
    Object? specialGasLimit = null,
    Object? gasCredit = null,
    Object? blockGasLimit = null,
    Object? freezeDueLimit = null,
    Object? deleteDueLimit = null,
    Object? flatGasLimit = null,
    Object? flatGasPrice = null,
  }) {
    return _then(_GasPriceParams(
      tag1: null == tag1
          ? _self.tag1
          : tag1 // ignore: cast_nullable_to_non_nullable
              as String,
      tag2: null == tag2
          ? _self.tag2
          : tag2 // ignore: cast_nullable_to_non_nullable
              as String,
      gasPrice: null == gasPrice
          ? _self.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as BigInt,
      gasLimit: null == gasLimit
          ? _self.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      specialGasLimit: null == specialGasLimit
          ? _self.specialGasLimit
          : specialGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      gasCredit: null == gasCredit
          ? _self.gasCredit
          : gasCredit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      blockGasLimit: null == blockGasLimit
          ? _self.blockGasLimit
          : blockGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      freezeDueLimit: null == freezeDueLimit
          ? _self.freezeDueLimit
          : freezeDueLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      deleteDueLimit: null == deleteDueLimit
          ? _self.deleteDueLimit
          : deleteDueLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      flatGasLimit: null == flatGasLimit
          ? _self.flatGasLimit
          : flatGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      flatGasPrice: null == flatGasPrice
          ? _self.flatGasPrice
          : flatGasPrice // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

// dart format on
