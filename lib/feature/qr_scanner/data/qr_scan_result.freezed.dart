// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_scan_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QrScanResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrScanResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QrScanResult()';
}


}

/// @nodoc
class $QrScanResultCopyWith<$Res>  {
$QrScanResultCopyWith(QrScanResult _, $Res Function(QrScanResult) __);
}


/// Adds pattern-matching-related methods to [QrScanResult].
extension QrScanResultPatterns on QrScanResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( QrScanResultInvalid value)?  invalid,TResult Function( QrScanResultAddress value)?  address,TResult Function( QrScanResultUri value)?  uri,required TResult orElse(),}){
final _that = this;
switch (_that) {
case QrScanResultInvalid() when invalid != null:
return invalid(_that);case QrScanResultAddress() when address != null:
return address(_that);case QrScanResultUri() when uri != null:
return uri(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( QrScanResultInvalid value)  invalid,required TResult Function( QrScanResultAddress value)  address,required TResult Function( QrScanResultUri value)  uri,}){
final _that = this;
switch (_that) {
case QrScanResultInvalid():
return invalid(_that);case QrScanResultAddress():
return address(_that);case QrScanResultUri():
return uri(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( QrScanResultInvalid value)?  invalid,TResult? Function( QrScanResultAddress value)?  address,TResult? Function( QrScanResultUri value)?  uri,}){
final _that = this;
switch (_that) {
case QrScanResultInvalid() when invalid != null:
return invalid(_that);case QrScanResultAddress() when address != null:
return address(_that);case QrScanResultUri() when uri != null:
return uri(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  invalid,TResult Function( Address value)?  address,TResult Function( Uri value)?  uri,required TResult orElse(),}) {final _that = this;
switch (_that) {
case QrScanResultInvalid() when invalid != null:
return invalid();case QrScanResultAddress() when address != null:
return address(_that.value);case QrScanResultUri() when uri != null:
return uri(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  invalid,required TResult Function( Address value)  address,required TResult Function( Uri value)  uri,}) {final _that = this;
switch (_that) {
case QrScanResultInvalid():
return invalid();case QrScanResultAddress():
return address(_that.value);case QrScanResultUri():
return uri(_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  invalid,TResult? Function( Address value)?  address,TResult? Function( Uri value)?  uri,}) {final _that = this;
switch (_that) {
case QrScanResultInvalid() when invalid != null:
return invalid();case QrScanResultAddress() when address != null:
return address(_that.value);case QrScanResultUri() when uri != null:
return uri(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class QrScanResultInvalid implements QrScanResult {
  const QrScanResultInvalid();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrScanResultInvalid);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QrScanResult.invalid()';
}


}




/// @nodoc


class QrScanResultAddress implements QrScanResult {
  const QrScanResultAddress(this.value);
  

 final  Address value;

/// Create a copy of QrScanResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrScanResultAddressCopyWith<QrScanResultAddress> get copyWith => _$QrScanResultAddressCopyWithImpl<QrScanResultAddress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrScanResultAddress&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'QrScanResult.address(value: $value)';
}


}

/// @nodoc
abstract mixin class $QrScanResultAddressCopyWith<$Res> implements $QrScanResultCopyWith<$Res> {
  factory $QrScanResultAddressCopyWith(QrScanResultAddress value, $Res Function(QrScanResultAddress) _then) = _$QrScanResultAddressCopyWithImpl;
@useResult
$Res call({
 Address value
});


$AddressCopyWith<$Res> get value;

}
/// @nodoc
class _$QrScanResultAddressCopyWithImpl<$Res>
    implements $QrScanResultAddressCopyWith<$Res> {
  _$QrScanResultAddressCopyWithImpl(this._self, this._then);

  final QrScanResultAddress _self;
  final $Res Function(QrScanResultAddress) _then;

/// Create a copy of QrScanResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(QrScanResultAddress(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as Address,
  ));
}

/// Create a copy of QrScanResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get value {
  
  return $AddressCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}

/// @nodoc


class QrScanResultUri implements QrScanResult {
  const QrScanResultUri(this.value);
  

 final  Uri value;

/// Create a copy of QrScanResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrScanResultUriCopyWith<QrScanResultUri> get copyWith => _$QrScanResultUriCopyWithImpl<QrScanResultUri>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrScanResultUri&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'QrScanResult.uri(value: $value)';
}


}

/// @nodoc
abstract mixin class $QrScanResultUriCopyWith<$Res> implements $QrScanResultCopyWith<$Res> {
  factory $QrScanResultUriCopyWith(QrScanResultUri value, $Res Function(QrScanResultUri) _then) = _$QrScanResultUriCopyWithImpl;
@useResult
$Res call({
 Uri value
});




}
/// @nodoc
class _$QrScanResultUriCopyWithImpl<$Res>
    implements $QrScanResultUriCopyWith<$Res> {
  _$QrScanResultUriCopyWithImpl(this._self, this._then);

  final QrScanResultUri _self;
  final $Res Function(QrScanResultUri) _then;

/// Create a copy of QrScanResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(QrScanResultUri(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as Uri,
  ));
}


}

// dart format on
