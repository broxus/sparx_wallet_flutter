// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
WalletResponse _$WalletResponseFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'success':
          return WalletResponseSuccess.fromJson(
            json
          );
                case 'error':
          return WalletResponseError.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'WalletResponse',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$WalletResponse {

 String get id;
/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletResponseCopyWith<WalletResponse> get copyWith => _$WalletResponseCopyWithImpl<WalletResponse>(this as WalletResponse, _$identity);

  /// Serializes this WalletResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletResponse&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'WalletResponse(id: $id)';
}


}

/// @nodoc
abstract mixin class $WalletResponseCopyWith<$Res>  {
  factory $WalletResponseCopyWith(WalletResponse value, $Res Function(WalletResponse) _then) = _$WalletResponseCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$WalletResponseCopyWithImpl<$Res>
    implements $WalletResponseCopyWith<$Res> {
  _$WalletResponseCopyWithImpl(this._self, this._then);

  final WalletResponse _self;
  final $Res Function(WalletResponse) _then;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletResponse].
extension WalletResponsePatterns on WalletResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WalletResponseSuccess value)?  success,TResult Function( WalletResponseError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WalletResponseSuccess() when success != null:
return success(_that);case WalletResponseError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WalletResponseSuccess value)  success,required TResult Function( WalletResponseError value)  error,}){
final _that = this;
switch (_that) {
case WalletResponseSuccess():
return success(_that);case WalletResponseError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WalletResponseSuccess value)?  success,TResult? Function( WalletResponseError value)?  error,}){
final _that = this;
switch (_that) {
case WalletResponseSuccess() when success != null:
return success(_that);case WalletResponseError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String result)?  success,TResult Function( String id,  TonConnectError error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WalletResponseSuccess() when success != null:
return success(_that.id,_that.result);case WalletResponseError() when error != null:
return error(_that.id,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String result)  success,required TResult Function( String id,  TonConnectError error)  error,}) {final _that = this;
switch (_that) {
case WalletResponseSuccess():
return success(_that.id,_that.result);case WalletResponseError():
return error(_that.id,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String result)?  success,TResult? Function( String id,  TonConnectError error)?  error,}) {final _that = this;
switch (_that) {
case WalletResponseSuccess() when success != null:
return success(_that.id,_that.result);case WalletResponseError() when error != null:
return error(_that.id,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class WalletResponseSuccess implements WalletResponse {
  const WalletResponseSuccess({required this.id, required this.result, final  String? $type}): $type = $type ?? 'success';
  factory WalletResponseSuccess.fromJson(Map<String, dynamic> json) => _$WalletResponseSuccessFromJson(json);

@override final  String id;
 final  String result;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletResponseSuccessCopyWith<WalletResponseSuccess> get copyWith => _$WalletResponseSuccessCopyWithImpl<WalletResponseSuccess>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletResponseSuccessToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletResponseSuccess&&(identical(other.id, id) || other.id == id)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,result);

@override
String toString() {
  return 'WalletResponse.success(id: $id, result: $result)';
}


}

/// @nodoc
abstract mixin class $WalletResponseSuccessCopyWith<$Res> implements $WalletResponseCopyWith<$Res> {
  factory $WalletResponseSuccessCopyWith(WalletResponseSuccess value, $Res Function(WalletResponseSuccess) _then) = _$WalletResponseSuccessCopyWithImpl;
@override @useResult
$Res call({
 String id, String result
});




}
/// @nodoc
class _$WalletResponseSuccessCopyWithImpl<$Res>
    implements $WalletResponseSuccessCopyWith<$Res> {
  _$WalletResponseSuccessCopyWithImpl(this._self, this._then);

  final WalletResponseSuccess _self;
  final $Res Function(WalletResponseSuccess) _then;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? result = null,}) {
  return _then(WalletResponseSuccess(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class WalletResponseError implements WalletResponse {
  const WalletResponseError({required this.id, required this.error, final  String? $type}): $type = $type ?? 'error';
  factory WalletResponseError.fromJson(Map<String, dynamic> json) => _$WalletResponseErrorFromJson(json);

@override final  String id;
 final  TonConnectError error;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletResponseErrorCopyWith<WalletResponseError> get copyWith => _$WalletResponseErrorCopyWithImpl<WalletResponseError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletResponseErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletResponseError&&(identical(other.id, id) || other.id == id)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,error);

@override
String toString() {
  return 'WalletResponse.error(id: $id, error: $error)';
}


}

/// @nodoc
abstract mixin class $WalletResponseErrorCopyWith<$Res> implements $WalletResponseCopyWith<$Res> {
  factory $WalletResponseErrorCopyWith(WalletResponseError value, $Res Function(WalletResponseError) _then) = _$WalletResponseErrorCopyWithImpl;
@override @useResult
$Res call({
 String id, TonConnectError error
});


$TonConnectErrorCopyWith<$Res> get error;

}
/// @nodoc
class _$WalletResponseErrorCopyWithImpl<$Res>
    implements $WalletResponseErrorCopyWith<$Res> {
  _$WalletResponseErrorCopyWithImpl(this._self, this._then);

  final WalletResponseError _self;
  final $Res Function(WalletResponseError) _then;

/// Create a copy of WalletResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? error = null,}) {
  return _then(WalletResponseError(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as TonConnectError,
  ));
}

/// Create a copy of WalletResponse
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
