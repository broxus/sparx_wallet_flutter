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
mixin _$AccountDetailRouteData {
  /// Address of account
  Address get address => throw _privateConstructorUsedError;

  /// Create a copy of AccountDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountDetailRouteDataCopyWith<AccountDetailRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountDetailRouteDataCopyWith<$Res> {
  factory $AccountDetailRouteDataCopyWith(AccountDetailRouteData value,
          $Res Function(AccountDetailRouteData) then) =
      _$AccountDetailRouteDataCopyWithImpl<$Res, AccountDetailRouteData>;
  @useResult
  $Res call({Address address});

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class _$AccountDetailRouteDataCopyWithImpl<$Res,
        $Val extends AccountDetailRouteData>
    implements $AccountDetailRouteDataCopyWith<$Res> {
  _$AccountDetailRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountDetailRouteData
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

  /// Create a copy of AccountDetailRouteData
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
abstract class _$$AccountDetailRouteDataImplCopyWith<$Res>
    implements $AccountDetailRouteDataCopyWith<$Res> {
  factory _$$AccountDetailRouteDataImplCopyWith(
          _$AccountDetailRouteDataImpl value,
          $Res Function(_$AccountDetailRouteDataImpl) then) =
      __$$AccountDetailRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Address address});

  @override
  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$$AccountDetailRouteDataImplCopyWithImpl<$Res>
    extends _$AccountDetailRouteDataCopyWithImpl<$Res,
        _$AccountDetailRouteDataImpl>
    implements _$$AccountDetailRouteDataImplCopyWith<$Res> {
  __$$AccountDetailRouteDataImplCopyWithImpl(
      _$AccountDetailRouteDataImpl _value,
      $Res Function(_$AccountDetailRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_$AccountDetailRouteDataImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }
}

/// @nodoc

class _$AccountDetailRouteDataImpl extends _AccountDetailRouteData {
  const _$AccountDetailRouteDataImpl({required this.address}) : super._();

  /// Address of account
  @override
  final Address address;

  @override
  String toString() {
    return 'AccountDetailRouteData(address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountDetailRouteDataImpl &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address);

  /// Create a copy of AccountDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountDetailRouteDataImplCopyWith<_$AccountDetailRouteDataImpl>
      get copyWith => __$$AccountDetailRouteDataImplCopyWithImpl<
          _$AccountDetailRouteDataImpl>(this, _$identity);
}

abstract class _AccountDetailRouteData extends AccountDetailRouteData {
  const factory _AccountDetailRouteData({required final Address address}) =
      _$AccountDetailRouteDataImpl;
  const _AccountDetailRouteData._() : super._();

  /// Address of account
  @override
  Address get address;

  /// Create a copy of AccountDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountDetailRouteDataImplCopyWith<_$AccountDetailRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
