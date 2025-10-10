// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConnectResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectResult()';
}


}

/// @nodoc
class $ConnectResultCopyWith<$Res>  {
$ConnectResultCopyWith(ConnectResult _, $Res Function(ConnectResult) __);
}


/// Adds pattern-matching-related methods to [ConnectResult].
extension ConnectResultPatterns on ConnectResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ConnectResultSuccess value)?  success,TResult Function( ConnectResultError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ConnectResultSuccess() when success != null:
return success(_that);case ConnectResultError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ConnectResultSuccess value)  success,required TResult Function( ConnectResultError value)  error,}){
final _that = this;
switch (_that) {
case ConnectResultSuccess():
return success(_that);case ConnectResultError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ConnectResultSuccess value)?  success,TResult? Function( ConnectResultError value)?  error,}){
final _that = this;
switch (_that) {
case ConnectResultSuccess() when success != null:
return success(_that);case ConnectResultError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( KeyAccount account,  List<ConnectItemReply> replyItems,  DappManifest manifest)?  success,TResult Function( TonConnectError error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ConnectResultSuccess() when success != null:
return success(_that.account,_that.replyItems,_that.manifest);case ConnectResultError() when error != null:
return error(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( KeyAccount account,  List<ConnectItemReply> replyItems,  DappManifest manifest)  success,required TResult Function( TonConnectError error)  error,}) {final _that = this;
switch (_that) {
case ConnectResultSuccess():
return success(_that.account,_that.replyItems,_that.manifest);case ConnectResultError():
return error(_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( KeyAccount account,  List<ConnectItemReply> replyItems,  DappManifest manifest)?  success,TResult? Function( TonConnectError error)?  error,}) {final _that = this;
switch (_that) {
case ConnectResultSuccess() when success != null:
return success(_that.account,_that.replyItems,_that.manifest);case ConnectResultError() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class ConnectResultSuccess implements ConnectResult {
   ConnectResultSuccess({required this.account, required final  List<ConnectItemReply> replyItems, required this.manifest}): _replyItems = replyItems;
  

 final  KeyAccount account;
 final  List<ConnectItemReply> _replyItems;
 List<ConnectItemReply> get replyItems {
  if (_replyItems is EqualUnmodifiableListView) return _replyItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replyItems);
}

 final  DappManifest manifest;

/// Create a copy of ConnectResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectResultSuccessCopyWith<ConnectResultSuccess> get copyWith => _$ConnectResultSuccessCopyWithImpl<ConnectResultSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectResultSuccess&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other._replyItems, _replyItems)&&(identical(other.manifest, manifest) || other.manifest == manifest));
}


@override
int get hashCode => Object.hash(runtimeType,account,const DeepCollectionEquality().hash(_replyItems),manifest);

@override
String toString() {
  return 'ConnectResult.success(account: $account, replyItems: $replyItems, manifest: $manifest)';
}


}

/// @nodoc
abstract mixin class $ConnectResultSuccessCopyWith<$Res> implements $ConnectResultCopyWith<$Res> {
  factory $ConnectResultSuccessCopyWith(ConnectResultSuccess value, $Res Function(ConnectResultSuccess) _then) = _$ConnectResultSuccessCopyWithImpl;
@useResult
$Res call({
 KeyAccount account, List<ConnectItemReply> replyItems, DappManifest manifest
});


$DappManifestCopyWith<$Res> get manifest;

}
/// @nodoc
class _$ConnectResultSuccessCopyWithImpl<$Res>
    implements $ConnectResultSuccessCopyWith<$Res> {
  _$ConnectResultSuccessCopyWithImpl(this._self, this._then);

  final ConnectResultSuccess _self;
  final $Res Function(ConnectResultSuccess) _then;

/// Create a copy of ConnectResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? account = null,Object? replyItems = null,Object? manifest = null,}) {
  return _then(ConnectResultSuccess(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as KeyAccount,replyItems: null == replyItems ? _self._replyItems : replyItems // ignore: cast_nullable_to_non_nullable
as List<ConnectItemReply>,manifest: null == manifest ? _self.manifest : manifest // ignore: cast_nullable_to_non_nullable
as DappManifest,
  ));
}

/// Create a copy of ConnectResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DappManifestCopyWith<$Res> get manifest {
  
  return $DappManifestCopyWith<$Res>(_self.manifest, (value) {
    return _then(_self.copyWith(manifest: value));
  });
}
}

/// @nodoc


class ConnectResultError implements ConnectResult {
   ConnectResultError({required this.error});
  

 final  TonConnectError error;

/// Create a copy of ConnectResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectResultErrorCopyWith<ConnectResultError> get copyWith => _$ConnectResultErrorCopyWithImpl<ConnectResultError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectResultError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ConnectResult.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ConnectResultErrorCopyWith<$Res> implements $ConnectResultCopyWith<$Res> {
  factory $ConnectResultErrorCopyWith(ConnectResultError value, $Res Function(ConnectResultError) _then) = _$ConnectResultErrorCopyWithImpl;
@useResult
$Res call({
 TonConnectError error
});


$TonConnectErrorCopyWith<$Res> get error;

}
/// @nodoc
class _$ConnectResultErrorCopyWithImpl<$Res>
    implements $ConnectResultErrorCopyWith<$Res> {
  _$ConnectResultErrorCopyWithImpl(this._self, this._then);

  final ConnectResultError _self;
  final $Res Function(ConnectResultError) _then;

/// Create a copy of ConnectResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(ConnectResultError(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as TonConnectError,
  ));
}

/// Create a copy of ConnectResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TonConnectErrorCopyWith<$Res> get error {
  
  return $TonConnectErrorCopyWith<$Res>(_self.error, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
