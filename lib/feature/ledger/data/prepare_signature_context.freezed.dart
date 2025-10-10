// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prepare_signature_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrepareSignatureContext {

 TonWallet get wallet; String get asset; int get decimals;
/// Create a copy of PrepareSignatureContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrepareSignatureContextCopyWith<PrepareSignatureContext> get copyWith => _$PrepareSignatureContextCopyWithImpl<PrepareSignatureContext>(this as PrepareSignatureContext, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareSignatureContext&&(identical(other.wallet, wallet) || other.wallet == wallet)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}


@override
int get hashCode => Object.hash(runtimeType,wallet,asset,decimals);

@override
String toString() {
  return 'PrepareSignatureContext(wallet: $wallet, asset: $asset, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class $PrepareSignatureContextCopyWith<$Res>  {
  factory $PrepareSignatureContextCopyWith(PrepareSignatureContext value, $Res Function(PrepareSignatureContext) _then) = _$PrepareSignatureContextCopyWithImpl;
@useResult
$Res call({
 TonWallet wallet, String asset, int decimals
});




}
/// @nodoc
class _$PrepareSignatureContextCopyWithImpl<$Res>
    implements $PrepareSignatureContextCopyWith<$Res> {
  _$PrepareSignatureContextCopyWithImpl(this._self, this._then);

  final PrepareSignatureContext _self;
  final $Res Function(PrepareSignatureContext) _then;

/// Create a copy of PrepareSignatureContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wallet = null,Object? asset = null,Object? decimals = null,}) {
  return _then(_self.copyWith(
wallet: null == wallet ? _self.wallet : wallet // ignore: cast_nullable_to_non_nullable
as TonWallet,asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PrepareSignatureContext].
extension PrepareSignatureContextPatterns on PrepareSignatureContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PrepareSignatureContextDeploy value)?  deploy,TResult Function( PrepareSignatureContextConfirm value)?  confirm,TResult Function( PrepareSignatureContextTransfer value)?  transfer,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PrepareSignatureContextDeploy() when deploy != null:
return deploy(_that);case PrepareSignatureContextConfirm() when confirm != null:
return confirm(_that);case PrepareSignatureContextTransfer() when transfer != null:
return transfer(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PrepareSignatureContextDeploy value)  deploy,required TResult Function( PrepareSignatureContextConfirm value)  confirm,required TResult Function( PrepareSignatureContextTransfer value)  transfer,}){
final _that = this;
switch (_that) {
case PrepareSignatureContextDeploy():
return deploy(_that);case PrepareSignatureContextConfirm():
return confirm(_that);case PrepareSignatureContextTransfer():
return transfer(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PrepareSignatureContextDeploy value)?  deploy,TResult? Function( PrepareSignatureContextConfirm value)?  confirm,TResult? Function( PrepareSignatureContextTransfer value)?  transfer,}){
final _that = this;
switch (_that) {
case PrepareSignatureContextDeploy() when deploy != null:
return deploy(_that);case PrepareSignatureContextConfirm() when confirm != null:
return confirm(_that);case PrepareSignatureContextTransfer() when transfer != null:
return transfer(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( TonWallet wallet,  String asset,  int decimals)?  deploy,TResult Function( TonWallet wallet,  String asset,  int decimals)?  confirm,TResult Function( TonWallet wallet,  String asset,  int decimals,  PublicKey custodian)?  transfer,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PrepareSignatureContextDeploy() when deploy != null:
return deploy(_that.wallet,_that.asset,_that.decimals);case PrepareSignatureContextConfirm() when confirm != null:
return confirm(_that.wallet,_that.asset,_that.decimals);case PrepareSignatureContextTransfer() when transfer != null:
return transfer(_that.wallet,_that.asset,_that.decimals,_that.custodian);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( TonWallet wallet,  String asset,  int decimals)  deploy,required TResult Function( TonWallet wallet,  String asset,  int decimals)  confirm,required TResult Function( TonWallet wallet,  String asset,  int decimals,  PublicKey custodian)  transfer,}) {final _that = this;
switch (_that) {
case PrepareSignatureContextDeploy():
return deploy(_that.wallet,_that.asset,_that.decimals);case PrepareSignatureContextConfirm():
return confirm(_that.wallet,_that.asset,_that.decimals);case PrepareSignatureContextTransfer():
return transfer(_that.wallet,_that.asset,_that.decimals,_that.custodian);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( TonWallet wallet,  String asset,  int decimals)?  deploy,TResult? Function( TonWallet wallet,  String asset,  int decimals)?  confirm,TResult? Function( TonWallet wallet,  String asset,  int decimals,  PublicKey custodian)?  transfer,}) {final _that = this;
switch (_that) {
case PrepareSignatureContextDeploy() when deploy != null:
return deploy(_that.wallet,_that.asset,_that.decimals);case PrepareSignatureContextConfirm() when confirm != null:
return confirm(_that.wallet,_that.asset,_that.decimals);case PrepareSignatureContextTransfer() when transfer != null:
return transfer(_that.wallet,_that.asset,_that.decimals,_that.custodian);case _:
  return null;

}
}

}

/// @nodoc


class PrepareSignatureContextDeploy implements PrepareSignatureContext {
  const PrepareSignatureContextDeploy({required this.wallet, required this.asset, required this.decimals});
  

@override final  TonWallet wallet;
@override final  String asset;
@override final  int decimals;

/// Create a copy of PrepareSignatureContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrepareSignatureContextDeployCopyWith<PrepareSignatureContextDeploy> get copyWith => _$PrepareSignatureContextDeployCopyWithImpl<PrepareSignatureContextDeploy>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareSignatureContextDeploy&&(identical(other.wallet, wallet) || other.wallet == wallet)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}


@override
int get hashCode => Object.hash(runtimeType,wallet,asset,decimals);

@override
String toString() {
  return 'PrepareSignatureContext.deploy(wallet: $wallet, asset: $asset, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class $PrepareSignatureContextDeployCopyWith<$Res> implements $PrepareSignatureContextCopyWith<$Res> {
  factory $PrepareSignatureContextDeployCopyWith(PrepareSignatureContextDeploy value, $Res Function(PrepareSignatureContextDeploy) _then) = _$PrepareSignatureContextDeployCopyWithImpl;
@override @useResult
$Res call({
 TonWallet wallet, String asset, int decimals
});




}
/// @nodoc
class _$PrepareSignatureContextDeployCopyWithImpl<$Res>
    implements $PrepareSignatureContextDeployCopyWith<$Res> {
  _$PrepareSignatureContextDeployCopyWithImpl(this._self, this._then);

  final PrepareSignatureContextDeploy _self;
  final $Res Function(PrepareSignatureContextDeploy) _then;

/// Create a copy of PrepareSignatureContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wallet = null,Object? asset = null,Object? decimals = null,}) {
  return _then(PrepareSignatureContextDeploy(
wallet: null == wallet ? _self.wallet : wallet // ignore: cast_nullable_to_non_nullable
as TonWallet,asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class PrepareSignatureContextConfirm implements PrepareSignatureContext {
  const PrepareSignatureContextConfirm({required this.wallet, required this.asset, required this.decimals});
  

@override final  TonWallet wallet;
@override final  String asset;
@override final  int decimals;

/// Create a copy of PrepareSignatureContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrepareSignatureContextConfirmCopyWith<PrepareSignatureContextConfirm> get copyWith => _$PrepareSignatureContextConfirmCopyWithImpl<PrepareSignatureContextConfirm>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareSignatureContextConfirm&&(identical(other.wallet, wallet) || other.wallet == wallet)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}


@override
int get hashCode => Object.hash(runtimeType,wallet,asset,decimals);

@override
String toString() {
  return 'PrepareSignatureContext.confirm(wallet: $wallet, asset: $asset, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class $PrepareSignatureContextConfirmCopyWith<$Res> implements $PrepareSignatureContextCopyWith<$Res> {
  factory $PrepareSignatureContextConfirmCopyWith(PrepareSignatureContextConfirm value, $Res Function(PrepareSignatureContextConfirm) _then) = _$PrepareSignatureContextConfirmCopyWithImpl;
@override @useResult
$Res call({
 TonWallet wallet, String asset, int decimals
});




}
/// @nodoc
class _$PrepareSignatureContextConfirmCopyWithImpl<$Res>
    implements $PrepareSignatureContextConfirmCopyWith<$Res> {
  _$PrepareSignatureContextConfirmCopyWithImpl(this._self, this._then);

  final PrepareSignatureContextConfirm _self;
  final $Res Function(PrepareSignatureContextConfirm) _then;

/// Create a copy of PrepareSignatureContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wallet = null,Object? asset = null,Object? decimals = null,}) {
  return _then(PrepareSignatureContextConfirm(
wallet: null == wallet ? _self.wallet : wallet // ignore: cast_nullable_to_non_nullable
as TonWallet,asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class PrepareSignatureContextTransfer implements PrepareSignatureContext {
  const PrepareSignatureContextTransfer({required this.wallet, required this.asset, required this.decimals, required this.custodian});
  

@override final  TonWallet wallet;
@override final  String asset;
@override final  int decimals;
 final  PublicKey custodian;

/// Create a copy of PrepareSignatureContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrepareSignatureContextTransferCopyWith<PrepareSignatureContextTransfer> get copyWith => _$PrepareSignatureContextTransferCopyWithImpl<PrepareSignatureContextTransfer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareSignatureContextTransfer&&(identical(other.wallet, wallet) || other.wallet == wallet)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.custodian, custodian) || other.custodian == custodian));
}


@override
int get hashCode => Object.hash(runtimeType,wallet,asset,decimals,custodian);

@override
String toString() {
  return 'PrepareSignatureContext.transfer(wallet: $wallet, asset: $asset, decimals: $decimals, custodian: $custodian)';
}


}

/// @nodoc
abstract mixin class $PrepareSignatureContextTransferCopyWith<$Res> implements $PrepareSignatureContextCopyWith<$Res> {
  factory $PrepareSignatureContextTransferCopyWith(PrepareSignatureContextTransfer value, $Res Function(PrepareSignatureContextTransfer) _then) = _$PrepareSignatureContextTransferCopyWithImpl;
@override @useResult
$Res call({
 TonWallet wallet, String asset, int decimals, PublicKey custodian
});


$PublicKeyCopyWith<$Res> get custodian;

}
/// @nodoc
class _$PrepareSignatureContextTransferCopyWithImpl<$Res>
    implements $PrepareSignatureContextTransferCopyWith<$Res> {
  _$PrepareSignatureContextTransferCopyWithImpl(this._self, this._then);

  final PrepareSignatureContextTransfer _self;
  final $Res Function(PrepareSignatureContextTransfer) _then;

/// Create a copy of PrepareSignatureContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wallet = null,Object? asset = null,Object? decimals = null,Object? custodian = null,}) {
  return _then(PrepareSignatureContextTransfer(
wallet: null == wallet ? _self.wallet : wallet // ignore: cast_nullable_to_non_nullable
as TonWallet,asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,custodian: null == custodian ? _self.custodian : custodian // ignore: cast_nullable_to_non_nullable
as PublicKey,
  ));
}

/// Create a copy of PrepareSignatureContext
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicKeyCopyWith<$Res> get custodian {
  
  return $PublicKeyCopyWith<$Res>(_self.custodian, (value) {
    return _then(_self.copyWith(custodian: value));
  });
}
}

// dart format on
