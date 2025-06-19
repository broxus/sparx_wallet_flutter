// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConnectQuery _$ConnectQueryFromJson(Map<String, dynamic> json) {
  return _ConnectQuery.fromJson(json);
}

/// @nodoc
mixin _$ConnectQuery {
  String get v => throw _privateConstructorUsedError;
  String get r => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get ret => throw _privateConstructorUsedError;

  /// Serializes this ConnectQuery to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectQuery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectQueryCopyWith<ConnectQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectQueryCopyWith<$Res> {
  factory $ConnectQueryCopyWith(
          ConnectQuery value, $Res Function(ConnectQuery) then) =
      _$ConnectQueryCopyWithImpl<$Res, ConnectQuery>;
  @useResult
  $Res call({String v, String r, String id, String ret});
}

/// @nodoc
class _$ConnectQueryCopyWithImpl<$Res, $Val extends ConnectQuery>
    implements $ConnectQueryCopyWith<$Res> {
  _$ConnectQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectQuery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? v = null,
    Object? r = null,
    Object? id = null,
    Object? ret = null,
  }) {
    return _then(_value.copyWith(
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as String,
      r: null == r
          ? _value.r
          : r // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ret: null == ret
          ? _value.ret
          : ret // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectQueryImplCopyWith<$Res>
    implements $ConnectQueryCopyWith<$Res> {
  factory _$$ConnectQueryImplCopyWith(
          _$ConnectQueryImpl value, $Res Function(_$ConnectQueryImpl) then) =
      __$$ConnectQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String v, String r, String id, String ret});
}

/// @nodoc
class __$$ConnectQueryImplCopyWithImpl<$Res>
    extends _$ConnectQueryCopyWithImpl<$Res, _$ConnectQueryImpl>
    implements _$$ConnectQueryImplCopyWith<$Res> {
  __$$ConnectQueryImplCopyWithImpl(
      _$ConnectQueryImpl _value, $Res Function(_$ConnectQueryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectQuery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? v = null,
    Object? r = null,
    Object? id = null,
    Object? ret = null,
  }) {
    return _then(_$ConnectQueryImpl(
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as String,
      r: null == r
          ? _value.r
          : r // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ret: null == ret
          ? _value.ret
          : ret // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectQueryImpl implements _ConnectQuery {
  const _$ConnectQueryImpl(
      {required this.v, required this.r, required this.id, required this.ret});

  factory _$ConnectQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectQueryImplFromJson(json);

  @override
  final String v;
  @override
  final String r;
  @override
  final String id;
  @override
  final String ret;

  @override
  String toString() {
    return 'ConnectQuery(v: $v, r: $r, id: $id, ret: $ret)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectQueryImpl &&
            (identical(other.v, v) || other.v == v) &&
            (identical(other.r, r) || other.r == r) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ret, ret) || other.ret == ret));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, v, r, id, ret);

  /// Create a copy of ConnectQuery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectQueryImplCopyWith<_$ConnectQueryImpl> get copyWith =>
      __$$ConnectQueryImplCopyWithImpl<_$ConnectQueryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectQueryImplToJson(
      this,
    );
  }
}

abstract class _ConnectQuery implements ConnectQuery {
  const factory _ConnectQuery(
      {required final String v,
      required final String r,
      required final String id,
      required final String ret}) = _$ConnectQueryImpl;

  factory _ConnectQuery.fromJson(Map<String, dynamic> json) =
      _$ConnectQueryImpl.fromJson;

  @override
  String get v;
  @override
  String get r;
  @override
  String get id;
  @override
  String get ret;

  /// Create a copy of ConnectQuery
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectQueryImplCopyWith<_$ConnectQueryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
