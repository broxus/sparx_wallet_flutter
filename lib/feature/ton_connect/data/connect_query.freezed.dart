// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectQuery {
  String get v;
  String get r;
  String get id;
  String get ret;

  /// Create a copy of ConnectQuery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectQueryCopyWith<ConnectQuery> get copyWith =>
      _$ConnectQueryCopyWithImpl<ConnectQuery>(
          this as ConnectQuery, _$identity);

  /// Serializes this ConnectQuery to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectQuery &&
            (identical(other.v, v) || other.v == v) &&
            (identical(other.r, r) || other.r == r) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ret, ret) || other.ret == ret));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, v, r, id, ret);

  @override
  String toString() {
    return 'ConnectQuery(v: $v, r: $r, id: $id, ret: $ret)';
  }
}

/// @nodoc
abstract mixin class $ConnectQueryCopyWith<$Res> {
  factory $ConnectQueryCopyWith(
          ConnectQuery value, $Res Function(ConnectQuery) _then) =
      _$ConnectQueryCopyWithImpl;
  @useResult
  $Res call({String v, String r, String id, String ret});
}

/// @nodoc
class _$ConnectQueryCopyWithImpl<$Res> implements $ConnectQueryCopyWith<$Res> {
  _$ConnectQueryCopyWithImpl(this._self, this._then);

  final ConnectQuery _self;
  final $Res Function(ConnectQuery) _then;

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
    return _then(_self.copyWith(
      v: null == v
          ? _self.v
          : v // ignore: cast_nullable_to_non_nullable
              as String,
      r: null == r
          ? _self.r
          : r // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ret: null == ret
          ? _self.ret
          : ret // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ConnectQuery implements ConnectQuery {
  const _ConnectQuery(
      {required this.v, required this.r, required this.id, required this.ret});
  factory _ConnectQuery.fromJson(Map<String, dynamic> json) =>
      _$ConnectQueryFromJson(json);

  @override
  final String v;
  @override
  final String r;
  @override
  final String id;
  @override
  final String ret;

  /// Create a copy of ConnectQuery
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectQueryCopyWith<_ConnectQuery> get copyWith =>
      __$ConnectQueryCopyWithImpl<_ConnectQuery>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectQueryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectQuery &&
            (identical(other.v, v) || other.v == v) &&
            (identical(other.r, r) || other.r == r) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ret, ret) || other.ret == ret));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, v, r, id, ret);

  @override
  String toString() {
    return 'ConnectQuery(v: $v, r: $r, id: $id, ret: $ret)';
  }
}

/// @nodoc
abstract mixin class _$ConnectQueryCopyWith<$Res>
    implements $ConnectQueryCopyWith<$Res> {
  factory _$ConnectQueryCopyWith(
          _ConnectQuery value, $Res Function(_ConnectQuery) _then) =
      __$ConnectQueryCopyWithImpl;
  @override
  @useResult
  $Res call({String v, String r, String id, String ret});
}

/// @nodoc
class __$ConnectQueryCopyWithImpl<$Res>
    implements _$ConnectQueryCopyWith<$Res> {
  __$ConnectQueryCopyWithImpl(this._self, this._then);

  final _ConnectQuery _self;
  final $Res Function(_ConnectQuery) _then;

  /// Create a copy of ConnectQuery
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? v = null,
    Object? r = null,
    Object? id = null,
    Object? ret = null,
  }) {
    return _then(_ConnectQuery(
      v: null == v
          ? _self.v
          : v // ignore: cast_nullable_to_non_nullable
              as String,
      r: null == r
          ? _self.r
          : r // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ret: null == ret
          ? _self.ret
          : ret // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
