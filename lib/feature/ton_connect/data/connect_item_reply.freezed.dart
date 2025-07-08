// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_item_reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConnectItemReply _$ConnectItemReplyFromJson(Map<String, dynamic> json) {
  switch (json['name']) {
    case 'ton_addr':
      return TonAddressItemReply.fromJson(json);
    case 'ton_proof':
      return TonProofItemReplySuccess.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'name', 'ConnectItemReply',
          'Invalid union type "${json['name']}"!');
  }
}

/// @nodoc
mixin _$ConnectItemReply {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address, TonNetwork network,
            PublicKey publicKey, String walletStateInit)
        tonAddress,
    required TResult Function(TonProof proof) tonProofSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address address, TonNetwork network, PublicKey publicKey,
            String walletStateInit)?
        tonAddress,
    TResult? Function(TonProof proof)? tonProofSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address, TonNetwork network, PublicKey publicKey,
            String walletStateInit)?
        tonAddress,
    TResult Function(TonProof proof)? tonProofSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonAddressItemReply value) tonAddress,
    required TResult Function(TonProofItemReplySuccess value) tonProofSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonAddressItemReply value)? tonAddress,
    TResult? Function(TonProofItemReplySuccess value)? tonProofSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonAddressItemReply value)? tonAddress,
    TResult Function(TonProofItemReplySuccess value)? tonProofSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ConnectItemReply to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectItemReplyCopyWith<$Res> {
  factory $ConnectItemReplyCopyWith(
          ConnectItemReply value, $Res Function(ConnectItemReply) then) =
      _$ConnectItemReplyCopyWithImpl<$Res, ConnectItemReply>;
}

/// @nodoc
class _$ConnectItemReplyCopyWithImpl<$Res, $Val extends ConnectItemReply>
    implements $ConnectItemReplyCopyWith<$Res> {
  _$ConnectItemReplyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TonAddressItemReplyImplCopyWith<$Res> {
  factory _$$TonAddressItemReplyImplCopyWith(_$TonAddressItemReplyImpl value,
          $Res Function(_$TonAddressItemReplyImpl) then) =
      __$$TonAddressItemReplyImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {Address address,
      TonNetwork network,
      PublicKey publicKey,
      String walletStateInit});

  $AddressCopyWith<$Res> get address;
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class __$$TonAddressItemReplyImplCopyWithImpl<$Res>
    extends _$ConnectItemReplyCopyWithImpl<$Res, _$TonAddressItemReplyImpl>
    implements _$$TonAddressItemReplyImplCopyWith<$Res> {
  __$$TonAddressItemReplyImplCopyWithImpl(_$TonAddressItemReplyImpl _value,
      $Res Function(_$TonAddressItemReplyImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? network = null,
    Object? publicKey = null,
    Object? walletStateInit = null,
  }) {
    return _then(_$TonAddressItemReplyImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as TonNetwork,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      walletStateInit: null == walletStateInit
          ? _value.walletStateInit
          : walletStateInit // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value));
    });
  }

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get publicKey {
    return $PublicKeyCopyWith<$Res>(_value.publicKey, (value) {
      return _then(_value.copyWith(publicKey: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TonAddressItemReplyImpl implements TonAddressItemReply {
  const _$TonAddressItemReplyImpl(
      {required this.address,
      required this.network,
      required this.publicKey,
      required this.walletStateInit,
      final String? $type})
      : $type = $type ?? 'ton_addr';

  factory _$TonAddressItemReplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonAddressItemReplyImplFromJson(json);

  @override
  final Address address;
  @override
  final TonNetwork network;
  @override
  final PublicKey publicKey;
  @override
  final String walletStateInit;

  @JsonKey(name: 'name')
  final String $type;

  @override
  String toString() {
    return 'ConnectItemReply.tonAddress(address: $address, network: $network, publicKey: $publicKey, walletStateInit: $walletStateInit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonAddressItemReplyImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.walletStateInit, walletStateInit) ||
                other.walletStateInit == walletStateInit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, address, network, publicKey, walletStateInit);

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonAddressItemReplyImplCopyWith<_$TonAddressItemReplyImpl> get copyWith =>
      __$$TonAddressItemReplyImplCopyWithImpl<_$TonAddressItemReplyImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address, TonNetwork network,
            PublicKey publicKey, String walletStateInit)
        tonAddress,
    required TResult Function(TonProof proof) tonProofSuccess,
  }) {
    return tonAddress(address, network, publicKey, walletStateInit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address address, TonNetwork network, PublicKey publicKey,
            String walletStateInit)?
        tonAddress,
    TResult? Function(TonProof proof)? tonProofSuccess,
  }) {
    return tonAddress?.call(address, network, publicKey, walletStateInit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address, TonNetwork network, PublicKey publicKey,
            String walletStateInit)?
        tonAddress,
    TResult Function(TonProof proof)? tonProofSuccess,
    required TResult orElse(),
  }) {
    if (tonAddress != null) {
      return tonAddress(address, network, publicKey, walletStateInit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonAddressItemReply value) tonAddress,
    required TResult Function(TonProofItemReplySuccess value) tonProofSuccess,
  }) {
    return tonAddress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonAddressItemReply value)? tonAddress,
    TResult? Function(TonProofItemReplySuccess value)? tonProofSuccess,
  }) {
    return tonAddress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonAddressItemReply value)? tonAddress,
    TResult Function(TonProofItemReplySuccess value)? tonProofSuccess,
    required TResult orElse(),
  }) {
    if (tonAddress != null) {
      return tonAddress(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TonAddressItemReplyImplToJson(
      this,
    );
  }
}

abstract class TonAddressItemReply implements ConnectItemReply {
  const factory TonAddressItemReply(
      {required final Address address,
      required final TonNetwork network,
      required final PublicKey publicKey,
      required final String walletStateInit}) = _$TonAddressItemReplyImpl;

  factory TonAddressItemReply.fromJson(Map<String, dynamic> json) =
      _$TonAddressItemReplyImpl.fromJson;

  Address get address;
  TonNetwork get network;
  PublicKey get publicKey;
  String get walletStateInit;

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonAddressItemReplyImplCopyWith<_$TonAddressItemReplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TonProofItemReplySuccessImplCopyWith<$Res> {
  factory _$$TonProofItemReplySuccessImplCopyWith(
          _$TonProofItemReplySuccessImpl value,
          $Res Function(_$TonProofItemReplySuccessImpl) then) =
      __$$TonProofItemReplySuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TonProof proof});

  $TonProofCopyWith<$Res> get proof;
}

/// @nodoc
class __$$TonProofItemReplySuccessImplCopyWithImpl<$Res>
    extends _$ConnectItemReplyCopyWithImpl<$Res, _$TonProofItemReplySuccessImpl>
    implements _$$TonProofItemReplySuccessImplCopyWith<$Res> {
  __$$TonProofItemReplySuccessImplCopyWithImpl(
      _$TonProofItemReplySuccessImpl _value,
      $Res Function(_$TonProofItemReplySuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proof = null,
  }) {
    return _then(_$TonProofItemReplySuccessImpl(
      proof: null == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as TonProof,
    ));
  }

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonProofCopyWith<$Res> get proof {
    return $TonProofCopyWith<$Res>(_value.proof, (value) {
      return _then(_value.copyWith(proof: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TonProofItemReplySuccessImpl implements TonProofItemReplySuccess {
  const _$TonProofItemReplySuccessImpl(
      {required this.proof, final String? $type})
      : $type = $type ?? 'ton_proof';

  factory _$TonProofItemReplySuccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonProofItemReplySuccessImplFromJson(json);

  @override
  final TonProof proof;

  @JsonKey(name: 'name')
  final String $type;

  @override
  String toString() {
    return 'ConnectItemReply.tonProofSuccess(proof: $proof)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonProofItemReplySuccessImpl &&
            (identical(other.proof, proof) || other.proof == proof));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, proof);

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonProofItemReplySuccessImplCopyWith<_$TonProofItemReplySuccessImpl>
      get copyWith => __$$TonProofItemReplySuccessImplCopyWithImpl<
          _$TonProofItemReplySuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address, TonNetwork network,
            PublicKey publicKey, String walletStateInit)
        tonAddress,
    required TResult Function(TonProof proof) tonProofSuccess,
  }) {
    return tonProofSuccess(proof);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address address, TonNetwork network, PublicKey publicKey,
            String walletStateInit)?
        tonAddress,
    TResult? Function(TonProof proof)? tonProofSuccess,
  }) {
    return tonProofSuccess?.call(proof);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address, TonNetwork network, PublicKey publicKey,
            String walletStateInit)?
        tonAddress,
    TResult Function(TonProof proof)? tonProofSuccess,
    required TResult orElse(),
  }) {
    if (tonProofSuccess != null) {
      return tonProofSuccess(proof);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonAddressItemReply value) tonAddress,
    required TResult Function(TonProofItemReplySuccess value) tonProofSuccess,
  }) {
    return tonProofSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonAddressItemReply value)? tonAddress,
    TResult? Function(TonProofItemReplySuccess value)? tonProofSuccess,
  }) {
    return tonProofSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonAddressItemReply value)? tonAddress,
    TResult Function(TonProofItemReplySuccess value)? tonProofSuccess,
    required TResult orElse(),
  }) {
    if (tonProofSuccess != null) {
      return tonProofSuccess(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TonProofItemReplySuccessImplToJson(
      this,
    );
  }
}

abstract class TonProofItemReplySuccess implements ConnectItemReply {
  const factory TonProofItemReplySuccess({required final TonProof proof}) =
      _$TonProofItemReplySuccessImpl;

  factory TonProofItemReplySuccess.fromJson(Map<String, dynamic> json) =
      _$TonProofItemReplySuccessImpl.fromJson;

  TonProof get proof;

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonProofItemReplySuccessImplCopyWith<_$TonProofItemReplySuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}
