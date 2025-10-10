// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_data_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignDataResult {

/// base64 encoded signature
 String get signature;/// UNIX timestamp in seconds (UTC) at the moment on creating the signature
 String get timestamp;
/// Create a copy of SignDataResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignDataResultCopyWith<SignDataResult> get copyWith => _$SignDataResultCopyWithImpl<SignDataResult>(this as SignDataResult, _$identity);

  /// Serializes this SignDataResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignDataResult&&(identical(other.signature, signature) || other.signature == signature)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,signature,timestamp);

@override
String toString() {
  return 'SignDataResult(signature: $signature, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $SignDataResultCopyWith<$Res>  {
  factory $SignDataResultCopyWith(SignDataResult value, $Res Function(SignDataResult) _then) = _$SignDataResultCopyWithImpl;
@useResult
$Res call({
 String signature, String timestamp
});




}
/// @nodoc
class _$SignDataResultCopyWithImpl<$Res>
    implements $SignDataResultCopyWith<$Res> {
  _$SignDataResultCopyWithImpl(this._self, this._then);

  final SignDataResult _self;
  final $Res Function(SignDataResult) _then;

/// Create a copy of SignDataResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signature = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignDataResult].
extension SignDataResultPatterns on SignDataResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignDataResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignDataResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignDataResult value)  $default,){
final _that = this;
switch (_that) {
case _SignDataResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignDataResult value)?  $default,){
final _that = this;
switch (_that) {
case _SignDataResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String signature,  String timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignDataResult() when $default != null:
return $default(_that.signature,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String signature,  String timestamp)  $default,) {final _that = this;
switch (_that) {
case _SignDataResult():
return $default(_that.signature,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String signature,  String timestamp)?  $default,) {final _that = this;
switch (_that) {
case _SignDataResult() when $default != null:
return $default(_that.signature,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignDataResult implements SignDataResult {
   _SignDataResult({required this.signature, required this.timestamp});
  factory _SignDataResult.fromJson(Map<String, dynamic> json) => _$SignDataResultFromJson(json);

/// base64 encoded signature
@override final  String signature;
/// UNIX timestamp in seconds (UTC) at the moment on creating the signature
@override final  String timestamp;

/// Create a copy of SignDataResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignDataResultCopyWith<_SignDataResult> get copyWith => __$SignDataResultCopyWithImpl<_SignDataResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignDataResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignDataResult&&(identical(other.signature, signature) || other.signature == signature)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,signature,timestamp);

@override
String toString() {
  return 'SignDataResult(signature: $signature, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$SignDataResultCopyWith<$Res> implements $SignDataResultCopyWith<$Res> {
  factory _$SignDataResultCopyWith(_SignDataResult value, $Res Function(_SignDataResult) _then) = __$SignDataResultCopyWithImpl;
@override @useResult
$Res call({
 String signature, String timestamp
});




}
/// @nodoc
class __$SignDataResultCopyWithImpl<$Res>
    implements _$SignDataResultCopyWith<$Res> {
  __$SignDataResultCopyWithImpl(this._self, this._then);

  final _SignDataResult _self;
  final $Res Function(_SignDataResult) _then;

/// Create a copy of SignDataResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signature = null,Object? timestamp = null,}) {
  return _then(_SignDataResult(
signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
