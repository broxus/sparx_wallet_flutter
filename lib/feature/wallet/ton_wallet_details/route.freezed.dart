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
mixin _$TonWalletDetailsRouteData {
  /// Address of TON wallet to display
  Address get address => throw _privateConstructorUsedError;

  /// Create a copy of TonWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TonWalletDetailsRouteDataCopyWith<TonWalletDetailsRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonWalletDetailsRouteDataCopyWith<$Res> {
  factory $TonWalletDetailsRouteDataCopyWith(TonWalletDetailsRouteData value,
          $Res Function(TonWalletDetailsRouteData) then) =
      _$TonWalletDetailsRouteDataCopyWithImpl<$Res, TonWalletDetailsRouteData>;
  @useResult
  $Res call({Address address});

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class _$TonWalletDetailsRouteDataCopyWithImpl<$Res,
        $Val extends TonWalletDetailsRouteData>
    implements $TonWalletDetailsRouteDataCopyWith<$Res> {
  _$TonWalletDetailsRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TonWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
    ) as $Val);
  }

  /// Create a copy of TonWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TonWalletDetailsRouteDataImplCopyWith<$Res>
    implements $TonWalletDetailsRouteDataCopyWith<$Res> {
  factory _$$TonWalletDetailsRouteDataImplCopyWith(
          _$TonWalletDetailsRouteDataImpl value,
          $Res Function(_$TonWalletDetailsRouteDataImpl) then) =
      __$$TonWalletDetailsRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Address address});

  @override
  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$$TonWalletDetailsRouteDataImplCopyWithImpl<$Res>
    extends _$TonWalletDetailsRouteDataCopyWithImpl<$Res,
        _$TonWalletDetailsRouteDataImpl>
    implements _$$TonWalletDetailsRouteDataImplCopyWith<$Res> {
  __$$TonWalletDetailsRouteDataImplCopyWithImpl(
      _$TonWalletDetailsRouteDataImpl _value,
      $Res Function(_$TonWalletDetailsRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_$TonWalletDetailsRouteDataImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }
}

/// @nodoc

class _$TonWalletDetailsRouteDataImpl extends _TonWalletDetailsRouteData {
  const _$TonWalletDetailsRouteDataImpl({required this.address}) : super._();

  /// Address of TON wallet to display
  @override
  final Address address;

  @override
  String toString() {
    return 'TonWalletDetailsRouteData(address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonWalletDetailsRouteDataImpl &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address);

  /// Create a copy of TonWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonWalletDetailsRouteDataImplCopyWith<_$TonWalletDetailsRouteDataImpl>
      get copyWith => __$$TonWalletDetailsRouteDataImplCopyWithImpl<
          _$TonWalletDetailsRouteDataImpl>(this, _$identity);
}

abstract class _TonWalletDetailsRouteData extends TonWalletDetailsRouteData {
  const factory _TonWalletDetailsRouteData({required final Address address}) =
      _$TonWalletDetailsRouteDataImpl;
  const _TonWalletDetailsRouteData._() : super._();

  /// Address of TON wallet to display
  @override
  Address get address;

  /// Create a copy of TonWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonWalletDetailsRouteDataImplCopyWith<_$TonWalletDetailsRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
