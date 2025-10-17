// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transport_native_token_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransportNativeTokenTickerOption {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransportNativeTokenTickerOption);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TransportNativeTokenTickerOption()';
}


}

/// @nodoc
class $TransportNativeTokenTickerOptionCopyWith<$Res>  {
$TransportNativeTokenTickerOptionCopyWith(TransportNativeTokenTickerOption _, $Res Function(TransportNativeTokenTickerOption) __);
}


/// Adds pattern-matching-related methods to [TransportNativeTokenTickerOption].
extension TransportNativeTokenTickerOptionPatterns on TransportNativeTokenTickerOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TransportNativeTokenTickerOptionFromConnection value)?  fromConnection,TResult Function( TransportNativeTokenTickerOptionByName value)?  byName,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TransportNativeTokenTickerOptionFromConnection() when fromConnection != null:
return fromConnection(_that);case TransportNativeTokenTickerOptionByName() when byName != null:
return byName(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TransportNativeTokenTickerOptionFromConnection value)  fromConnection,required TResult Function( TransportNativeTokenTickerOptionByName value)  byName,}){
final _that = this;
switch (_that) {
case TransportNativeTokenTickerOptionFromConnection():
return fromConnection(_that);case TransportNativeTokenTickerOptionByName():
return byName(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TransportNativeTokenTickerOptionFromConnection value)?  fromConnection,TResult? Function( TransportNativeTokenTickerOptionByName value)?  byName,}){
final _that = this;
switch (_that) {
case TransportNativeTokenTickerOptionFromConnection() when fromConnection != null:
return fromConnection(_that);case TransportNativeTokenTickerOptionByName() when byName != null:
return byName(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fromConnection,TResult Function( String name)?  byName,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TransportNativeTokenTickerOptionFromConnection() when fromConnection != null:
return fromConnection();case TransportNativeTokenTickerOptionByName() when byName != null:
return byName(_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fromConnection,required TResult Function( String name)  byName,}) {final _that = this;
switch (_that) {
case TransportNativeTokenTickerOptionFromConnection():
return fromConnection();case TransportNativeTokenTickerOptionByName():
return byName(_that.name);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fromConnection,TResult? Function( String name)?  byName,}) {final _that = this;
switch (_that) {
case TransportNativeTokenTickerOptionFromConnection() when fromConnection != null:
return fromConnection();case TransportNativeTokenTickerOptionByName() when byName != null:
return byName(_that.name);case _:
  return null;

}
}

}

/// @nodoc


class TransportNativeTokenTickerOptionFromConnection implements TransportNativeTokenTickerOption {
  const TransportNativeTokenTickerOptionFromConnection();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransportNativeTokenTickerOptionFromConnection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TransportNativeTokenTickerOption.fromConnection()';
}


}




/// @nodoc


class TransportNativeTokenTickerOptionByName implements TransportNativeTokenTickerOption {
  const TransportNativeTokenTickerOptionByName(this.name);
  

 final  String name;

/// Create a copy of TransportNativeTokenTickerOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransportNativeTokenTickerOptionByNameCopyWith<TransportNativeTokenTickerOptionByName> get copyWith => _$TransportNativeTokenTickerOptionByNameCopyWithImpl<TransportNativeTokenTickerOptionByName>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransportNativeTokenTickerOptionByName&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'TransportNativeTokenTickerOption.byName(name: $name)';
}


}

/// @nodoc
abstract mixin class $TransportNativeTokenTickerOptionByNameCopyWith<$Res> implements $TransportNativeTokenTickerOptionCopyWith<$Res> {
  factory $TransportNativeTokenTickerOptionByNameCopyWith(TransportNativeTokenTickerOptionByName value, $Res Function(TransportNativeTokenTickerOptionByName) _then) = _$TransportNativeTokenTickerOptionByNameCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$TransportNativeTokenTickerOptionByNameCopyWithImpl<$Res>
    implements $TransportNativeTokenTickerOptionByNameCopyWith<$Res> {
  _$TransportNativeTokenTickerOptionByNameCopyWithImpl(this._self, this._then);

  final TransportNativeTokenTickerOptionByName _self;
  final $Res Function(TransportNativeTokenTickerOptionByName) _then;

/// Create a copy of TransportNativeTokenTickerOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(TransportNativeTokenTickerOptionByName(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
