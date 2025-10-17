// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nft_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NftInformation {

 String? get marketplaceUrl; List<Address>? get defaultCollections;
/// Create a copy of NftInformation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NftInformationCopyWith<NftInformation> get copyWith => _$NftInformationCopyWithImpl<NftInformation>(this as NftInformation, _$identity);

  /// Serializes this NftInformation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NftInformation&&(identical(other.marketplaceUrl, marketplaceUrl) || other.marketplaceUrl == marketplaceUrl)&&const DeepCollectionEquality().equals(other.defaultCollections, defaultCollections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,marketplaceUrl,const DeepCollectionEquality().hash(defaultCollections));

@override
String toString() {
  return 'NftInformation(marketplaceUrl: $marketplaceUrl, defaultCollections: $defaultCollections)';
}


}

/// @nodoc
abstract mixin class $NftInformationCopyWith<$Res>  {
  factory $NftInformationCopyWith(NftInformation value, $Res Function(NftInformation) _then) = _$NftInformationCopyWithImpl;
@useResult
$Res call({
 String? marketplaceUrl, List<Address>? defaultCollections
});




}
/// @nodoc
class _$NftInformationCopyWithImpl<$Res>
    implements $NftInformationCopyWith<$Res> {
  _$NftInformationCopyWithImpl(this._self, this._then);

  final NftInformation _self;
  final $Res Function(NftInformation) _then;

/// Create a copy of NftInformation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? marketplaceUrl = freezed,Object? defaultCollections = freezed,}) {
  return _then(_self.copyWith(
marketplaceUrl: freezed == marketplaceUrl ? _self.marketplaceUrl : marketplaceUrl // ignore: cast_nullable_to_non_nullable
as String?,defaultCollections: freezed == defaultCollections ? _self.defaultCollections : defaultCollections // ignore: cast_nullable_to_non_nullable
as List<Address>?,
  ));
}

}


/// Adds pattern-matching-related methods to [NftInformation].
extension NftInformationPatterns on NftInformation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NftInformation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NftInformation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NftInformation value)  $default,){
final _that = this;
switch (_that) {
case _NftInformation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NftInformation value)?  $default,){
final _that = this;
switch (_that) {
case _NftInformation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? marketplaceUrl,  List<Address>? defaultCollections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NftInformation() when $default != null:
return $default(_that.marketplaceUrl,_that.defaultCollections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? marketplaceUrl,  List<Address>? defaultCollections)  $default,) {final _that = this;
switch (_that) {
case _NftInformation():
return $default(_that.marketplaceUrl,_that.defaultCollections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? marketplaceUrl,  List<Address>? defaultCollections)?  $default,) {final _that = this;
switch (_that) {
case _NftInformation() when $default != null:
return $default(_that.marketplaceUrl,_that.defaultCollections);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NftInformation implements NftInformation {
  const _NftInformation({this.marketplaceUrl, final  List<Address>? defaultCollections}): _defaultCollections = defaultCollections;
  factory _NftInformation.fromJson(Map<String, dynamic> json) => _$NftInformationFromJson(json);

@override final  String? marketplaceUrl;
 final  List<Address>? _defaultCollections;
@override List<Address>? get defaultCollections {
  final value = _defaultCollections;
  if (value == null) return null;
  if (_defaultCollections is EqualUnmodifiableListView) return _defaultCollections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of NftInformation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NftInformationCopyWith<_NftInformation> get copyWith => __$NftInformationCopyWithImpl<_NftInformation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NftInformationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NftInformation&&(identical(other.marketplaceUrl, marketplaceUrl) || other.marketplaceUrl == marketplaceUrl)&&const DeepCollectionEquality().equals(other._defaultCollections, _defaultCollections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,marketplaceUrl,const DeepCollectionEquality().hash(_defaultCollections));

@override
String toString() {
  return 'NftInformation(marketplaceUrl: $marketplaceUrl, defaultCollections: $defaultCollections)';
}


}

/// @nodoc
abstract mixin class _$NftInformationCopyWith<$Res> implements $NftInformationCopyWith<$Res> {
  factory _$NftInformationCopyWith(_NftInformation value, $Res Function(_NftInformation) _then) = __$NftInformationCopyWithImpl;
@override @useResult
$Res call({
 String? marketplaceUrl, List<Address>? defaultCollections
});




}
/// @nodoc
class __$NftInformationCopyWithImpl<$Res>
    implements _$NftInformationCopyWith<$Res> {
  __$NftInformationCopyWithImpl(this._self, this._then);

  final _NftInformation _self;
  final $Res Function(_NftInformation) _then;

/// Create a copy of NftInformation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? marketplaceUrl = freezed,Object? defaultCollections = freezed,}) {
  return _then(_NftInformation(
marketplaceUrl: freezed == marketplaceUrl ? _self.marketplaceUrl : marketplaceUrl // ignore: cast_nullable_to_non_nullable
as String?,defaultCollections: freezed == defaultCollections ? _self._defaultCollections : defaultCollections // ignore: cast_nullable_to_non_nullable
as List<Address>?,
  ));
}


}

// dart format on
