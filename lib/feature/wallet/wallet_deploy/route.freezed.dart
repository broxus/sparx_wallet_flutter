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
mixin _$WalletDeployRouteData {
  /// Address of wallet to deploy
  Address get address => throw _privateConstructorUsedError;

  /// Public key of wallet owner
  PublicKey get publicKey => throw _privateConstructorUsedError;

  /// Create a copy of WalletDeployRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletDeployRouteDataCopyWith<WalletDeployRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletDeployRouteDataCopyWith<$Res> {
  factory $WalletDeployRouteDataCopyWith(WalletDeployRouteData value,
          $Res Function(WalletDeployRouteData) then) =
      _$WalletDeployRouteDataCopyWithImpl<$Res, WalletDeployRouteData>;
  @useResult
  $Res call({Address address, PublicKey publicKey});

  $AddressCopyWith<$Res> get address;
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class _$WalletDeployRouteDataCopyWithImpl<$Res,
        $Val extends WalletDeployRouteData>
    implements $WalletDeployRouteDataCopyWith<$Res> {
  _$WalletDeployRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletDeployRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? publicKey = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
    ) as $Val);
  }

  /// Create a copy of WalletDeployRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of WalletDeployRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get publicKey {
    return $PublicKeyCopyWith<$Res>(_value.publicKey, (value) {
      return _then(_value.copyWith(publicKey: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WalletDeployRouteDataImplCopyWith<$Res>
    implements $WalletDeployRouteDataCopyWith<$Res> {
  factory _$$WalletDeployRouteDataImplCopyWith(
          _$WalletDeployRouteDataImpl value,
          $Res Function(_$WalletDeployRouteDataImpl) then) =
      __$$WalletDeployRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Address address, PublicKey publicKey});

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class __$$WalletDeployRouteDataImplCopyWithImpl<$Res>
    extends _$WalletDeployRouteDataCopyWithImpl<$Res,
        _$WalletDeployRouteDataImpl>
    implements _$$WalletDeployRouteDataImplCopyWith<$Res> {
  __$$WalletDeployRouteDataImplCopyWithImpl(_$WalletDeployRouteDataImpl _value,
      $Res Function(_$WalletDeployRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? publicKey = null,
  }) {
    return _then(_$WalletDeployRouteDataImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
    ));
  }
}

/// @nodoc

class _$WalletDeployRouteDataImpl extends _WalletDeployRouteData {
  const _$WalletDeployRouteDataImpl(
      {required this.address, required this.publicKey})
      : super._();

  /// Address of wallet to deploy
  @override
  final Address address;

  /// Public key of wallet owner
  @override
  final PublicKey publicKey;

  @override
  String toString() {
    return 'WalletDeployRouteData(address: $address, publicKey: $publicKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletDeployRouteDataImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, publicKey);

  /// Create a copy of WalletDeployRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletDeployRouteDataImplCopyWith<_$WalletDeployRouteDataImpl>
      get copyWith => __$$WalletDeployRouteDataImplCopyWithImpl<
          _$WalletDeployRouteDataImpl>(this, _$identity);
}

abstract class _WalletDeployRouteData extends WalletDeployRouteData {
  const factory _WalletDeployRouteData(
      {required final Address address,
      required final PublicKey publicKey}) = _$WalletDeployRouteDataImpl;
  const _WalletDeployRouteData._() : super._();

  /// Address of wallet to deploy
  @override
  Address get address;

  /// Public key of wallet owner
  @override
  PublicKey get publicKey;

  /// Create a copy of WalletDeployRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletDeployRouteDataImplCopyWith<_$WalletDeployRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
