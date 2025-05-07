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
mixin _$EditNetworkRouteData {
  /// ID of the connection to edit, null for new connection
  String? get connectionDataId => throw _privateConstructorUsedError;

  /// Create a copy of EditNetworkRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditNetworkRouteDataCopyWith<EditNetworkRouteData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditNetworkRouteDataCopyWith<$Res> {
  factory $EditNetworkRouteDataCopyWith(EditNetworkRouteData value,
          $Res Function(EditNetworkRouteData) then) =
      _$EditNetworkRouteDataCopyWithImpl<$Res, EditNetworkRouteData>;
  @useResult
  $Res call({String? connectionDataId});
}

/// @nodoc
class _$EditNetworkRouteDataCopyWithImpl<$Res,
        $Val extends EditNetworkRouteData>
    implements $EditNetworkRouteDataCopyWith<$Res> {
  _$EditNetworkRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditNetworkRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connectionDataId = freezed,
  }) {
    return _then(_value.copyWith(
      connectionDataId: freezed == connectionDataId
          ? _value.connectionDataId
          : connectionDataId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditNetworkRouteDataImplCopyWith<$Res>
    implements $EditNetworkRouteDataCopyWith<$Res> {
  factory _$$EditNetworkRouteDataImplCopyWith(_$EditNetworkRouteDataImpl value,
          $Res Function(_$EditNetworkRouteDataImpl) then) =
      __$$EditNetworkRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? connectionDataId});
}

/// @nodoc
class __$$EditNetworkRouteDataImplCopyWithImpl<$Res>
    extends _$EditNetworkRouteDataCopyWithImpl<$Res, _$EditNetworkRouteDataImpl>
    implements _$$EditNetworkRouteDataImplCopyWith<$Res> {
  __$$EditNetworkRouteDataImplCopyWithImpl(_$EditNetworkRouteDataImpl _value,
      $Res Function(_$EditNetworkRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditNetworkRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connectionDataId = freezed,
  }) {
    return _then(_$EditNetworkRouteDataImpl(
      connectionDataId: freezed == connectionDataId
          ? _value.connectionDataId
          : connectionDataId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$EditNetworkRouteDataImpl extends _EditNetworkRouteData {
  const _$EditNetworkRouteDataImpl({this.connectionDataId}) : super._();

  /// ID of the connection to edit, null for new connection
  @override
  final String? connectionDataId;

  @override
  String toString() {
    return 'EditNetworkRouteData(connectionDataId: $connectionDataId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditNetworkRouteDataImpl &&
            (identical(other.connectionDataId, connectionDataId) ||
                other.connectionDataId == connectionDataId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connectionDataId);

  /// Create a copy of EditNetworkRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditNetworkRouteDataImplCopyWith<_$EditNetworkRouteDataImpl>
      get copyWith =>
          __$$EditNetworkRouteDataImplCopyWithImpl<_$EditNetworkRouteDataImpl>(
              this, _$identity);
}

abstract class _EditNetworkRouteData extends EditNetworkRouteData {
  const factory _EditNetworkRouteData({final String? connectionDataId}) =
      _$EditNetworkRouteDataImpl;
  const _EditNetworkRouteData._() : super._();

  /// ID of the connection to edit, null for new connection
  @override
  String? get connectionDataId;

  /// Create a copy of EditNetworkRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditNetworkRouteDataImplCopyWith<_$EditNetworkRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
