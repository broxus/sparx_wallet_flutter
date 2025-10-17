// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_type_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssetTypeParams {

 String get rootContract;
/// Create a copy of AssetTypeParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetTypeParamsCopyWith<AssetTypeParams> get copyWith => _$AssetTypeParamsCopyWithImpl<AssetTypeParams>(this as AssetTypeParams, _$identity);

  /// Serializes this AssetTypeParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetTypeParams&&(identical(other.rootContract, rootContract) || other.rootContract == rootContract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rootContract);

@override
String toString() {
  return 'AssetTypeParams(rootContract: $rootContract)';
}


}

/// @nodoc
abstract mixin class $AssetTypeParamsCopyWith<$Res>  {
  factory $AssetTypeParamsCopyWith(AssetTypeParams value, $Res Function(AssetTypeParams) _then) = _$AssetTypeParamsCopyWithImpl;
@useResult
$Res call({
 String rootContract
});




}
/// @nodoc
class _$AssetTypeParamsCopyWithImpl<$Res>
    implements $AssetTypeParamsCopyWith<$Res> {
  _$AssetTypeParamsCopyWithImpl(this._self, this._then);

  final AssetTypeParams _self;
  final $Res Function(AssetTypeParams) _then;

/// Create a copy of AssetTypeParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rootContract = null,}) {
  return _then(_self.copyWith(
rootContract: null == rootContract ? _self.rootContract : rootContract // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetTypeParams].
extension AssetTypeParamsPatterns on AssetTypeParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetTypeParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetTypeParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetTypeParams value)  $default,){
final _that = this;
switch (_that) {
case _AssetTypeParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetTypeParams value)?  $default,){
final _that = this;
switch (_that) {
case _AssetTypeParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rootContract)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetTypeParams() when $default != null:
return $default(_that.rootContract);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rootContract)  $default,) {final _that = this;
switch (_that) {
case _AssetTypeParams():
return $default(_that.rootContract);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rootContract)?  $default,) {final _that = this;
switch (_that) {
case _AssetTypeParams() when $default != null:
return $default(_that.rootContract);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetTypeParams implements AssetTypeParams {
  const _AssetTypeParams({required this.rootContract});
  factory _AssetTypeParams.fromJson(Map<String, dynamic> json) => _$AssetTypeParamsFromJson(json);

@override final  String rootContract;

/// Create a copy of AssetTypeParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetTypeParamsCopyWith<_AssetTypeParams> get copyWith => __$AssetTypeParamsCopyWithImpl<_AssetTypeParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetTypeParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetTypeParams&&(identical(other.rootContract, rootContract) || other.rootContract == rootContract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rootContract);

@override
String toString() {
  return 'AssetTypeParams(rootContract: $rootContract)';
}


}

/// @nodoc
abstract mixin class _$AssetTypeParamsCopyWith<$Res> implements $AssetTypeParamsCopyWith<$Res> {
  factory _$AssetTypeParamsCopyWith(_AssetTypeParams value, $Res Function(_AssetTypeParams) _then) = __$AssetTypeParamsCopyWithImpl;
@override @useResult
$Res call({
 String rootContract
});




}
/// @nodoc
class __$AssetTypeParamsCopyWithImpl<$Res>
    implements _$AssetTypeParamsCopyWith<$Res> {
  __$AssetTypeParamsCopyWithImpl(this._self, this._then);

  final _AssetTypeParams _self;
  final $Res Function(_AssetTypeParams) _then;

/// Create a copy of AssetTypeParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rootContract = null,}) {
  return _then(_AssetTypeParams(
rootContract: null == rootContract ? _self.rootContract : rootContract // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
