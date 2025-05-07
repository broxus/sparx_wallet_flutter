// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletCancelUnstakingRouteData {
  /// StEver withdraw request
  StEverWithdrawRequest get request => throw _privateConstructorUsedError;

  /// Account public key
  PublicKey get accountKey => throw _privateConstructorUsedError;

  /// Attached fee
  BigInt get attachedFee => throw _privateConstructorUsedError;

  /// Exchange rate
  double get exchangeRate => throw _privateConstructorUsedError;

  /// Staking currency
  Currency get stakeCurrency => throw _privateConstructorUsedError;

  /// Withdraw hours
  int get withdrawHours => throw _privateConstructorUsedError;

  /// Token price (optional)
  Fixed? get tokenPrice => throw _privateConstructorUsedError;

  /// Ever price (optional)
  Fixed? get everPrice => throw _privateConstructorUsedError;

  /// Create a copy of WalletCancelUnstakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletCancelUnstakingRouteDataCopyWith<WalletCancelUnstakingRouteData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletCancelUnstakingRouteDataCopyWith<$Res> {
  factory $WalletCancelUnstakingRouteDataCopyWith(
          WalletCancelUnstakingRouteData value,
          $Res Function(WalletCancelUnstakingRouteData) then) =
      _$WalletCancelUnstakingRouteDataCopyWithImpl<$Res,
          WalletCancelUnstakingRouteData>;
  @useResult
  $Res call(
      {StEverWithdrawRequest request,
      PublicKey accountKey,
      BigInt attachedFee,
      double exchangeRate,
      Currency stakeCurrency,
      int withdrawHours,
      Fixed? tokenPrice,
      Fixed? everPrice});

  $StEverWithdrawRequestCopyWith<$Res> get request;
  $PublicKeyCopyWith<$Res> get accountKey;
}

/// @nodoc
class _$WalletCancelUnstakingRouteDataCopyWithImpl<$Res,
        $Val extends WalletCancelUnstakingRouteData>
    implements $WalletCancelUnstakingRouteDataCopyWith<$Res> {
  _$WalletCancelUnstakingRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletCancelUnstakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = null,
    Object? accountKey = null,
    Object? attachedFee = null,
    Object? exchangeRate = null,
    Object? stakeCurrency = null,
    Object? withdrawHours = null,
    Object? tokenPrice = freezed,
    Object? everPrice = freezed,
  }) {
    return _then(_value.copyWith(
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as StEverWithdrawRequest,
      accountKey: null == accountKey
          ? _value.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      attachedFee: null == attachedFee
          ? _value.attachedFee
          : attachedFee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      exchangeRate: null == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double,
      stakeCurrency: null == stakeCurrency
          ? _value.stakeCurrency
          : stakeCurrency // ignore: cast_nullable_to_non_nullable
              as Currency,
      withdrawHours: null == withdrawHours
          ? _value.withdrawHours
          : withdrawHours // ignore: cast_nullable_to_non_nullable
              as int,
      tokenPrice: freezed == tokenPrice
          ? _value.tokenPrice
          : tokenPrice // ignore: cast_nullable_to_non_nullable
              as Fixed?,
      everPrice: freezed == everPrice
          ? _value.everPrice
          : everPrice // ignore: cast_nullable_to_non_nullable
              as Fixed?,
    ) as $Val);
  }

  /// Create a copy of WalletCancelUnstakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StEverWithdrawRequestCopyWith<$Res> get request {
    return $StEverWithdrawRequestCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value) as $Val);
    });
  }

  /// Create a copy of WalletCancelUnstakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get accountKey {
    return $PublicKeyCopyWith<$Res>(_value.accountKey, (value) {
      return _then(_value.copyWith(accountKey: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WalletCancelUnstakingRouteDataImplCopyWith<$Res>
    implements $WalletCancelUnstakingRouteDataCopyWith<$Res> {
  factory _$$WalletCancelUnstakingRouteDataImplCopyWith(
          _$WalletCancelUnstakingRouteDataImpl value,
          $Res Function(_$WalletCancelUnstakingRouteDataImpl) then) =
      __$$WalletCancelUnstakingRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StEverWithdrawRequest request,
      PublicKey accountKey,
      BigInt attachedFee,
      double exchangeRate,
      Currency stakeCurrency,
      int withdrawHours,
      Fixed? tokenPrice,
      Fixed? everPrice});

  @override
  $StEverWithdrawRequestCopyWith<$Res> get request;
  @override
  $PublicKeyCopyWith<$Res> get accountKey;
}

/// @nodoc
class __$$WalletCancelUnstakingRouteDataImplCopyWithImpl<$Res>
    extends _$WalletCancelUnstakingRouteDataCopyWithImpl<$Res,
        _$WalletCancelUnstakingRouteDataImpl>
    implements _$$WalletCancelUnstakingRouteDataImplCopyWith<$Res> {
  __$$WalletCancelUnstakingRouteDataImplCopyWithImpl(
      _$WalletCancelUnstakingRouteDataImpl _value,
      $Res Function(_$WalletCancelUnstakingRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletCancelUnstakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = null,
    Object? accountKey = null,
    Object? attachedFee = null,
    Object? exchangeRate = null,
    Object? stakeCurrency = null,
    Object? withdrawHours = null,
    Object? tokenPrice = freezed,
    Object? everPrice = freezed,
  }) {
    return _then(_$WalletCancelUnstakingRouteDataImpl(
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as StEverWithdrawRequest,
      accountKey: null == accountKey
          ? _value.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      attachedFee: null == attachedFee
          ? _value.attachedFee
          : attachedFee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      exchangeRate: null == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double,
      stakeCurrency: null == stakeCurrency
          ? _value.stakeCurrency
          : stakeCurrency // ignore: cast_nullable_to_non_nullable
              as Currency,
      withdrawHours: null == withdrawHours
          ? _value.withdrawHours
          : withdrawHours // ignore: cast_nullable_to_non_nullable
              as int,
      tokenPrice: freezed == tokenPrice
          ? _value.tokenPrice
          : tokenPrice // ignore: cast_nullable_to_non_nullable
              as Fixed?,
      everPrice: freezed == everPrice
          ? _value.everPrice
          : everPrice // ignore: cast_nullable_to_non_nullable
              as Fixed?,
    ));
  }
}

/// @nodoc

class _$WalletCancelUnstakingRouteDataImpl
    extends _WalletCancelUnstakingRouteData {
  const _$WalletCancelUnstakingRouteDataImpl(
      {required this.request,
      required this.accountKey,
      required this.attachedFee,
      required this.exchangeRate,
      required this.stakeCurrency,
      required this.withdrawHours,
      this.tokenPrice,
      this.everPrice})
      : super._();

  /// StEver withdraw request
  @override
  final StEverWithdrawRequest request;

  /// Account public key
  @override
  final PublicKey accountKey;

  /// Attached fee
  @override
  final BigInt attachedFee;

  /// Exchange rate
  @override
  final double exchangeRate;

  /// Staking currency
  @override
  final Currency stakeCurrency;

  /// Withdraw hours
  @override
  final int withdrawHours;

  /// Token price (optional)
  @override
  final Fixed? tokenPrice;

  /// Ever price (optional)
  @override
  final Fixed? everPrice;

  @override
  String toString() {
    return 'WalletCancelUnstakingRouteData(request: $request, accountKey: $accountKey, attachedFee: $attachedFee, exchangeRate: $exchangeRate, stakeCurrency: $stakeCurrency, withdrawHours: $withdrawHours, tokenPrice: $tokenPrice, everPrice: $everPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletCancelUnstakingRouteDataImpl &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.accountKey, accountKey) ||
                other.accountKey == accountKey) &&
            (identical(other.attachedFee, attachedFee) ||
                other.attachedFee == attachedFee) &&
            (identical(other.exchangeRate, exchangeRate) ||
                other.exchangeRate == exchangeRate) &&
            (identical(other.stakeCurrency, stakeCurrency) ||
                other.stakeCurrency == stakeCurrency) &&
            (identical(other.withdrawHours, withdrawHours) ||
                other.withdrawHours == withdrawHours) &&
            (identical(other.tokenPrice, tokenPrice) ||
                other.tokenPrice == tokenPrice) &&
            (identical(other.everPrice, everPrice) ||
                other.everPrice == everPrice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request, accountKey, attachedFee,
      exchangeRate, stakeCurrency, withdrawHours, tokenPrice, everPrice);

  /// Create a copy of WalletCancelUnstakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletCancelUnstakingRouteDataImplCopyWith<
          _$WalletCancelUnstakingRouteDataImpl>
      get copyWith => __$$WalletCancelUnstakingRouteDataImplCopyWithImpl<
          _$WalletCancelUnstakingRouteDataImpl>(this, _$identity);
}

abstract class _WalletCancelUnstakingRouteData
    extends WalletCancelUnstakingRouteData {
  const factory _WalletCancelUnstakingRouteData(
      {required final StEverWithdrawRequest request,
      required final PublicKey accountKey,
      required final BigInt attachedFee,
      required final double exchangeRate,
      required final Currency stakeCurrency,
      required final int withdrawHours,
      final Fixed? tokenPrice,
      final Fixed? everPrice}) = _$WalletCancelUnstakingRouteDataImpl;
  const _WalletCancelUnstakingRouteData._() : super._();

  /// StEver withdraw request
  @override
  StEverWithdrawRequest get request;

  /// Account public key
  @override
  PublicKey get accountKey;

  /// Attached fee
  @override
  BigInt get attachedFee;

  /// Exchange rate
  @override
  double get exchangeRate;

  /// Staking currency
  @override
  Currency get stakeCurrency;

  /// Withdraw hours
  @override
  int get withdrawHours;

  /// Token price (optional)
  @override
  Fixed? get tokenPrice;

  /// Ever price (optional)
  @override
  Fixed? get everPrice;

  /// Create a copy of WalletCancelUnstakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletCancelUnstakingRouteDataImplCopyWith<
          _$WalletCancelUnstakingRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
