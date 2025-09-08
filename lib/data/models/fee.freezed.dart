// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Fee {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Fee);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Fee()';
  }
}

/// @nodoc
class $FeeCopyWith<$Res> {
  $FeeCopyWith(Fee _, $Res Function(Fee) __);
}

/// @nodoc

class FeeEstimating extends Fee {
  const FeeEstimating() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FeeEstimating);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'Fee.estimating()';
  }
}

/// @nodoc

class FeeNative extends Fee {
  const FeeNative(this.amount) : super._();

  final Money amount;

  /// Create a copy of Fee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FeeNativeCopyWith<FeeNative> get copyWith =>
      _$FeeNativeCopyWithImpl<FeeNative>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FeeNative &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount);

  @override
  String toString() {
    return 'Fee.native(amount: $amount)';
  }
}

/// @nodoc
abstract mixin class $FeeNativeCopyWith<$Res> implements $FeeCopyWith<$Res> {
  factory $FeeNativeCopyWith(FeeNative value, $Res Function(FeeNative) _then) =
      _$FeeNativeCopyWithImpl;
  @useResult
  $Res call({Money amount});
}

/// @nodoc
class _$FeeNativeCopyWithImpl<$Res> implements $FeeNativeCopyWith<$Res> {
  _$FeeNativeCopyWithImpl(this._self, this._then);

  final FeeNative _self;
  final $Res Function(FeeNative) _then;

  /// Create a copy of Fee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? amount = null,
  }) {
    return _then(FeeNative(
      null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Money,
    ));
  }
}

/// @nodoc

class FeeToken extends Fee {
  const FeeToken({required this.amount, required this.tokenRootAddress})
      : super._();

  final Money amount;
  final Address tokenRootAddress;

  /// Create a copy of Fee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FeeTokenCopyWith<FeeToken> get copyWith =>
      _$FeeTokenCopyWithImpl<FeeToken>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FeeToken &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tokenRootAddress, tokenRootAddress) ||
                other.tokenRootAddress == tokenRootAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, tokenRootAddress);

  @override
  String toString() {
    return 'Fee.token(amount: $amount, tokenRootAddress: $tokenRootAddress)';
  }
}

/// @nodoc
abstract mixin class $FeeTokenCopyWith<$Res> implements $FeeCopyWith<$Res> {
  factory $FeeTokenCopyWith(FeeToken value, $Res Function(FeeToken) _then) =
      _$FeeTokenCopyWithImpl;
  @useResult
  $Res call({Money amount, Address tokenRootAddress});

  $AddressCopyWith<$Res> get tokenRootAddress;
}

/// @nodoc
class _$FeeTokenCopyWithImpl<$Res> implements $FeeTokenCopyWith<$Res> {
  _$FeeTokenCopyWithImpl(this._self, this._then);

  final FeeToken _self;
  final $Res Function(FeeToken) _then;

  /// Create a copy of Fee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? amount = null,
    Object? tokenRootAddress = null,
  }) {
    return _then(FeeToken(
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Money,
      tokenRootAddress: null == tokenRootAddress
          ? _self.tokenRootAddress
          : tokenRootAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of Fee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get tokenRootAddress {
    return $AddressCopyWith<$Res>(_self.tokenRootAddress, (value) {
      return _then(_self.copyWith(tokenRootAddress: value));
    });
  }
}

// dart format on
