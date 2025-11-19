// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CollectionMeta {

 Address get address; NetworkGroup get networkGroup; bool get isVisible;
/// Create a copy of CollectionMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionMetaCopyWith<CollectionMeta> get copyWith => _$CollectionMetaCopyWithImpl<CollectionMeta>(this as CollectionMeta, _$identity);

  /// Serializes this CollectionMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionMeta&&(identical(other.address, address) || other.address == address)&&(identical(other.networkGroup, networkGroup) || other.networkGroup == networkGroup)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,networkGroup,isVisible);

@override
String toString() {
  return 'CollectionMeta(address: $address, networkGroup: $networkGroup, isVisible: $isVisible)';
}


}

/// @nodoc
abstract mixin class $CollectionMetaCopyWith<$Res>  {
  factory $CollectionMetaCopyWith(CollectionMeta value, $Res Function(CollectionMeta) _then) = _$CollectionMetaCopyWithImpl;
@useResult
$Res call({
 Address address, NetworkGroup networkGroup, bool isVisible
});


$AddressCopyWith<$Res> get address;

}
/// @nodoc
class _$CollectionMetaCopyWithImpl<$Res>
    implements $CollectionMetaCopyWith<$Res> {
  _$CollectionMetaCopyWithImpl(this._self, this._then);

  final CollectionMeta _self;
  final $Res Function(CollectionMeta) _then;

/// Create a copy of CollectionMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? networkGroup = null,Object? isVisible = null,}) {
  return _then(_self.copyWith(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address,networkGroup: null == networkGroup ? _self.networkGroup : networkGroup // ignore: cast_nullable_to_non_nullable
as NetworkGroup,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CollectionMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get address {
  
  return $AddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [CollectionMeta].
extension CollectionMetaPatterns on CollectionMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionMeta value)  $default,){
final _that = this;
switch (_that) {
case _CollectionMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionMeta value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Address address,  NetworkGroup networkGroup,  bool isVisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionMeta() when $default != null:
return $default(_that.address,_that.networkGroup,_that.isVisible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Address address,  NetworkGroup networkGroup,  bool isVisible)  $default,) {final _that = this;
switch (_that) {
case _CollectionMeta():
return $default(_that.address,_that.networkGroup,_that.isVisible);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Address address,  NetworkGroup networkGroup,  bool isVisible)?  $default,) {final _that = this;
switch (_that) {
case _CollectionMeta() when $default != null:
return $default(_that.address,_that.networkGroup,_that.isVisible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectionMeta implements CollectionMeta {
  const _CollectionMeta({required this.address, required this.networkGroup, this.isVisible = true});
  factory _CollectionMeta.fromJson(Map<String, dynamic> json) => _$CollectionMetaFromJson(json);

@override final  Address address;
@override final  NetworkGroup networkGroup;
@override@JsonKey() final  bool isVisible;

/// Create a copy of CollectionMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionMetaCopyWith<_CollectionMeta> get copyWith => __$CollectionMetaCopyWithImpl<_CollectionMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectionMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionMeta&&(identical(other.address, address) || other.address == address)&&(identical(other.networkGroup, networkGroup) || other.networkGroup == networkGroup)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,networkGroup,isVisible);

@override
String toString() {
  return 'CollectionMeta(address: $address, networkGroup: $networkGroup, isVisible: $isVisible)';
}


}

/// @nodoc
abstract mixin class _$CollectionMetaCopyWith<$Res> implements $CollectionMetaCopyWith<$Res> {
  factory _$CollectionMetaCopyWith(_CollectionMeta value, $Res Function(_CollectionMeta) _then) = __$CollectionMetaCopyWithImpl;
@override @useResult
$Res call({
 Address address, NetworkGroup networkGroup, bool isVisible
});


@override $AddressCopyWith<$Res> get address;

}
/// @nodoc
class __$CollectionMetaCopyWithImpl<$Res>
    implements _$CollectionMetaCopyWith<$Res> {
  __$CollectionMetaCopyWithImpl(this._self, this._then);

  final _CollectionMeta _self;
  final $Res Function(_CollectionMeta) _then;

/// Create a copy of CollectionMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? networkGroup = null,Object? isVisible = null,}) {
  return _then(_CollectionMeta(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address,networkGroup: null == networkGroup ? _self.networkGroup : networkGroup // ignore: cast_nullable_to_non_nullable
as NetworkGroup,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CollectionMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get address {
  
  return $AddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}

// dart format on
