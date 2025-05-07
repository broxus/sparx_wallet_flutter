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
mixin _$KeyDetailRouteData {
  /// PublicKey of key
  PublicKey get publicKey => throw _privateConstructorUsedError;

  /// Create a copy of KeyDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyDetailRouteDataCopyWith<KeyDetailRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyDetailRouteDataCopyWith<$Res> {
  factory $KeyDetailRouteDataCopyWith(
          KeyDetailRouteData value, $Res Function(KeyDetailRouteData) then) =
      _$KeyDetailRouteDataCopyWithImpl<$Res, KeyDetailRouteData>;
  @useResult
  $Res call({PublicKey publicKey});

  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class _$KeyDetailRouteDataCopyWithImpl<$Res, $Val extends KeyDetailRouteData>
    implements $KeyDetailRouteDataCopyWith<$Res> {
  _$KeyDetailRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeyDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_value.copyWith(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
    ) as $Val);
  }

  /// Create a copy of KeyDetailRouteData
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
abstract class _$$KeyDetailRouteDataImplCopyWith<$Res>
    implements $KeyDetailRouteDataCopyWith<$Res> {
  factory _$$KeyDetailRouteDataImplCopyWith(_$KeyDetailRouteDataImpl value,
          $Res Function(_$KeyDetailRouteDataImpl) then) =
      __$$KeyDetailRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PublicKey publicKey});

  @override
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class __$$KeyDetailRouteDataImplCopyWithImpl<$Res>
    extends _$KeyDetailRouteDataCopyWithImpl<$Res, _$KeyDetailRouteDataImpl>
    implements _$$KeyDetailRouteDataImplCopyWith<$Res> {
  __$$KeyDetailRouteDataImplCopyWithImpl(_$KeyDetailRouteDataImpl _value,
      $Res Function(_$KeyDetailRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of KeyDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_$KeyDetailRouteDataImpl(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
    ));
  }
}

/// @nodoc

class _$KeyDetailRouteDataImpl extends _KeyDetailRouteData {
  const _$KeyDetailRouteDataImpl({required this.publicKey}) : super._();

  /// PublicKey of key
  @override
  final PublicKey publicKey;

  @override
  String toString() {
    return 'KeyDetailRouteData(publicKey: $publicKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyDetailRouteDataImpl &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, publicKey);

  /// Create a copy of KeyDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyDetailRouteDataImplCopyWith<_$KeyDetailRouteDataImpl> get copyWith =>
      __$$KeyDetailRouteDataImplCopyWithImpl<_$KeyDetailRouteDataImpl>(
          this, _$identity);
}

abstract class _KeyDetailRouteData extends KeyDetailRouteData {
  const factory _KeyDetailRouteData({required final PublicKey publicKey}) =
      _$KeyDetailRouteDataImpl;
  const _KeyDetailRouteData._() : super._();

  /// PublicKey of key
  @override
  PublicKey get publicKey;

  /// Create a copy of KeyDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyDetailRouteDataImplCopyWith<_$KeyDetailRouteDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
