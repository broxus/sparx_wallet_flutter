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
mixin _$WalletStakeRouteData {
  /// Address of the account to stake
  Address get accountAddress => throw _privateConstructorUsedError;

  /// Create a copy of WalletStakeRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletStakeRouteDataCopyWith<WalletStakeRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletStakeRouteDataCopyWith<$Res> {
  factory $WalletStakeRouteDataCopyWith(WalletStakeRouteData value,
          $Res Function(WalletStakeRouteData) then) =
      _$WalletStakeRouteDataCopyWithImpl<$Res, WalletStakeRouteData>;
  @useResult
  $Res call({Address accountAddress});

  $AddressCopyWith<$Res> get accountAddress;
}

/// @nodoc
class _$WalletStakeRouteDataCopyWithImpl<$Res,
        $Val extends WalletStakeRouteData>
    implements $WalletStakeRouteDataCopyWith<$Res> {
  _$WalletStakeRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletStakeRouteData
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

  /// Create a copy of WalletStakeRouteData
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
abstract class _$$WalletStakeRouteDataImplCopyWith<$Res>
    implements $WalletStakeRouteDataCopyWith<$Res> {
  factory _$$WalletStakeRouteDataImplCopyWith(_$WalletStakeRouteDataImpl value,
          $Res Function(_$WalletStakeRouteDataImpl) then) =
      __$$WalletStakeRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Address accountAddress});

  @override
  $AddressCopyWith<$Res> get accountAddress;
}

/// @nodoc
class __$$WalletStakeRouteDataImplCopyWithImpl<$Res>
    extends _$WalletStakeRouteDataCopyWithImpl<$Res, _$WalletStakeRouteDataImpl>
    implements _$$WalletStakeRouteDataImplCopyWith<$Res> {
  __$$WalletStakeRouteDataImplCopyWithImpl(_$WalletStakeRouteDataImpl _value,
      $Res Function(_$WalletStakeRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletStakeRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountAddress = null,
  }) {
    return _then(_$WalletStakeRouteDataImpl(
      accountAddress: null == accountAddress
          ? _value.accountAddress
          : accountAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }
}

/// @nodoc

class _$WalletStakeRouteDataImpl extends _WalletStakeRouteData {
  const _$WalletStakeRouteDataImpl({required this.accountAddress}) : super._();

  /// Address of the account to stake
  @override
  final Address accountAddress;

  @override
  String toString() {
    return 'WalletStakeRouteData(accountAddress: $accountAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletStakeRouteDataImpl &&
            (identical(other.accountAddress, accountAddress) ||
                other.accountAddress == accountAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountAddress);

  /// Create a copy of WalletStakeRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletStakeRouteDataImplCopyWith<_$WalletStakeRouteDataImpl>
      get copyWith =>
          __$$WalletStakeRouteDataImplCopyWithImpl<_$WalletStakeRouteDataImpl>(
              this, _$identity);
}

abstract class _WalletStakeRouteData extends WalletStakeRouteData {
  const factory _WalletStakeRouteData({required final Address accountAddress}) =
      _$WalletStakeRouteDataImpl;
  const _WalletStakeRouteData._() : super._();

  /// Address of the account to stake
  @override
  Address get accountAddress;

  /// Create a copy of WalletStakeRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletStakeRouteDataImplCopyWith<_$WalletStakeRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
