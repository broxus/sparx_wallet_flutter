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

 String get signature; Address get address; int get timestamp; String get domain; SignDataPayload get payload;
/// Create a copy of SignDataResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignDataResultCopyWith<SignDataResult> get copyWith => _$SignDataResultCopyWithImpl<SignDataResult>(this as SignDataResult, _$identity);

  /// Serializes this SignDataResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignDataResult&&(identical(other.signature, signature) || other.signature == signature)&&(identical(other.address, address) || other.address == address)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.payload, payload) || other.payload == payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,signature,address,timestamp,domain,payload);

@override
String toString() {
  return 'SignDataResult(signature: $signature, address: $address, timestamp: $timestamp, domain: $domain, payload: $payload)';
}


}

/// @nodoc
abstract mixin class $SignDataResultCopyWith<$Res>  {
  factory $SignDataResultCopyWith(SignDataResult value, $Res Function(SignDataResult) _then) = _$SignDataResultCopyWithImpl;
@useResult
$Res call({
 String signature, Address address, int timestamp, String domain, SignDataPayload payload
});


$AddressCopyWith<$Res> get address;$SignDataPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class _$SignDataResultCopyWithImpl<$Res>
    implements $SignDataResultCopyWith<$Res> {
  _$SignDataResultCopyWithImpl(this._self, this._then);

  final SignDataResult _self;
  final $Res Function(SignDataResult) _then;

/// Create a copy of SignDataResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signature = null,Object? address = null,Object? timestamp = null,Object? domain = null,Object? payload = null,}) {
  return _then(_self.copyWith(
signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as SignDataPayload,
  ));
}
/// Create a copy of SignDataResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get address {
  
  return $AddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of SignDataResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignDataPayloadCopyWith<$Res> get payload {
  
  return $SignDataPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String signature,  Address address,  int timestamp,  String domain,  SignDataPayload payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignDataResult() when $default != null:
return $default(_that.signature,_that.address,_that.timestamp,_that.domain,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String signature,  Address address,  int timestamp,  String domain,  SignDataPayload payload)  $default,) {final _that = this;
switch (_that) {
case _SignDataResult():
return $default(_that.signature,_that.address,_that.timestamp,_that.domain,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String signature,  Address address,  int timestamp,  String domain,  SignDataPayload payload)?  $default,) {final _that = this;
switch (_that) {
case _SignDataResult() when $default != null:
return $default(_that.signature,_that.address,_that.timestamp,_that.domain,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignDataResult implements SignDataResult {
   _SignDataResult({required this.signature, required this.address, required this.timestamp, required this.domain, required this.payload});
  factory _SignDataResult.fromJson(Map<String, dynamic> json) => _$SignDataResultFromJson(json);

@override final  String signature;
@override final  Address address;
@override final  int timestamp;
@override final  String domain;
@override final  SignDataPayload payload;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignDataResult&&(identical(other.signature, signature) || other.signature == signature)&&(identical(other.address, address) || other.address == address)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.payload, payload) || other.payload == payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,signature,address,timestamp,domain,payload);

@override
String toString() {
  return 'SignDataResult(signature: $signature, address: $address, timestamp: $timestamp, domain: $domain, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$SignDataResultCopyWith<$Res> implements $SignDataResultCopyWith<$Res> {
  factory _$SignDataResultCopyWith(_SignDataResult value, $Res Function(_SignDataResult) _then) = __$SignDataResultCopyWithImpl;
@override @useResult
$Res call({
 String signature, Address address, int timestamp, String domain, SignDataPayload payload
});


@override $AddressCopyWith<$Res> get address;@override $SignDataPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class __$SignDataResultCopyWithImpl<$Res>
    implements _$SignDataResultCopyWith<$Res> {
  __$SignDataResultCopyWithImpl(this._self, this._then);

  final _SignDataResult _self;
  final $Res Function(_SignDataResult) _then;

/// Create a copy of SignDataResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signature = null,Object? address = null,Object? timestamp = null,Object? domain = null,Object? payload = null,}) {
  return _then(_SignDataResult(
signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as SignDataPayload,
  ));
}

/// Create a copy of SignDataResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get address {
  
  return $AddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of SignDataResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignDataPayloadCopyWith<$Res> get payload {
  
  return $SignDataPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}

// dart format on
