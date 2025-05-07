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
mixin _$CustodiansSettingsRouteData {
  List<String> get custodians => throw _privateConstructorUsedError;

  /// Create a copy of CustodiansSettingsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustodiansSettingsRouteDataCopyWith<CustodiansSettingsRouteData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustodiansSettingsRouteDataCopyWith<$Res> {
  factory $CustodiansSettingsRouteDataCopyWith(
          CustodiansSettingsRouteData value,
          $Res Function(CustodiansSettingsRouteData) then) =
      _$CustodiansSettingsRouteDataCopyWithImpl<$Res,
          CustodiansSettingsRouteData>;
  @useResult
  $Res call({List<String> custodians});
}

/// @nodoc
class _$CustodiansSettingsRouteDataCopyWithImpl<$Res,
        $Val extends CustodiansSettingsRouteData>
    implements $CustodiansSettingsRouteDataCopyWith<$Res> {
  _$CustodiansSettingsRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustodiansSettingsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? custodians = null,
  }) {
    return _then(_value.copyWith(
      custodians: null == custodians
          ? _value.custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustodiansSettingsRouteDataImplCopyWith<$Res>
    implements $CustodiansSettingsRouteDataCopyWith<$Res> {
  factory _$$CustodiansSettingsRouteDataImplCopyWith(
          _$CustodiansSettingsRouteDataImpl value,
          $Res Function(_$CustodiansSettingsRouteDataImpl) then) =
      __$$CustodiansSettingsRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> custodians});
}

/// @nodoc
class __$$CustodiansSettingsRouteDataImplCopyWithImpl<$Res>
    extends _$CustodiansSettingsRouteDataCopyWithImpl<$Res,
        _$CustodiansSettingsRouteDataImpl>
    implements _$$CustodiansSettingsRouteDataImplCopyWith<$Res> {
  __$$CustodiansSettingsRouteDataImplCopyWithImpl(
      _$CustodiansSettingsRouteDataImpl _value,
      $Res Function(_$CustodiansSettingsRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustodiansSettingsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? custodians = null,
  }) {
    return _then(_$CustodiansSettingsRouteDataImpl(
      custodians: null == custodians
          ? _value._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$CustodiansSettingsRouteDataImpl extends _CustodiansSettingsRouteData {
  const _$CustodiansSettingsRouteDataImpl(
      {required final List<String> custodians})
      : _custodians = custodians,
        super._();

  final List<String> _custodians;
  @override
  List<String> get custodians {
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_custodians);
  }

  @override
  String toString() {
    return 'CustodiansSettingsRouteData(custodians: $custodians)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustodiansSettingsRouteDataImpl &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_custodians));

  /// Create a copy of CustodiansSettingsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustodiansSettingsRouteDataImplCopyWith<_$CustodiansSettingsRouteDataImpl>
      get copyWith => __$$CustodiansSettingsRouteDataImplCopyWithImpl<
          _$CustodiansSettingsRouteDataImpl>(this, _$identity);
}

abstract class _CustodiansSettingsRouteData
    extends CustodiansSettingsRouteData {
  const factory _CustodiansSettingsRouteData(
          {required final List<String> custodians}) =
      _$CustodiansSettingsRouteDataImpl;
  const _CustodiansSettingsRouteData._() : super._();

  @override
  List<String> get custodians;

  /// Create a copy of CustodiansSettingsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustodiansSettingsRouteDataImplCopyWith<_$CustodiansSettingsRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
