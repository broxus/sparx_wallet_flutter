// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_connect_ui_event_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TonConnectUiEventResult<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonConnectUiEventResult<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TonConnectUiEventResult<$T>()';
}


}

/// @nodoc
class $TonConnectUiEventResultCopyWith<T,$Res>  {
$TonConnectUiEventResultCopyWith(TonConnectUiEventResult<T> _, $Res Function(TonConnectUiEventResult<T>) __);
}


/// Adds pattern-matching-related methods to [TonConnectUiEventResult].
extension TonConnectUiEventResultPatterns<T> on TonConnectUiEventResult<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TonConnectUiEventResultData<T> value)?  data,TResult Function( TonConnectUiEventResultError<T> value)?  error,TResult Function( TonConnectUiEventResultCanceled<T> value)?  canceled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TonConnectUiEventResultData() when data != null:
return data(_that);case TonConnectUiEventResultError() when error != null:
return error(_that);case TonConnectUiEventResultCanceled() when canceled != null:
return canceled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TonConnectUiEventResultData<T> value)  data,required TResult Function( TonConnectUiEventResultError<T> value)  error,required TResult Function( TonConnectUiEventResultCanceled<T> value)  canceled,}){
final _that = this;
switch (_that) {
case TonConnectUiEventResultData():
return data(_that);case TonConnectUiEventResultError():
return error(_that);case TonConnectUiEventResultCanceled():
return canceled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TonConnectUiEventResultData<T> value)?  data,TResult? Function( TonConnectUiEventResultError<T> value)?  error,TResult? Function( TonConnectUiEventResultCanceled<T> value)?  canceled,}){
final _that = this;
switch (_that) {
case TonConnectUiEventResultData() when data != null:
return data(_that);case TonConnectUiEventResultError() when error != null:
return error(_that);case TonConnectUiEventResultCanceled() when canceled != null:
return canceled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( T data)?  data,TResult Function( TonConnectException error)?  error,TResult Function()?  canceled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TonConnectUiEventResultData() when data != null:
return data(_that.data);case TonConnectUiEventResultError() when error != null:
return error(_that.error);case TonConnectUiEventResultCanceled() when canceled != null:
return canceled();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( T data)  data,required TResult Function( TonConnectException error)  error,required TResult Function()  canceled,}) {final _that = this;
switch (_that) {
case TonConnectUiEventResultData():
return data(_that.data);case TonConnectUiEventResultError():
return error(_that.error);case TonConnectUiEventResultCanceled():
return canceled();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( T data)?  data,TResult? Function( TonConnectException error)?  error,TResult? Function()?  canceled,}) {final _that = this;
switch (_that) {
case TonConnectUiEventResultData() when data != null:
return data(_that.data);case TonConnectUiEventResultError() when error != null:
return error(_that.error);case TonConnectUiEventResultCanceled() when canceled != null:
return canceled();case _:
  return null;

}
}

}

/// @nodoc


class TonConnectUiEventResultData<T> implements TonConnectUiEventResult<T> {
  const TonConnectUiEventResultData({required this.data});
  

 final  T data;

/// Create a copy of TonConnectUiEventResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonConnectUiEventResultDataCopyWith<T, TonConnectUiEventResultData<T>> get copyWith => _$TonConnectUiEventResultDataCopyWithImpl<T, TonConnectUiEventResultData<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonConnectUiEventResultData<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'TonConnectUiEventResult<$T>.data(data: $data)';
}


}

/// @nodoc
abstract mixin class $TonConnectUiEventResultDataCopyWith<T,$Res> implements $TonConnectUiEventResultCopyWith<T, $Res> {
  factory $TonConnectUiEventResultDataCopyWith(TonConnectUiEventResultData<T> value, $Res Function(TonConnectUiEventResultData<T>) _then) = _$TonConnectUiEventResultDataCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$TonConnectUiEventResultDataCopyWithImpl<T,$Res>
    implements $TonConnectUiEventResultDataCopyWith<T, $Res> {
  _$TonConnectUiEventResultDataCopyWithImpl(this._self, this._then);

  final TonConnectUiEventResultData<T> _self;
  final $Res Function(TonConnectUiEventResultData<T>) _then;

/// Create a copy of TonConnectUiEventResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(TonConnectUiEventResultData<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class TonConnectUiEventResultError<T> implements TonConnectUiEventResult<T> {
  const TonConnectUiEventResultError({required this.error});
  

 final  TonConnectException error;

/// Create a copy of TonConnectUiEventResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonConnectUiEventResultErrorCopyWith<T, TonConnectUiEventResultError<T>> get copyWith => _$TonConnectUiEventResultErrorCopyWithImpl<T, TonConnectUiEventResultError<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonConnectUiEventResultError<T>&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'TonConnectUiEventResult<$T>.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $TonConnectUiEventResultErrorCopyWith<T,$Res> implements $TonConnectUiEventResultCopyWith<T, $Res> {
  factory $TonConnectUiEventResultErrorCopyWith(TonConnectUiEventResultError<T> value, $Res Function(TonConnectUiEventResultError<T>) _then) = _$TonConnectUiEventResultErrorCopyWithImpl;
@useResult
$Res call({
 TonConnectException error
});




}
/// @nodoc
class _$TonConnectUiEventResultErrorCopyWithImpl<T,$Res>
    implements $TonConnectUiEventResultErrorCopyWith<T, $Res> {
  _$TonConnectUiEventResultErrorCopyWithImpl(this._self, this._then);

  final TonConnectUiEventResultError<T> _self;
  final $Res Function(TonConnectUiEventResultError<T>) _then;

/// Create a copy of TonConnectUiEventResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(TonConnectUiEventResultError<T>(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as TonConnectException,
  ));
}


}

/// @nodoc


class TonConnectUiEventResultCanceled<T> implements TonConnectUiEventResult<T> {
  const TonConnectUiEventResultCanceled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonConnectUiEventResultCanceled<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TonConnectUiEventResult<$T>.canceled()';
}


}




// dart format on
