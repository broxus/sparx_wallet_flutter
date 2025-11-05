// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_wallet_send_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TonWalletSendState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonWalletSendState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TonWalletSendState()';
}


}

/// @nodoc
class $TonWalletSendStateCopyWith<$Res>  {
$TonWalletSendStateCopyWith(TonWalletSendState _, $Res Function(TonWalletSendState) __);
}


/// Adds pattern-matching-related methods to [TonWalletSendState].
extension TonWalletSendStatePatterns on TonWalletSendState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TonWalletSendStateError value)?  error,TResult Function( TonWalletSendStateReady value)?  ready,TResult Function( TonWalletSendStateSending value)?  sending,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TonWalletSendStateError() when error != null:
return error(_that);case TonWalletSendStateReady() when ready != null:
return ready(_that);case TonWalletSendStateSending() when sending != null:
return sending(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TonWalletSendStateError value)  error,required TResult Function( TonWalletSendStateReady value)  ready,required TResult Function( TonWalletSendStateSending value)  sending,}){
final _that = this;
switch (_that) {
case TonWalletSendStateError():
return error(_that);case TonWalletSendStateReady():
return ready(_that);case TonWalletSendStateSending():
return sending(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TonWalletSendStateError value)?  error,TResult? Function( TonWalletSendStateReady value)?  ready,TResult? Function( TonWalletSendStateSending value)?  sending,}){
final _that = this;
switch (_that) {
case TonWalletSendStateError() when error != null:
return error(_that);case TonWalletSendStateReady() when ready != null:
return ready(_that);case TonWalletSendStateSending() when sending != null:
return sending(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Object error)?  error,TResult Function()?  ready,TResult Function( bool canClose)?  sending,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TonWalletSendStateError() when error != null:
return error(_that.error);case TonWalletSendStateReady() when ready != null:
return ready();case TonWalletSendStateSending() when sending != null:
return sending(_that.canClose);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Object error)  error,required TResult Function()  ready,required TResult Function( bool canClose)  sending,}) {final _that = this;
switch (_that) {
case TonWalletSendStateError():
return error(_that.error);case TonWalletSendStateReady():
return ready();case TonWalletSendStateSending():
return sending(_that.canClose);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Object error)?  error,TResult? Function()?  ready,TResult? Function( bool canClose)?  sending,}) {final _that = this;
switch (_that) {
case TonWalletSendStateError() when error != null:
return error(_that.error);case TonWalletSendStateReady() when ready != null:
return ready();case TonWalletSendStateSending() when sending != null:
return sending(_that.canClose);case _:
  return null;

}
}

}

/// @nodoc


class TonWalletSendStateError implements TonWalletSendState {
  const TonWalletSendStateError({required this.error});
  

 final  Object error;

/// Create a copy of TonWalletSendState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonWalletSendStateErrorCopyWith<TonWalletSendStateError> get copyWith => _$TonWalletSendStateErrorCopyWithImpl<TonWalletSendStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonWalletSendStateError&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'TonWalletSendState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $TonWalletSendStateErrorCopyWith<$Res> implements $TonWalletSendStateCopyWith<$Res> {
  factory $TonWalletSendStateErrorCopyWith(TonWalletSendStateError value, $Res Function(TonWalletSendStateError) _then) = _$TonWalletSendStateErrorCopyWithImpl;
@useResult
$Res call({
 Object error
});




}
/// @nodoc
class _$TonWalletSendStateErrorCopyWithImpl<$Res>
    implements $TonWalletSendStateErrorCopyWith<$Res> {
  _$TonWalletSendStateErrorCopyWithImpl(this._self, this._then);

  final TonWalletSendStateError _self;
  final $Res Function(TonWalletSendStateError) _then;

/// Create a copy of TonWalletSendState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(TonWalletSendStateError(
error: null == error ? _self.error : error ,
  ));
}


}

/// @nodoc


class TonWalletSendStateReady implements TonWalletSendState {
  const TonWalletSendStateReady();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonWalletSendStateReady);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TonWalletSendState.ready()';
}


}




/// @nodoc


class TonWalletSendStateSending implements TonWalletSendState {
  const TonWalletSendStateSending({required this.canClose});
  

 final  bool canClose;

/// Create a copy of TonWalletSendState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonWalletSendStateSendingCopyWith<TonWalletSendStateSending> get copyWith => _$TonWalletSendStateSendingCopyWithImpl<TonWalletSendStateSending>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonWalletSendStateSending&&(identical(other.canClose, canClose) || other.canClose == canClose));
}


@override
int get hashCode => Object.hash(runtimeType,canClose);

@override
String toString() {
  return 'TonWalletSendState.sending(canClose: $canClose)';
}


}

/// @nodoc
abstract mixin class $TonWalletSendStateSendingCopyWith<$Res> implements $TonWalletSendStateCopyWith<$Res> {
  factory $TonWalletSendStateSendingCopyWith(TonWalletSendStateSending value, $Res Function(TonWalletSendStateSending) _then) = _$TonWalletSendStateSendingCopyWithImpl;
@useResult
$Res call({
 bool canClose
});




}
/// @nodoc
class _$TonWalletSendStateSendingCopyWithImpl<$Res>
    implements $TonWalletSendStateSendingCopyWith<$Res> {
  _$TonWalletSendStateSendingCopyWithImpl(this._self, this._then);

  final TonWalletSendStateSending _self;
  final $Res Function(TonWalletSendStateSending) _then;

/// Create a copy of TonWalletSendState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? canClose = null,}) {
  return _then(TonWalletSendStateSending(
canClose: null == canClose ? _self.canClose : canClose // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
