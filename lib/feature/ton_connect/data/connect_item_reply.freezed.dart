// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_item_reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ConnectItemReply _$ConnectItemReplyFromJson(
  Map<String, dynamic> json
) {
        switch (json['name']) {
                  case 'ton_addr':
          return TonAddressItemReply.fromJson(
            json
          );
                case 'ton_proof':
          return TonProofItemReplySuccess.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'name',
  'ConnectItemReply',
  'Invalid union type "${json['name']}"!'
);
        }
      
}

/// @nodoc
mixin _$ConnectItemReply {



  /// Serializes this ConnectItemReply to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectItemReply);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectItemReply()';
}


}

/// @nodoc
class $ConnectItemReplyCopyWith<$Res>  {
$ConnectItemReplyCopyWith(ConnectItemReply _, $Res Function(ConnectItemReply) __);
}


/// Adds pattern-matching-related methods to [ConnectItemReply].
extension ConnectItemReplyPatterns on ConnectItemReply {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TonAddressItemReply value)?  tonAddress,TResult Function( TonProofItemReplySuccess value)?  tonProofSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TonAddressItemReply() when tonAddress != null:
return tonAddress(_that);case TonProofItemReplySuccess() when tonProofSuccess != null:
return tonProofSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TonAddressItemReply value)  tonAddress,required TResult Function( TonProofItemReplySuccess value)  tonProofSuccess,}){
final _that = this;
switch (_that) {
case TonAddressItemReply():
return tonAddress(_that);case TonProofItemReplySuccess():
return tonProofSuccess(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TonAddressItemReply value)?  tonAddress,TResult? Function( TonProofItemReplySuccess value)?  tonProofSuccess,}){
final _that = this;
switch (_that) {
case TonAddressItemReply() when tonAddress != null:
return tonAddress(_that);case TonProofItemReplySuccess() when tonProofSuccess != null:
return tonProofSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Address address,  TonNetwork network,  PublicKey publicKey,  String walletStateInit)?  tonAddress,TResult Function( TonProof proof)?  tonProofSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TonAddressItemReply() when tonAddress != null:
return tonAddress(_that.address,_that.network,_that.publicKey,_that.walletStateInit);case TonProofItemReplySuccess() when tonProofSuccess != null:
return tonProofSuccess(_that.proof);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Address address,  TonNetwork network,  PublicKey publicKey,  String walletStateInit)  tonAddress,required TResult Function( TonProof proof)  tonProofSuccess,}) {final _that = this;
switch (_that) {
case TonAddressItemReply():
return tonAddress(_that.address,_that.network,_that.publicKey,_that.walletStateInit);case TonProofItemReplySuccess():
return tonProofSuccess(_that.proof);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Address address,  TonNetwork network,  PublicKey publicKey,  String walletStateInit)?  tonAddress,TResult? Function( TonProof proof)?  tonProofSuccess,}) {final _that = this;
switch (_that) {
case TonAddressItemReply() when tonAddress != null:
return tonAddress(_that.address,_that.network,_that.publicKey,_that.walletStateInit);case TonProofItemReplySuccess() when tonProofSuccess != null:
return tonProofSuccess(_that.proof);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class TonAddressItemReply implements ConnectItemReply {
  const TonAddressItemReply({required this.address, required this.network, required this.publicKey, required this.walletStateInit, final  String? $type}): $type = $type ?? 'ton_addr';
  factory TonAddressItemReply.fromJson(Map<String, dynamic> json) => _$TonAddressItemReplyFromJson(json);

 final  Address address;
 final  TonNetwork network;
 final  PublicKey publicKey;
 final  String walletStateInit;

@JsonKey(name: 'name')
final String $type;


/// Create a copy of ConnectItemReply
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonAddressItemReplyCopyWith<TonAddressItemReply> get copyWith => _$TonAddressItemReplyCopyWithImpl<TonAddressItemReply>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TonAddressItemReplyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonAddressItemReply&&(identical(other.address, address) || other.address == address)&&(identical(other.network, network) || other.network == network)&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey)&&(identical(other.walletStateInit, walletStateInit) || other.walletStateInit == walletStateInit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,network,publicKey,walletStateInit);

@override
String toString() {
  return 'ConnectItemReply.tonAddress(address: $address, network: $network, publicKey: $publicKey, walletStateInit: $walletStateInit)';
}


}

/// @nodoc
abstract mixin class $TonAddressItemReplyCopyWith<$Res> implements $ConnectItemReplyCopyWith<$Res> {
  factory $TonAddressItemReplyCopyWith(TonAddressItemReply value, $Res Function(TonAddressItemReply) _then) = _$TonAddressItemReplyCopyWithImpl;
@useResult
$Res call({
 Address address, TonNetwork network, PublicKey publicKey, String walletStateInit
});


$AddressCopyWith<$Res> get address;$PublicKeyCopyWith<$Res> get publicKey;

}
/// @nodoc
class _$TonAddressItemReplyCopyWithImpl<$Res>
    implements $TonAddressItemReplyCopyWith<$Res> {
  _$TonAddressItemReplyCopyWithImpl(this._self, this._then);

  final TonAddressItemReply _self;
  final $Res Function(TonAddressItemReply) _then;

/// Create a copy of ConnectItemReply
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? address = null,Object? network = null,Object? publicKey = null,Object? walletStateInit = null,}) {
  return _then(TonAddressItemReply(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address,network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as TonNetwork,publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as PublicKey,walletStateInit: null == walletStateInit ? _self.walletStateInit : walletStateInit // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ConnectItemReply
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressCopyWith<$Res> get address {
  
  return $AddressCopyWith<$Res>(_self.address, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of ConnectItemReply
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicKeyCopyWith<$Res> get publicKey {
  
  return $PublicKeyCopyWith<$Res>(_self.publicKey, (value) {
    return _then(_self.copyWith(publicKey: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class TonProofItemReplySuccess implements ConnectItemReply {
  const TonProofItemReplySuccess({required this.proof, final  String? $type}): $type = $type ?? 'ton_proof';
  factory TonProofItemReplySuccess.fromJson(Map<String, dynamic> json) => _$TonProofItemReplySuccessFromJson(json);

 final  TonProof proof;

@JsonKey(name: 'name')
final String $type;


/// Create a copy of ConnectItemReply
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonProofItemReplySuccessCopyWith<TonProofItemReplySuccess> get copyWith => _$TonProofItemReplySuccessCopyWithImpl<TonProofItemReplySuccess>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TonProofItemReplySuccessToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonProofItemReplySuccess&&(identical(other.proof, proof) || other.proof == proof));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,proof);

@override
String toString() {
  return 'ConnectItemReply.tonProofSuccess(proof: $proof)';
}


}

/// @nodoc
abstract mixin class $TonProofItemReplySuccessCopyWith<$Res> implements $ConnectItemReplyCopyWith<$Res> {
  factory $TonProofItemReplySuccessCopyWith(TonProofItemReplySuccess value, $Res Function(TonProofItemReplySuccess) _then) = _$TonProofItemReplySuccessCopyWithImpl;
@useResult
$Res call({
 TonProof proof
});


$TonProofCopyWith<$Res> get proof;

}
/// @nodoc
class _$TonProofItemReplySuccessCopyWithImpl<$Res>
    implements $TonProofItemReplySuccessCopyWith<$Res> {
  _$TonProofItemReplySuccessCopyWithImpl(this._self, this._then);

  final TonProofItemReplySuccess _self;
  final $Res Function(TonProofItemReplySuccess) _then;

/// Create a copy of ConnectItemReply
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? proof = null,}) {
  return _then(TonProofItemReplySuccess(
proof: null == proof ? _self.proof : proof // ignore: cast_nullable_to_non_nullable
as TonProof,
  ));
}

/// Create a copy of ConnectItemReply
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TonProofCopyWith<$Res> get proof {
  
  return $TonProofCopyWith<$Res>(_self.proof, (value) {
    return _then(_self.copyWith(proof: value));
  });
}
}

// dart format on
