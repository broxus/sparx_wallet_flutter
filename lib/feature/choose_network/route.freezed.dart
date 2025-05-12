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
mixin _$ChooseNetworkRouteData {
  ChooseNetworkNextStep get nextStep => throw _privateConstructorUsedError;

  /// Create a copy of ChooseNetworkRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChooseNetworkRouteDataCopyWith<ChooseNetworkRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChooseNetworkRouteDataCopyWith<$Res> {
  factory $ChooseNetworkRouteDataCopyWith(ChooseNetworkRouteData value,
          $Res Function(ChooseNetworkRouteData) then) =
      _$ChooseNetworkRouteDataCopyWithImpl<$Res, ChooseNetworkRouteData>;
  @useResult
  $Res call({ChooseNetworkNextStep nextStep});
}

/// @nodoc
class _$ChooseNetworkRouteDataCopyWithImpl<$Res,
        $Val extends ChooseNetworkRouteData>
    implements $ChooseNetworkRouteDataCopyWith<$Res> {
  _$ChooseNetworkRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChooseNetworkRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextStep = null,
  }) {
    return _then(_value.copyWith(
      nextStep: null == nextStep
          ? _value.nextStep
          : nextStep // ignore: cast_nullable_to_non_nullable
              as ChooseNetworkNextStep,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChooseNetworkRouteDataImplCopyWith<$Res>
    implements $ChooseNetworkRouteDataCopyWith<$Res> {
  factory _$$ChooseNetworkRouteDataImplCopyWith(
          _$ChooseNetworkRouteDataImpl value,
          $Res Function(_$ChooseNetworkRouteDataImpl) then) =
      __$$ChooseNetworkRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChooseNetworkNextStep nextStep});
}

/// @nodoc
class __$$ChooseNetworkRouteDataImplCopyWithImpl<$Res>
    extends _$ChooseNetworkRouteDataCopyWithImpl<$Res,
        _$ChooseNetworkRouteDataImpl>
    implements _$$ChooseNetworkRouteDataImplCopyWith<$Res> {
  __$$ChooseNetworkRouteDataImplCopyWithImpl(
      _$ChooseNetworkRouteDataImpl _value,
      $Res Function(_$ChooseNetworkRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChooseNetworkRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nextStep = null,
  }) {
    return _then(_$ChooseNetworkRouteDataImpl(
      nextStep: null == nextStep
          ? _value.nextStep
          : nextStep // ignore: cast_nullable_to_non_nullable
              as ChooseNetworkNextStep,
    ));
  }
}

/// @nodoc

class _$ChooseNetworkRouteDataImpl extends _ChooseNetworkRouteData {
  const _$ChooseNetworkRouteDataImpl({required this.nextStep}) : super._();

  @override
  final ChooseNetworkNextStep nextStep;

  @override
  String toString() {
    return 'ChooseNetworkRouteData(nextStep: $nextStep)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChooseNetworkRouteDataImpl &&
            (identical(other.nextStep, nextStep) ||
                other.nextStep == nextStep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nextStep);

  /// Create a copy of ChooseNetworkRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChooseNetworkRouteDataImplCopyWith<_$ChooseNetworkRouteDataImpl>
      get copyWith => __$$ChooseNetworkRouteDataImplCopyWithImpl<
          _$ChooseNetworkRouteDataImpl>(this, _$identity);
}

abstract class _ChooseNetworkRouteData extends ChooseNetworkRouteData {
  const factory _ChooseNetworkRouteData(
          {required final ChooseNetworkNextStep nextStep}) =
      _$ChooseNetworkRouteDataImpl;
  const _ChooseNetworkRouteData._() : super._();

  @override
  ChooseNetworkNextStep get nextStep;

  /// Create a copy of ChooseNetworkRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChooseNetworkRouteDataImplCopyWith<_$ChooseNetworkRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
