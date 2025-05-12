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
mixin _$CreateSeedRouteData {
  String? get seedName => throw _privateConstructorUsedError;

  /// Create a copy of CreateSeedRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateSeedRouteDataCopyWith<CreateSeedRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSeedRouteDataCopyWith<$Res> {
  factory $CreateSeedRouteDataCopyWith(
          CreateSeedRouteData value, $Res Function(CreateSeedRouteData) then) =
      _$CreateSeedRouteDataCopyWithImpl<$Res, CreateSeedRouteData>;
  @useResult
  $Res call({String? seedName});
}

/// @nodoc
class _$CreateSeedRouteDataCopyWithImpl<$Res, $Val extends CreateSeedRouteData>
    implements $CreateSeedRouteDataCopyWith<$Res> {
  _$CreateSeedRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateSeedRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seedName = freezed,
  }) {
    return _then(_value.copyWith(
      seedName: freezed == seedName
          ? _value.seedName
          : seedName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateSeedRouteDataImplCopyWith<$Res>
    implements $CreateSeedRouteDataCopyWith<$Res> {
  factory _$$CreateSeedRouteDataImplCopyWith(_$CreateSeedRouteDataImpl value,
          $Res Function(_$CreateSeedRouteDataImpl) then) =
      __$$CreateSeedRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? seedName});
}

/// @nodoc
class __$$CreateSeedRouteDataImplCopyWithImpl<$Res>
    extends _$CreateSeedRouteDataCopyWithImpl<$Res, _$CreateSeedRouteDataImpl>
    implements _$$CreateSeedRouteDataImplCopyWith<$Res> {
  __$$CreateSeedRouteDataImplCopyWithImpl(_$CreateSeedRouteDataImpl _value,
      $Res Function(_$CreateSeedRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateSeedRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seedName = freezed,
  }) {
    return _then(_$CreateSeedRouteDataImpl(
      seedName: freezed == seedName
          ? _value.seedName
          : seedName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CreateSeedRouteDataImpl extends _CreateSeedRouteData {
  const _$CreateSeedRouteDataImpl({required this.seedName}) : super._();

  @override
  final String? seedName;

  @override
  String toString() {
    return 'CreateSeedRouteData(seedName: $seedName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSeedRouteDataImpl &&
            (identical(other.seedName, seedName) ||
                other.seedName == seedName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, seedName);

  /// Create a copy of CreateSeedRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSeedRouteDataImplCopyWith<_$CreateSeedRouteDataImpl> get copyWith =>
      __$$CreateSeedRouteDataImplCopyWithImpl<_$CreateSeedRouteDataImpl>(
          this, _$identity);
}

abstract class _CreateSeedRouteData extends CreateSeedRouteData {
  const factory _CreateSeedRouteData({required final String? seedName}) =
      _$CreateSeedRouteDataImpl;
  const _CreateSeedRouteData._() : super._();

  @override
  String? get seedName;

  /// Create a copy of CreateSeedRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateSeedRouteDataImplCopyWith<_$CreateSeedRouteDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
