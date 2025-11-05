// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Fee {

 Money get amount;
/// Create a copy of Fee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeCopyWith<Fee> get copyWith => _$FeeCopyWithImpl<Fee>(this as Fee, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Fee&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'Fee(amount: $amount)';
}


}

/// @nodoc
abstract mixin class $FeeCopyWith<$Res>  {
  factory $FeeCopyWith(Fee value, $Res Function(Fee) _then) = _$FeeCopyWithImpl;
@useResult
$Res call({
 Money amount
});




}
/// @nodoc
class _$FeeCopyWithImpl<$Res>
    implements $FeeCopyWith<$Res> {
  _$FeeCopyWithImpl(this._self, this._then);

  final Fee _self;
  final $Res Function(Fee) _then;

/// Create a copy of Fee
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [Fee].
extension FeePatterns on Fee {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FeeNative value)?  native,TResult Function( FeeToken value)?  token,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FeeNative() when native != null:
return native(_that);case FeeToken() when token != null:
return token(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FeeNative value)  native,required TResult Function( FeeToken value)  token,}){
final _that = this;
switch (_that) {
case FeeNative():
return native(_that);case FeeToken():
return token(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FeeNative value)?  native,TResult? Function( FeeToken value)?  token,}){
final _that = this;
switch (_that) {
case FeeNative() when native != null:
return native(_that);case FeeToken() when token != null:
return token(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Money amount)?  native,TResult Function( Money amount,  Address tokenRootAddress)?  token,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FeeNative() when native != null:
return native(_that.amount);case FeeToken() when token != null:
return token(_that.amount,_that.tokenRootAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Money amount)  native,required TResult Function( Money amount,  Address tokenRootAddress)  token,}) {final _that = this;
switch (_that) {
case FeeNative():
return native(_that.amount);case FeeToken():
return token(_that.amount,_that.tokenRootAddress);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Money amount)?  native,TResult? Function( Money amount,  Address tokenRootAddress)?  token,}) {final _that = this;
switch (_that) {
case FeeNative() when native != null:
return native(_that.amount);case FeeToken() when token != null:
return token(_that.amount,_that.tokenRootAddress);case _:
  return null;

}
}

}

/// @nodoc


class FeeNative extends Fee {
  const FeeNative(this.amount): super._();
  

@override final  Money amount;

/// Create a copy of Fee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeNativeCopyWith<FeeNative> get copyWith => _$FeeNativeCopyWithImpl<FeeNative>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeNative&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'Fee.native(amount: $amount)';
}


}

/// @nodoc
abstract mixin class $FeeNativeCopyWith<$Res> implements $FeeCopyWith<$Res> {
  factory $FeeNativeCopyWith(FeeNative value, $Res Function(FeeNative) _then) = _$FeeNativeCopyWithImpl;
@override @useResult
$Res call({
 Money amount
});




}
/// @nodoc
class _$FeeNativeCopyWithImpl<$Res>
    implements $FeeNativeCopyWith<$Res> {
  _$FeeNativeCopyWithImpl(this._self, this._then);

  final FeeNative _self;
  final $Res Function(FeeNative) _then;

/// Create a copy of Fee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,}) {
  return _then(FeeNative(
null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

/// @nodoc


class FeeToken extends Fee {
  const FeeToken({required this.amount, required this.tokenRootAddress}): super._();
  

@override final  Money amount;
 final  Address tokenRootAddress;

/// Create a copy of Fee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeTokenCopyWith<FeeToken> get copyWith => _$FeeTokenCopyWithImpl<FeeToken>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeToken&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.tokenRootAddress, tokenRootAddress) || other.tokenRootAddress == tokenRootAddress));
}


@override
int get hashCode => Object.hash(runtimeType,amount,tokenRootAddress);

@override
String toString() {
  return 'Fee.token(amount: $amount, tokenRootAddress: $tokenRootAddress)';
}


}

/// @nodoc
abstract mixin class $FeeTokenCopyWith<$Res> implements $FeeCopyWith<$Res> {
  factory $FeeTokenCopyWith(FeeToken value, $Res Function(FeeToken) _then) = _$FeeTokenCopyWithImpl;
@override @useResult
$Res call({
 Money amount, Address tokenRootAddress
});


$AddressCopyWith<$Res> get tokenRootAddress;

}
/// @nodoc
class _$FeeTokenCopyWithImpl<$Res>
    implements $FeeTokenCopyWith<$Res> {
  _$FeeTokenCopyWithImpl(this._self, this._then);

  final FeeToken _self;
  final $Res Function(FeeToken) _then;

/// Create a copy of Fee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? tokenRootAddress = null,}) {
  return _then(FeeToken(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,tokenRootAddress: null == tokenRootAddress ? _self.tokenRootAddress : tokenRootAddress // ignore: cast_nullable_to_non_nullable
as Address,
  ));
}

/// Create a copy of Fee
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get tokenRootAddress {
  
  return $AddressCopyWith<$Res>(_self.tokenRootAddress, (value) {
    return _then(_self.copyWith(tokenRootAddress: value));
  });
}
}

// dart format on
