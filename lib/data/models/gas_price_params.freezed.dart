// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
  @amountJsonConverter
  BigInt get gasPrice;

  /// The maximum amount of gas available for a compute phase of
  /// an ordinary transaction
  @amountJsonConverter
  BigInt get gasLimit;

  /// The maximum amount of gas available for a compute phase of
  /// a special transaction
  @amountJsonConverter
  BigInt get specialGasLimit;

  /// The maximum amount of gas available before `ACCEPT`
  @amountJsonConverter
  BigInt get gasCredit;

  /// The maximum amount of gas units per block
  @amountJsonConverter
  BigInt get blockGasLimit;

  /// Amount of debt (in tokens) after which the account will be frozen
  @amountJsonConverter
  BigInt get freezeDueLimit;

  /// Amount of debt (in tokens) after which the contract will be deleted
  @amountJsonConverter
  BigInt get deleteDueLimit;

  /// Size of the first portion of gas with different price
  @amountJsonConverter
  BigInt get flatGasLimit;

  /// The gas price for the first portion determinted by flatGasLimit
  @amountJsonConverter
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
      @amountJsonConverter BigInt gasPrice,
      @amountJsonConverter BigInt gasLimit,
      @amountJsonConverter BigInt specialGasLimit,
      @amountJsonConverter BigInt gasCredit,
      @amountJsonConverter BigInt blockGasLimit,
      @amountJsonConverter BigInt freezeDueLimit,
      @amountJsonConverter BigInt deleteDueLimit,
      @amountJsonConverter BigInt flatGasLimit,
      @amountJsonConverter BigInt flatGasPrice});
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

/// @nodoc
@JsonSerializable()
class _GasPriceParams implements GasPriceParams {
  const _GasPriceParams(
      {required this.tag1,
      required this.tag2,
      @amountJsonConverter required this.gasPrice,
      @amountJsonConverter required this.gasLimit,
      @amountJsonConverter required this.specialGasLimit,
      @amountJsonConverter required this.gasCredit,
      @amountJsonConverter required this.blockGasLimit,
      @amountJsonConverter required this.freezeDueLimit,
      @amountJsonConverter required this.deleteDueLimit,
      @amountJsonConverter required this.flatGasLimit,
      @amountJsonConverter required this.flatGasPrice});
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
  @amountJsonConverter
  final BigInt gasPrice;

  /// The maximum amount of gas available for a compute phase of
  /// an ordinary transaction
  @override
  @amountJsonConverter
  final BigInt gasLimit;

  /// The maximum amount of gas available for a compute phase of
  /// a special transaction
  @override
  @amountJsonConverter
  final BigInt specialGasLimit;

  /// The maximum amount of gas available before `ACCEPT`
  @override
  @amountJsonConverter
  final BigInt gasCredit;

  /// The maximum amount of gas units per block
  @override
  @amountJsonConverter
  final BigInt blockGasLimit;

  /// Amount of debt (in tokens) after which the account will be frozen
  @override
  @amountJsonConverter
  final BigInt freezeDueLimit;

  /// Amount of debt (in tokens) after which the contract will be deleted
  @override
  @amountJsonConverter
  final BigInt deleteDueLimit;

  /// Size of the first portion of gas with different price
  @override
  @amountJsonConverter
  final BigInt flatGasLimit;

  /// The gas price for the first portion determinted by flatGasLimit
  @override
  @amountJsonConverter
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
      @amountJsonConverter BigInt gasPrice,
      @amountJsonConverter BigInt gasLimit,
      @amountJsonConverter BigInt specialGasLimit,
      @amountJsonConverter BigInt gasCredit,
      @amountJsonConverter BigInt blockGasLimit,
      @amountJsonConverter BigInt freezeDueLimit,
      @amountJsonConverter BigInt deleteDueLimit,
      @amountJsonConverter BigInt flatGasLimit,
      @amountJsonConverter BigInt flatGasPrice});
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
