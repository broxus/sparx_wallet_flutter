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
mixin _$WalletNewAccountRouteData {
  String get publicKey => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;

  /// Create a copy of WalletNewAccountRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletNewAccountRouteDataCopyWith<WalletNewAccountRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletNewAccountRouteDataCopyWith<$Res> {
  factory $WalletNewAccountRouteDataCopyWith(WalletNewAccountRouteData value,
          $Res Function(WalletNewAccountRouteData) then) =
      _$WalletNewAccountRouteDataCopyWithImpl<$Res, WalletNewAccountRouteData>;
  @useResult
  $Res call({String publicKey, String? password});
}

/// @nodoc
class _$WalletNewAccountRouteDataCopyWithImpl<$Res,
        $Val extends WalletNewAccountRouteData>
    implements $WalletNewAccountRouteDataCopyWith<$Res> {
  _$WalletNewAccountRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletNewAccountRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletNewAccountRouteDataImplCopyWith<$Res>
    implements $WalletNewAccountRouteDataCopyWith<$Res> {
  factory _$$WalletNewAccountRouteDataImplCopyWith(
          _$WalletNewAccountRouteDataImpl value,
          $Res Function(_$WalletNewAccountRouteDataImpl) then) =
      __$$WalletNewAccountRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String publicKey, String? password});
}

/// @nodoc
class __$$WalletNewAccountRouteDataImplCopyWithImpl<$Res>
    extends _$WalletNewAccountRouteDataCopyWithImpl<$Res,
        _$WalletNewAccountRouteDataImpl>
    implements _$$WalletNewAccountRouteDataImplCopyWith<$Res> {
  __$$WalletNewAccountRouteDataImplCopyWithImpl(
      _$WalletNewAccountRouteDataImpl _value,
      $Res Function(_$WalletNewAccountRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletNewAccountRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
    Object? password = freezed,
  }) {
    return _then(_$WalletNewAccountRouteDataImpl(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WalletNewAccountRouteDataImpl extends _WalletNewAccountRouteData {
  const _$WalletNewAccountRouteDataImpl(
      {required this.publicKey, this.password})
      : super._();

  @override
  final String publicKey;
  @override
  final String? password;

  @override
  String toString() {
    return 'WalletNewAccountRouteData(publicKey: $publicKey, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletNewAccountRouteDataImpl &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, publicKey, password);

  /// Create a copy of WalletNewAccountRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletNewAccountRouteDataImplCopyWith<_$WalletNewAccountRouteDataImpl>
      get copyWith => __$$WalletNewAccountRouteDataImplCopyWithImpl<
          _$WalletNewAccountRouteDataImpl>(this, _$identity);
}

abstract class _WalletNewAccountRouteData extends WalletNewAccountRouteData {
  const factory _WalletNewAccountRouteData(
      {required final String publicKey,
      final String? password}) = _$WalletNewAccountRouteDataImpl;
  const _WalletNewAccountRouteData._() : super._();

  @override
  String get publicKey;
  @override
  String? get password;

  /// Create a copy of WalletNewAccountRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletNewAccountRouteDataImplCopyWith<_$WalletNewAccountRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
