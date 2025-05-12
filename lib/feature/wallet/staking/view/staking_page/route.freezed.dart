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
mixin _$StakingRouteData {
  /// Address of the account to stake
  Address get accountAddress => throw _privateConstructorUsedError;

  /// Create a copy of StakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StakingRouteDataCopyWith<StakingRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StakingRouteDataCopyWith<$Res> {
  factory $StakingRouteDataCopyWith(
          StakingRouteData value, $Res Function(StakingRouteData) then) =
      _$StakingRouteDataCopyWithImpl<$Res, StakingRouteData>;
  @useResult
  $Res call({Address accountAddress});

  $AddressCopyWith<$Res> get accountAddress;
}

/// @nodoc
class _$StakingRouteDataCopyWithImpl<$Res, $Val extends StakingRouteData>
    implements $StakingRouteDataCopyWith<$Res> {
  _$StakingRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountAddress = null,
  }) {
    return _then(_value.copyWith(
      accountAddress: null == accountAddress
          ? _value.accountAddress
          : accountAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ) as $Val);
  }

  /// Create a copy of StakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get accountAddress {
    return $AddressCopyWith<$Res>(_value.accountAddress, (value) {
      return _then(_value.copyWith(accountAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StakingRouteDataImplCopyWith<$Res>
    implements $StakingRouteDataCopyWith<$Res> {
  factory _$$StakingRouteDataImplCopyWith(_$StakingRouteDataImpl value,
          $Res Function(_$StakingRouteDataImpl) then) =
      __$$StakingRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Address accountAddress});

  @override
  $AddressCopyWith<$Res> get accountAddress;
}

/// @nodoc
class __$$StakingRouteDataImplCopyWithImpl<$Res>
    extends _$StakingRouteDataCopyWithImpl<$Res, _$StakingRouteDataImpl>
    implements _$$StakingRouteDataImplCopyWith<$Res> {
  __$$StakingRouteDataImplCopyWithImpl(_$StakingRouteDataImpl _value,
      $Res Function(_$StakingRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of StakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountAddress = null,
  }) {
    return _then(_$StakingRouteDataImpl(
      accountAddress: null == accountAddress
          ? _value.accountAddress
          : accountAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }
}

/// @nodoc

class _$StakingRouteDataImpl extends _StakingRouteData {
  const _$StakingRouteDataImpl({required this.accountAddress}) : super._();

  /// Address of the account to stake
  @override
  final Address accountAddress;

  @override
  String toString() {
    return 'StakingRouteData(accountAddress: $accountAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StakingRouteDataImpl &&
            (identical(other.accountAddress, accountAddress) ||
                other.accountAddress == accountAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountAddress);

  /// Create a copy of StakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StakingRouteDataImplCopyWith<_$StakingRouteDataImpl> get copyWith =>
      __$$StakingRouteDataImplCopyWithImpl<_$StakingRouteDataImpl>(
          this, _$identity);
}

abstract class _StakingRouteData extends StakingRouteData {
  const factory _StakingRouteData({required final Address accountAddress}) =
      _$StakingRouteDataImpl;
  const _StakingRouteData._() : super._();

  /// Address of the account to stake
  @override
  Address get accountAddress;

  /// Create a copy of StakingRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StakingRouteDataImplCopyWith<_$StakingRouteDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
