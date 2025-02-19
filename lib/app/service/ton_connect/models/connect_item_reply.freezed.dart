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
      return _TonAddress.fromJson(json);
    case 'ton_proof':
      return _TonProofSuccess.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'name', 'ConnectItemReply',
          'Invalid union type "${json['name']}"!');
  }
}

/// @nodoc
mixin _$ConnectItemReply {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address, String network, String publicKey,
            String walletStateInit)
        tonAddress,
    required TResult Function() tonProofSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address address, String network, String publicKey,
            String walletStateInit)?
        tonAddress,
    TResult? Function()? tonProofSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address, String network, String publicKey,
            String walletStateInit)?
        tonAddress,
    TResult Function()? tonProofSuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TonAddress value) tonAddress,
    required TResult Function(_TonProofSuccess value) tonProofSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TonAddress value)? tonAddress,
    TResult? Function(_TonProofSuccess value)? tonProofSuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TonAddress value)? tonAddress,
    TResult Function(_TonProofSuccess value)? tonProofSuccess,
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
abstract class _$$TonAddressImplCopyWith<$Res> {
  factory _$$TonAddressImplCopyWith(
          _$TonAddressImpl value, $Res Function(_$TonAddressImpl) then) =
      __$$TonAddressImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {Address address,
      String network,
      String publicKey,
      String walletStateInit});

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$$TonAddressImplCopyWithImpl<$Res>
    extends _$ConnectItemReplyCopyWithImpl<$Res, _$TonAddressImpl>
    implements _$$TonAddressImplCopyWith<$Res> {
  __$$TonAddressImplCopyWithImpl(
      _$TonAddressImpl _value, $Res Function(_$TonAddressImpl) _then)
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
    return _then(_$TonAddressImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      network: null == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
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
}

/// @nodoc
@JsonSerializable()
class _$TonAddressImpl implements _TonAddress {
  const _$TonAddressImpl(
      {required this.address,
      required this.network,
      required this.publicKey,
      required this.walletStateInit,
      final String? $type})
      : $type = $type ?? 'ton_addr';

  factory _$TonAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonAddressImplFromJson(json);

  @override
  final Address address;
  @override
  final String network;
  @override
  final String publicKey;
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
            other is _$TonAddressImpl &&
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
  _$$TonAddressImplCopyWith<_$TonAddressImpl> get copyWith =>
      __$$TonAddressImplCopyWithImpl<_$TonAddressImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address, String network, String publicKey,
            String walletStateInit)
        tonAddress,
    required TResult Function() tonProofSuccess,
  }) {
    return tonAddress(address, network, publicKey, walletStateInit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address address, String network, String publicKey,
            String walletStateInit)?
        tonAddress,
    TResult? Function()? tonProofSuccess,
  }) {
    return tonAddress?.call(address, network, publicKey, walletStateInit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address, String network, String publicKey,
            String walletStateInit)?
        tonAddress,
    TResult Function()? tonProofSuccess,
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
    required TResult Function(_TonAddress value) tonAddress,
    required TResult Function(_TonProofSuccess value) tonProofSuccess,
  }) {
    return tonAddress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TonAddress value)? tonAddress,
    TResult? Function(_TonProofSuccess value)? tonProofSuccess,
  }) {
    return tonAddress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TonAddress value)? tonAddress,
    TResult Function(_TonProofSuccess value)? tonProofSuccess,
    required TResult orElse(),
  }) {
    if (tonAddress != null) {
      return tonAddress(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TonAddressImplToJson(
      this,
    );
  }
}

abstract class _TonAddress implements ConnectItemReply {
  const factory _TonAddress(
      {required final Address address,
      required final String network,
      required final String publicKey,
      required final String walletStateInit}) = _$TonAddressImpl;

  factory _TonAddress.fromJson(Map<String, dynamic> json) =
      _$TonAddressImpl.fromJson;

  Address get address;
  String get network;
  String get publicKey;
  String get walletStateInit;

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonAddressImplCopyWith<_$TonAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TonProofSuccessImplCopyWith<$Res> {
  factory _$$TonProofSuccessImplCopyWith(_$TonProofSuccessImpl value,
          $Res Function(_$TonProofSuccessImpl) then) =
      __$$TonProofSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TonProofSuccessImplCopyWithImpl<$Res>
    extends _$ConnectItemReplyCopyWithImpl<$Res, _$TonProofSuccessImpl>
    implements _$$TonProofSuccessImplCopyWith<$Res> {
  __$$TonProofSuccessImplCopyWithImpl(
      _$TonProofSuccessImpl _value, $Res Function(_$TonProofSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectItemReply
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$TonProofSuccessImpl implements _TonProofSuccess {
  const _$TonProofSuccessImpl({final String? $type})
      : $type = $type ?? 'ton_proof';

  factory _$TonProofSuccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonProofSuccessImplFromJson(json);

  @JsonKey(name: 'name')
  final String $type;

  @override
  String toString() {
    return 'ConnectItemReply.tonProofSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TonProofSuccessImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address, String network, String publicKey,
            String walletStateInit)
        tonAddress,
    required TResult Function() tonProofSuccess,
  }) {
    return tonProofSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address address, String network, String publicKey,
            String walletStateInit)?
        tonAddress,
    TResult? Function()? tonProofSuccess,
  }) {
    return tonProofSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address, String network, String publicKey,
            String walletStateInit)?
        tonAddress,
    TResult Function()? tonProofSuccess,
    required TResult orElse(),
  }) {
    if (tonProofSuccess != null) {
      return tonProofSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TonAddress value) tonAddress,
    required TResult Function(_TonProofSuccess value) tonProofSuccess,
  }) {
    return tonProofSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TonAddress value)? tonAddress,
    TResult? Function(_TonProofSuccess value)? tonProofSuccess,
  }) {
    return tonProofSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TonAddress value)? tonAddress,
    TResult Function(_TonProofSuccess value)? tonProofSuccess,
    required TResult orElse(),
  }) {
    if (tonProofSuccess != null) {
      return tonProofSuccess(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TonProofSuccessImplToJson(
      this,
    );
  }
}

abstract class _TonProofSuccess implements ConnectItemReply {
  const factory _TonProofSuccess() = _$TonProofSuccessImpl;

  factory _TonProofSuccess.fromJson(Map<String, dynamic> json) =
      _$TonProofSuccessImpl.fromJson;
}
