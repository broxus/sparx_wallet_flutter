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
mixin _$EnterSeedNameRouteData {
  EnterSeedNameCommand get command => throw _privateConstructorUsedError;

  /// Create a copy of EnterSeedNameRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnterSeedNameRouteDataCopyWith<EnterSeedNameRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnterSeedNameRouteDataCopyWith<$Res> {
  factory $EnterSeedNameRouteDataCopyWith(EnterSeedNameRouteData value,
          $Res Function(EnterSeedNameRouteData) then) =
      _$EnterSeedNameRouteDataCopyWithImpl<$Res, EnterSeedNameRouteData>;
  @useResult
  $Res call({EnterSeedNameCommand command});
}

/// @nodoc
class _$EnterSeedNameRouteDataCopyWithImpl<$Res,
        $Val extends EnterSeedNameRouteData>
    implements $EnterSeedNameRouteDataCopyWith<$Res> {
  _$EnterSeedNameRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnterSeedNameRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
  }) {
    return _then(_value.copyWith(
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as EnterSeedNameCommand,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnterSeedNameRouteDataImplCopyWith<$Res>
    implements $EnterSeedNameRouteDataCopyWith<$Res> {
  factory _$$EnterSeedNameRouteDataImplCopyWith(
          _$EnterSeedNameRouteDataImpl value,
          $Res Function(_$EnterSeedNameRouteDataImpl) then) =
      __$$EnterSeedNameRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EnterSeedNameCommand command});
}

/// @nodoc
class __$$EnterSeedNameRouteDataImplCopyWithImpl<$Res>
    extends _$EnterSeedNameRouteDataCopyWithImpl<$Res,
        _$EnterSeedNameRouteDataImpl>
    implements _$$EnterSeedNameRouteDataImplCopyWith<$Res> {
  __$$EnterSeedNameRouteDataImplCopyWithImpl(
      _$EnterSeedNameRouteDataImpl _value,
      $Res Function(_$EnterSeedNameRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnterSeedNameRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? command = null,
  }) {
    return _then(_$EnterSeedNameRouteDataImpl(
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as EnterSeedNameCommand,
    ));
  }
}

/// @nodoc

class _$EnterSeedNameRouteDataImpl extends _EnterSeedNameRouteData {
  const _$EnterSeedNameRouteDataImpl({required this.command}) : super._();

  @override
  final EnterSeedNameCommand command;

  @override
  String toString() {
    return 'EnterSeedNameRouteData(command: $command)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnterSeedNameRouteDataImpl &&
            (identical(other.command, command) || other.command == command));
  }

  @override
  int get hashCode => Object.hash(runtimeType, command);

  /// Create a copy of EnterSeedNameRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnterSeedNameRouteDataImplCopyWith<_$EnterSeedNameRouteDataImpl>
      get copyWith => __$$EnterSeedNameRouteDataImplCopyWithImpl<
          _$EnterSeedNameRouteDataImpl>(this, _$identity);
}

abstract class _EnterSeedNameRouteData extends EnterSeedNameRouteData {
  const factory _EnterSeedNameRouteData(
          {required final EnterSeedNameCommand command}) =
      _$EnterSeedNameRouteDataImpl;
  const _EnterSeedNameRouteData._() : super._();

  @override
  EnterSeedNameCommand get command;

  /// Create a copy of EnterSeedNameRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnterSeedNameRouteDataImplCopyWith<_$EnterSeedNameRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
