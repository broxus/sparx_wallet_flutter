// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transport_icons.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransportIcons {

 String? get nativeToken; String? get network; String? get vector;
/// Create a copy of TransportIcons
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransportIconsCopyWith<TransportIcons> get copyWith => _$TransportIconsCopyWithImpl<TransportIcons>(this as TransportIcons, _$identity);

  /// Serializes this TransportIcons to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransportIcons&&(identical(other.nativeToken, nativeToken) || other.nativeToken == nativeToken)&&(identical(other.network, network) || other.network == network)&&(identical(other.vector, vector) || other.vector == vector));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nativeToken,network,vector);

@override
String toString() {
  return 'TransportIcons(nativeToken: $nativeToken, network: $network, vector: $vector)';
}


}

/// @nodoc
abstract mixin class $TransportIconsCopyWith<$Res>  {
  factory $TransportIconsCopyWith(TransportIcons value, $Res Function(TransportIcons) _then) = _$TransportIconsCopyWithImpl;
@useResult
$Res call({
 String? nativeToken, String? network, String? vector
});




}
/// @nodoc
class _$TransportIconsCopyWithImpl<$Res>
    implements $TransportIconsCopyWith<$Res> {
  _$TransportIconsCopyWithImpl(this._self, this._then);

  final TransportIcons _self;
  final $Res Function(TransportIcons) _then;

/// Create a copy of TransportIcons
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nativeToken = freezed,Object? network = freezed,Object? vector = freezed,}) {
  return _then(_self.copyWith(
nativeToken: freezed == nativeToken ? _self.nativeToken : nativeToken // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,vector: freezed == vector ? _self.vector : vector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransportIcons].
extension TransportIconsPatterns on TransportIcons {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransportIcons value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransportIcons() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransportIcons value)  $default,){
final _that = this;
switch (_that) {
case _TransportIcons():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransportIcons value)?  $default,){
final _that = this;
switch (_that) {
case _TransportIcons() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nativeToken,  String? network,  String? vector)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransportIcons() when $default != null:
return $default(_that.nativeToken,_that.network,_that.vector);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nativeToken,  String? network,  String? vector)  $default,) {final _that = this;
switch (_that) {
case _TransportIcons():
return $default(_that.nativeToken,_that.network,_that.vector);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nativeToken,  String? network,  String? vector)?  $default,) {final _that = this;
switch (_that) {
case _TransportIcons() when $default != null:
return $default(_that.nativeToken,_that.network,_that.vector);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransportIcons implements TransportIcons {
   _TransportIcons({this.nativeToken, this.network, this.vector});
  factory _TransportIcons.fromJson(Map<String, dynamic> json) => _$TransportIconsFromJson(json);

@override final  String? nativeToken;
@override final  String? network;
@override final  String? vector;

/// Create a copy of TransportIcons
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransportIconsCopyWith<_TransportIcons> get copyWith => __$TransportIconsCopyWithImpl<_TransportIcons>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransportIconsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransportIcons&&(identical(other.nativeToken, nativeToken) || other.nativeToken == nativeToken)&&(identical(other.network, network) || other.network == network)&&(identical(other.vector, vector) || other.vector == vector));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nativeToken,network,vector);

@override
String toString() {
  return 'TransportIcons(nativeToken: $nativeToken, network: $network, vector: $vector)';
}


}

/// @nodoc
abstract mixin class _$TransportIconsCopyWith<$Res> implements $TransportIconsCopyWith<$Res> {
  factory _$TransportIconsCopyWith(_TransportIcons value, $Res Function(_TransportIcons) _then) = __$TransportIconsCopyWithImpl;
@override @useResult
$Res call({
 String? nativeToken, String? network, String? vector
});




}
/// @nodoc
class __$TransportIconsCopyWithImpl<$Res>
    implements _$TransportIconsCopyWith<$Res> {
  __$TransportIconsCopyWithImpl(this._self, this._then);

  final _TransportIcons _self;
  final $Res Function(_TransportIcons) _then;

/// Create a copy of TransportIcons
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nativeToken = freezed,Object? network = freezed,Object? vector = freezed,}) {
  return _then(_TransportIcons(
nativeToken: freezed == nativeToken ? _self.nativeToken : nativeToken // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,vector: freezed == vector ? _self.vector : vector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
