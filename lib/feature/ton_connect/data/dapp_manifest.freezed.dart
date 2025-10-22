// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dapp_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DappManifest {

 String get url; String get name; String get iconUrl; String? get termsOfUseUrl; String? get privacyPolicyUrl;
/// Create a copy of DappManifest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DappManifestCopyWith<DappManifest> get copyWith => _$DappManifestCopyWithImpl<DappManifest>(this as DappManifest, _$identity);

  /// Serializes this DappManifest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DappManifest&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.termsOfUseUrl, termsOfUseUrl) || other.termsOfUseUrl == termsOfUseUrl)&&(identical(other.privacyPolicyUrl, privacyPolicyUrl) || other.privacyPolicyUrl == privacyPolicyUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,name,iconUrl,termsOfUseUrl,privacyPolicyUrl);

@override
String toString() {
  return 'DappManifest(url: $url, name: $name, iconUrl: $iconUrl, termsOfUseUrl: $termsOfUseUrl, privacyPolicyUrl: $privacyPolicyUrl)';
}


}

/// @nodoc
abstract mixin class $DappManifestCopyWith<$Res>  {
  factory $DappManifestCopyWith(DappManifest value, $Res Function(DappManifest) _then) = _$DappManifestCopyWithImpl;
@useResult
$Res call({
 String url, String name, String iconUrl, String? termsOfUseUrl, String? privacyPolicyUrl
});




}
/// @nodoc
class _$DappManifestCopyWithImpl<$Res>
    implements $DappManifestCopyWith<$Res> {
  _$DappManifestCopyWithImpl(this._self, this._then);

  final DappManifest _self;
  final $Res Function(DappManifest) _then;

/// Create a copy of DappManifest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? name = null,Object? iconUrl = null,Object? termsOfUseUrl = freezed,Object? privacyPolicyUrl = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconUrl: null == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String,termsOfUseUrl: freezed == termsOfUseUrl ? _self.termsOfUseUrl : termsOfUseUrl // ignore: cast_nullable_to_non_nullable
as String?,privacyPolicyUrl: freezed == privacyPolicyUrl ? _self.privacyPolicyUrl : privacyPolicyUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DappManifest].
extension DappManifestPatterns on DappManifest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DappManifest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DappManifest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DappManifest value)  $default,){
final _that = this;
switch (_that) {
case _DappManifest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DappManifest value)?  $default,){
final _that = this;
switch (_that) {
case _DappManifest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String name,  String iconUrl,  String? termsOfUseUrl,  String? privacyPolicyUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DappManifest() when $default != null:
return $default(_that.url,_that.name,_that.iconUrl,_that.termsOfUseUrl,_that.privacyPolicyUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String name,  String iconUrl,  String? termsOfUseUrl,  String? privacyPolicyUrl)  $default,) {final _that = this;
switch (_that) {
case _DappManifest():
return $default(_that.url,_that.name,_that.iconUrl,_that.termsOfUseUrl,_that.privacyPolicyUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String name,  String iconUrl,  String? termsOfUseUrl,  String? privacyPolicyUrl)?  $default,) {final _that = this;
switch (_that) {
case _DappManifest() when $default != null:
return $default(_that.url,_that.name,_that.iconUrl,_that.termsOfUseUrl,_that.privacyPolicyUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DappManifest implements DappManifest {
  const _DappManifest({required this.url, required this.name, required this.iconUrl, this.termsOfUseUrl, this.privacyPolicyUrl});
  factory _DappManifest.fromJson(Map<String, dynamic> json) => _$DappManifestFromJson(json);

@override final  String url;
@override final  String name;
@override final  String iconUrl;
@override final  String? termsOfUseUrl;
@override final  String? privacyPolicyUrl;

/// Create a copy of DappManifest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DappManifestCopyWith<_DappManifest> get copyWith => __$DappManifestCopyWithImpl<_DappManifest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DappManifestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DappManifest&&(identical(other.url, url) || other.url == url)&&(identical(other.name, name) || other.name == name)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.termsOfUseUrl, termsOfUseUrl) || other.termsOfUseUrl == termsOfUseUrl)&&(identical(other.privacyPolicyUrl, privacyPolicyUrl) || other.privacyPolicyUrl == privacyPolicyUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,name,iconUrl,termsOfUseUrl,privacyPolicyUrl);

@override
String toString() {
  return 'DappManifest(url: $url, name: $name, iconUrl: $iconUrl, termsOfUseUrl: $termsOfUseUrl, privacyPolicyUrl: $privacyPolicyUrl)';
}


}

/// @nodoc
abstract mixin class _$DappManifestCopyWith<$Res> implements $DappManifestCopyWith<$Res> {
  factory _$DappManifestCopyWith(_DappManifest value, $Res Function(_DappManifest) _then) = __$DappManifestCopyWithImpl;
@override @useResult
$Res call({
 String url, String name, String iconUrl, String? termsOfUseUrl, String? privacyPolicyUrl
});




}
/// @nodoc
class __$DappManifestCopyWithImpl<$Res>
    implements _$DappManifestCopyWith<$Res> {
  __$DappManifestCopyWithImpl(this._self, this._then);

  final _DappManifest _self;
  final $Res Function(_DappManifest) _then;

/// Create a copy of DappManifest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? name = null,Object? iconUrl = null,Object? termsOfUseUrl = freezed,Object? privacyPolicyUrl = freezed,}) {
  return _then(_DappManifest(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconUrl: null == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String,termsOfUseUrl: freezed == termsOfUseUrl ? _self.termsOfUseUrl : termsOfUseUrl // ignore: cast_nullable_to_non_nullable
as String?,privacyPolicyUrl: freezed == privacyPolicyUrl ? _self.privacyPolicyUrl : privacyPolicyUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
