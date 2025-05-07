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
mixin _$SeedDetailRouteData {
  /// PublicKey of seed
  PublicKey get publicKey => throw _privateConstructorUsedError;

  /// Create a copy of SeedDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeedDetailRouteDataCopyWith<SeedDetailRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeedDetailRouteDataCopyWith<$Res> {
  factory $SeedDetailRouteDataCopyWith(
          SeedDetailRouteData value, $Res Function(SeedDetailRouteData) then) =
      _$SeedDetailRouteDataCopyWithImpl<$Res, SeedDetailRouteData>;
  @useResult
  $Res call({PublicKey publicKey});

  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class _$SeedDetailRouteDataCopyWithImpl<$Res, $Val extends SeedDetailRouteData>
    implements $SeedDetailRouteDataCopyWith<$Res> {
  _$SeedDetailRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeedDetailRouteData
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

  /// Create a copy of SeedDetailRouteData
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
abstract class _$$SeedDetailRouteDataImplCopyWith<$Res>
    implements $SeedDetailRouteDataCopyWith<$Res> {
  factory _$$SeedDetailRouteDataImplCopyWith(_$SeedDetailRouteDataImpl value,
          $Res Function(_$SeedDetailRouteDataImpl) then) =
      __$$SeedDetailRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PublicKey publicKey});

  @override
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class __$$SeedDetailRouteDataImplCopyWithImpl<$Res>
    extends _$SeedDetailRouteDataCopyWithImpl<$Res, _$SeedDetailRouteDataImpl>
    implements _$$SeedDetailRouteDataImplCopyWith<$Res> {
  __$$SeedDetailRouteDataImplCopyWithImpl(_$SeedDetailRouteDataImpl _value,
      $Res Function(_$SeedDetailRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SeedDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_$SeedDetailRouteDataImpl(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
    ));
  }
}

/// @nodoc

class _$SeedDetailRouteDataImpl extends _SeedDetailRouteData {
  const _$SeedDetailRouteDataImpl({required this.publicKey}) : super._();

  /// PublicKey of seed
  @override
  final PublicKey publicKey;

  @override
  String toString() {
    return 'SeedDetailRouteData(publicKey: $publicKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeedDetailRouteDataImpl &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, publicKey);

  /// Create a copy of SeedDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeedDetailRouteDataImplCopyWith<_$SeedDetailRouteDataImpl> get copyWith =>
      __$$SeedDetailRouteDataImplCopyWithImpl<_$SeedDetailRouteDataImpl>(
          this, _$identity);
}

abstract class _SeedDetailRouteData extends SeedDetailRouteData {
  const factory _SeedDetailRouteData({required final PublicKey publicKey}) =
      _$SeedDetailRouteDataImpl;
  const _SeedDetailRouteData._() : super._();

  /// PublicKey of seed
  @override
  PublicKey get publicKey;

  /// Create a copy of SeedDetailRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeedDetailRouteDataImplCopyWith<_$SeedDetailRouteDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
