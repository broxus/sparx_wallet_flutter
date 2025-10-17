// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenBalanceModel {

 String get amount; Address get ownerAddress; Address get rootAddress; Address get tokenWalletAddress; String get token;
/// Create a copy of TokenBalanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenBalanceModelCopyWith<TokenBalanceModel> get copyWith => _$TokenBalanceModelCopyWithImpl<TokenBalanceModel>(this as TokenBalanceModel, _$identity);

  /// Serializes this TokenBalanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenBalanceModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.ownerAddress, ownerAddress) || other.ownerAddress == ownerAddress)&&(identical(other.rootAddress, rootAddress) || other.rootAddress == rootAddress)&&(identical(other.tokenWalletAddress, tokenWalletAddress) || other.tokenWalletAddress == tokenWalletAddress)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,ownerAddress,rootAddress,tokenWalletAddress,token);

@override
String toString() {
  return 'TokenBalanceModel(amount: $amount, ownerAddress: $ownerAddress, rootAddress: $rootAddress, tokenWalletAddress: $tokenWalletAddress, token: $token)';
}


}

/// @nodoc
abstract mixin class $TokenBalanceModelCopyWith<$Res>  {
  factory $TokenBalanceModelCopyWith(TokenBalanceModel value, $Res Function(TokenBalanceModel) _then) = _$TokenBalanceModelCopyWithImpl;
@useResult
$Res call({
 String amount, Address ownerAddress, Address rootAddress, Address tokenWalletAddress, String token
});


$AddressCopyWith<$Res> get ownerAddress;$AddressCopyWith<$Res> get rootAddress;$AddressCopyWith<$Res> get tokenWalletAddress;

}
/// @nodoc
class _$TokenBalanceModelCopyWithImpl<$Res>
    implements $TokenBalanceModelCopyWith<$Res> {
  _$TokenBalanceModelCopyWithImpl(this._self, this._then);

  final TokenBalanceModel _self;
  final $Res Function(TokenBalanceModel) _then;

/// Create a copy of TokenBalanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? ownerAddress = null,Object? rootAddress = null,Object? tokenWalletAddress = null,Object? token = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,ownerAddress: null == ownerAddress ? _self.ownerAddress : ownerAddress // ignore: cast_nullable_to_non_nullable
as Address,rootAddress: null == rootAddress ? _self.rootAddress : rootAddress // ignore: cast_nullable_to_non_nullable
as Address,tokenWalletAddress: null == tokenWalletAddress ? _self.tokenWalletAddress : tokenWalletAddress // ignore: cast_nullable_to_non_nullable
as Address,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of TokenBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get ownerAddress {
  
  return $AddressCopyWith<$Res>(_self.ownerAddress, (value) {
    return _then(_self.copyWith(ownerAddress: value));
  });
}/// Create a copy of TokenBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get rootAddress {
  
  return $AddressCopyWith<$Res>(_self.rootAddress, (value) {
    return _then(_self.copyWith(rootAddress: value));
  });
}/// Create a copy of TokenBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get tokenWalletAddress {
  
  return $AddressCopyWith<$Res>(_self.tokenWalletAddress, (value) {
    return _then(_self.copyWith(tokenWalletAddress: value));
  });
}
}


/// Adds pattern-matching-related methods to [TokenBalanceModel].
extension TokenBalanceModelPatterns on TokenBalanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenBalanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenBalanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenBalanceModel value)  $default,){
final _that = this;
switch (_that) {
case _TokenBalanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenBalanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _TokenBalanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String amount,  Address ownerAddress,  Address rootAddress,  Address tokenWalletAddress,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenBalanceModel() when $default != null:
return $default(_that.amount,_that.ownerAddress,_that.rootAddress,_that.tokenWalletAddress,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String amount,  Address ownerAddress,  Address rootAddress,  Address tokenWalletAddress,  String token)  $default,) {final _that = this;
switch (_that) {
case _TokenBalanceModel():
return $default(_that.amount,_that.ownerAddress,_that.rootAddress,_that.tokenWalletAddress,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String amount,  Address ownerAddress,  Address rootAddress,  Address tokenWalletAddress,  String token)?  $default,) {final _that = this;
switch (_that) {
case _TokenBalanceModel() when $default != null:
return $default(_that.amount,_that.ownerAddress,_that.rootAddress,_that.tokenWalletAddress,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenBalanceModel implements TokenBalanceModel {
  const _TokenBalanceModel({required this.amount, required this.ownerAddress, required this.rootAddress, required this.tokenWalletAddress, required this.token});
  factory _TokenBalanceModel.fromJson(Map<String, dynamic> json) => _$TokenBalanceModelFromJson(json);

@override final  String amount;
@override final  Address ownerAddress;
@override final  Address rootAddress;
@override final  Address tokenWalletAddress;
@override final  String token;

/// Create a copy of TokenBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenBalanceModelCopyWith<_TokenBalanceModel> get copyWith => __$TokenBalanceModelCopyWithImpl<_TokenBalanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenBalanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenBalanceModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.ownerAddress, ownerAddress) || other.ownerAddress == ownerAddress)&&(identical(other.rootAddress, rootAddress) || other.rootAddress == rootAddress)&&(identical(other.tokenWalletAddress, tokenWalletAddress) || other.tokenWalletAddress == tokenWalletAddress)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,ownerAddress,rootAddress,tokenWalletAddress,token);

@override
String toString() {
  return 'TokenBalanceModel(amount: $amount, ownerAddress: $ownerAddress, rootAddress: $rootAddress, tokenWalletAddress: $tokenWalletAddress, token: $token)';
}


}

/// @nodoc
abstract mixin class _$TokenBalanceModelCopyWith<$Res> implements $TokenBalanceModelCopyWith<$Res> {
  factory _$TokenBalanceModelCopyWith(_TokenBalanceModel value, $Res Function(_TokenBalanceModel) _then) = __$TokenBalanceModelCopyWithImpl;
@override @useResult
$Res call({
 String amount, Address ownerAddress, Address rootAddress, Address tokenWalletAddress, String token
});


@override $AddressCopyWith<$Res> get ownerAddress;@override $AddressCopyWith<$Res> get rootAddress;@override $AddressCopyWith<$Res> get tokenWalletAddress;

}
/// @nodoc
class __$TokenBalanceModelCopyWithImpl<$Res>
    implements _$TokenBalanceModelCopyWith<$Res> {
  __$TokenBalanceModelCopyWithImpl(this._self, this._then);

  final _TokenBalanceModel _self;
  final $Res Function(_TokenBalanceModel) _then;

/// Create a copy of TokenBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? ownerAddress = null,Object? rootAddress = null,Object? tokenWalletAddress = null,Object? token = null,}) {
  return _then(_TokenBalanceModel(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,ownerAddress: null == ownerAddress ? _self.ownerAddress : ownerAddress // ignore: cast_nullable_to_non_nullable
as Address,rootAddress: null == rootAddress ? _self.rootAddress : rootAddress // ignore: cast_nullable_to_non_nullable
as Address,tokenWalletAddress: null == tokenWalletAddress ? _self.tokenWalletAddress : tokenWalletAddress // ignore: cast_nullable_to_non_nullable
as Address,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of TokenBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get ownerAddress {
  
  return $AddressCopyWith<$Res>(_self.ownerAddress, (value) {
    return _then(_self.copyWith(ownerAddress: value));
  });
}/// Create a copy of TokenBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get rootAddress {
  
  return $AddressCopyWith<$Res>(_self.rootAddress, (value) {
    return _then(_self.copyWith(rootAddress: value));
  });
}/// Create a copy of TokenBalanceModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get tokenWalletAddress {
  
  return $AddressCopyWith<$Res>(_self.tokenWalletAddress, (value) {
    return _then(_self.copyWith(tokenWalletAddress: value));
  });
}
}

// dart format on
