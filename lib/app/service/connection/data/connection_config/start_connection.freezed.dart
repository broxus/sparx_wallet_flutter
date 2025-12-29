// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StartConnectionData {

 String get connectionId;
/// Create a copy of StartConnectionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartConnectionDataCopyWith<StartConnectionData> get copyWith => _$StartConnectionDataCopyWithImpl<StartConnectionData>(this as StartConnectionData, _$identity);

  /// Serializes this StartConnectionData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartConnectionData&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,connectionId);

@override
String toString() {
  return 'StartConnectionData(connectionId: $connectionId)';
}


}

/// @nodoc
abstract mixin class $StartConnectionDataCopyWith<$Res>  {
  factory $StartConnectionDataCopyWith(StartConnectionData value, $Res Function(StartConnectionData) _then) = _$StartConnectionDataCopyWithImpl;
@useResult
$Res call({
 String connectionId
});




}
/// @nodoc
class _$StartConnectionDataCopyWithImpl<$Res>
    implements $StartConnectionDataCopyWith<$Res> {
  _$StartConnectionDataCopyWithImpl(this._self, this._then);

  final StartConnectionData _self;
  final $Res Function(StartConnectionData) _then;

/// Create a copy of StartConnectionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? connectionId = null,}) {
  return _then(_self.copyWith(
connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StartConnectionData].
extension StartConnectionDataPatterns on StartConnectionData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StartConnectionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StartConnectionData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StartConnectionData value)  $default,){
final _that = this;
switch (_that) {
case _StartConnectionData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StartConnectionData value)?  $default,){
final _that = this;
switch (_that) {
case _StartConnectionData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String connectionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StartConnectionData() when $default != null:
return $default(_that.connectionId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String connectionId)  $default,) {final _that = this;
switch (_that) {
case _StartConnectionData():
return $default(_that.connectionId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String connectionId)?  $default,) {final _that = this;
switch (_that) {
case _StartConnectionData() when $default != null:
return $default(_that.connectionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StartConnectionData implements StartConnectionData {
  const _StartConnectionData({required this.connectionId});
  factory _StartConnectionData.fromJson(Map<String, dynamic> json) => _$StartConnectionDataFromJson(json);

@override final  String connectionId;

/// Create a copy of StartConnectionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartConnectionDataCopyWith<_StartConnectionData> get copyWith => __$StartConnectionDataCopyWithImpl<_StartConnectionData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StartConnectionDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartConnectionData&&(identical(other.connectionId, connectionId) || other.connectionId == connectionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,connectionId);

@override
String toString() {
  return 'StartConnectionData(connectionId: $connectionId)';
}


}

/// @nodoc
abstract mixin class _$StartConnectionDataCopyWith<$Res> implements $StartConnectionDataCopyWith<$Res> {
  factory _$StartConnectionDataCopyWith(_StartConnectionData value, $Res Function(_StartConnectionData) _then) = __$StartConnectionDataCopyWithImpl;
@override @useResult
$Res call({
 String connectionId
});




}
/// @nodoc
class __$StartConnectionDataCopyWithImpl<$Res>
    implements _$StartConnectionDataCopyWith<$Res> {
  __$StartConnectionDataCopyWithImpl(this._self, this._then);

  final _StartConnectionData _self;
  final $Res Function(_StartConnectionData) _then;

/// Create a copy of StartConnectionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? connectionId = null,}) {
  return _then(_StartConnectionData(
connectionId: null == connectionId ? _self.connectionId : connectionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
