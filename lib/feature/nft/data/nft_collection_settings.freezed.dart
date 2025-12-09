// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nft_collection_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NftCollectionSettings {

 Address get collection; NetworkGroup get networkGroup; bool get isVisible;
/// Create a copy of NftCollectionSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NftCollectionSettingsCopyWith<NftCollectionSettings> get copyWith => _$NftCollectionSettingsCopyWithImpl<NftCollectionSettings>(this as NftCollectionSettings, _$identity);

  /// Serializes this NftCollectionSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NftCollectionSettings&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.networkGroup, networkGroup) || other.networkGroup == networkGroup)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,collection,networkGroup,isVisible);

@override
String toString() {
  return 'NftCollectionSettings(collection: $collection, networkGroup: $networkGroup, isVisible: $isVisible)';
}


}

/// @nodoc
abstract mixin class $NftCollectionSettingsCopyWith<$Res>  {
  factory $NftCollectionSettingsCopyWith(NftCollectionSettings value, $Res Function(NftCollectionSettings) _then) = _$NftCollectionSettingsCopyWithImpl;
@useResult
$Res call({
 Address collection, NetworkGroup networkGroup, bool isVisible
});


$AddressCopyWith<$Res> get collection;

}
/// @nodoc
class _$NftCollectionSettingsCopyWithImpl<$Res>
    implements $NftCollectionSettingsCopyWith<$Res> {
  _$NftCollectionSettingsCopyWithImpl(this._self, this._then);

  final NftCollectionSettings _self;
  final $Res Function(NftCollectionSettings) _then;

/// Create a copy of NftCollectionSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? collection = null,Object? networkGroup = null,Object? isVisible = null,}) {
  return _then(_self.copyWith(
collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as Address,networkGroup: null == networkGroup ? _self.networkGroup : networkGroup // ignore: cast_nullable_to_non_nullable
as NetworkGroup,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of NftCollectionSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get collection {
  
  return $AddressCopyWith<$Res>(_self.collection, (value) {
    return _then(_self.copyWith(collection: value));
  });
}
}


/// Adds pattern-matching-related methods to [NftCollectionSettings].
extension NftCollectionSettingsPatterns on NftCollectionSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NftCollectionSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NftCollectionSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NftCollectionSettings value)  $default,){
final _that = this;
switch (_that) {
case _NftCollectionSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NftCollectionSettings value)?  $default,){
final _that = this;
switch (_that) {
case _NftCollectionSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Address collection,  NetworkGroup networkGroup,  bool isVisible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NftCollectionSettings() when $default != null:
return $default(_that.collection,_that.networkGroup,_that.isVisible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Address collection,  NetworkGroup networkGroup,  bool isVisible)  $default,) {final _that = this;
switch (_that) {
case _NftCollectionSettings():
return $default(_that.collection,_that.networkGroup,_that.isVisible);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Address collection,  NetworkGroup networkGroup,  bool isVisible)?  $default,) {final _that = this;
switch (_that) {
case _NftCollectionSettings() when $default != null:
return $default(_that.collection,_that.networkGroup,_that.isVisible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NftCollectionSettings implements NftCollectionSettings {
  const _NftCollectionSettings({required this.collection, required this.networkGroup, this.isVisible = true});
  factory _NftCollectionSettings.fromJson(Map<String, dynamic> json) => _$NftCollectionSettingsFromJson(json);

@override final  Address collection;
@override final  NetworkGroup networkGroup;
@override@JsonKey() final  bool isVisible;

/// Create a copy of NftCollectionSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NftCollectionSettingsCopyWith<_NftCollectionSettings> get copyWith => __$NftCollectionSettingsCopyWithImpl<_NftCollectionSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NftCollectionSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NftCollectionSettings&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.networkGroup, networkGroup) || other.networkGroup == networkGroup)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,collection,networkGroup,isVisible);

@override
String toString() {
  return 'NftCollectionSettings(collection: $collection, networkGroup: $networkGroup, isVisible: $isVisible)';
}


}

/// @nodoc
abstract mixin class _$NftCollectionSettingsCopyWith<$Res> implements $NftCollectionSettingsCopyWith<$Res> {
  factory _$NftCollectionSettingsCopyWith(_NftCollectionSettings value, $Res Function(_NftCollectionSettings) _then) = __$NftCollectionSettingsCopyWithImpl;
@override @useResult
$Res call({
 Address collection, NetworkGroup networkGroup, bool isVisible
});


@override $AddressCopyWith<$Res> get collection;

}
/// @nodoc
class __$NftCollectionSettingsCopyWithImpl<$Res>
    implements _$NftCollectionSettingsCopyWith<$Res> {
  __$NftCollectionSettingsCopyWithImpl(this._self, this._then);

  final _NftCollectionSettings _self;
  final $Res Function(_NftCollectionSettings) _then;

/// Create a copy of NftCollectionSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? collection = null,Object? networkGroup = null,Object? isVisible = null,}) {
  return _then(_NftCollectionSettings(
collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as Address,networkGroup: null == networkGroup ? _self.networkGroup : networkGroup // ignore: cast_nullable_to_non_nullable
as NetworkGroup,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of NftCollectionSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get collection {
  
  return $AddressCopyWith<$Res>(_self.collection, (value) {
    return _then(_self.copyWith(collection: value));
  });
}
}

// dart format on
