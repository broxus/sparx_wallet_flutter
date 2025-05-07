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
mixin _$BootstrapFailedRouteData {
  /// Bootstrap step that failed
  BootstrapSteps get step => throw _privateConstructorUsedError;

  /// Create a copy of BootstrapFailedRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BootstrapFailedRouteDataCopyWith<BootstrapFailedRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BootstrapFailedRouteDataCopyWith<$Res> {
  factory $BootstrapFailedRouteDataCopyWith(BootstrapFailedRouteData value,
          $Res Function(BootstrapFailedRouteData) then) =
      _$BootstrapFailedRouteDataCopyWithImpl<$Res, BootstrapFailedRouteData>;
  @useResult
  $Res call({BootstrapSteps step});
}

/// @nodoc
class _$BootstrapFailedRouteDataCopyWithImpl<$Res,
        $Val extends BootstrapFailedRouteData>
    implements $BootstrapFailedRouteDataCopyWith<$Res> {
  _$BootstrapFailedRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BootstrapFailedRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
  }) {
    return _then(_value.copyWith(
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as BootstrapSteps,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BootstrapFailedRouteDataImplCopyWith<$Res>
    implements $BootstrapFailedRouteDataCopyWith<$Res> {
  factory _$$BootstrapFailedRouteDataImplCopyWith(
          _$BootstrapFailedRouteDataImpl value,
          $Res Function(_$BootstrapFailedRouteDataImpl) then) =
      __$$BootstrapFailedRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BootstrapSteps step});
}

/// @nodoc
class __$$BootstrapFailedRouteDataImplCopyWithImpl<$Res>
    extends _$BootstrapFailedRouteDataCopyWithImpl<$Res,
        _$BootstrapFailedRouteDataImpl>
    implements _$$BootstrapFailedRouteDataImplCopyWith<$Res> {
  __$$BootstrapFailedRouteDataImplCopyWithImpl(
      _$BootstrapFailedRouteDataImpl _value,
      $Res Function(_$BootstrapFailedRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of BootstrapFailedRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
  }) {
    return _then(_$BootstrapFailedRouteDataImpl(
      step: null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as BootstrapSteps,
    ));
  }
}

/// @nodoc

class _$BootstrapFailedRouteDataImpl extends _BootstrapFailedRouteData {
  const _$BootstrapFailedRouteDataImpl({required this.step}) : super._();

  /// Bootstrap step that failed
  @override
  final BootstrapSteps step;

  @override
  String toString() {
    return 'BootstrapFailedRouteData(step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BootstrapFailedRouteDataImpl &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, step);

  /// Create a copy of BootstrapFailedRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BootstrapFailedRouteDataImplCopyWith<_$BootstrapFailedRouteDataImpl>
      get copyWith => __$$BootstrapFailedRouteDataImplCopyWithImpl<
          _$BootstrapFailedRouteDataImpl>(this, _$identity);
}

abstract class _BootstrapFailedRouteData extends BootstrapFailedRouteData {
  const factory _BootstrapFailedRouteData(
      {required final BootstrapSteps step}) = _$BootstrapFailedRouteDataImpl;
  const _BootstrapFailedRouteData._() : super._();

  /// Bootstrap step that failed
  @override
  BootstrapSteps get step;

  /// Create a copy of BootstrapFailedRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BootstrapFailedRouteDataImplCopyWith<_$BootstrapFailedRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
