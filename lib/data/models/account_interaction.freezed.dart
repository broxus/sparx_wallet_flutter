// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_interaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountInteraction {
  Address get address;
  PublicKey get publicKey;
  WalletContractType get contractType;

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccountInteractionCopyWith<AccountInteraction> get copyWith =>
      _$AccountInteractionCopyWithImpl<AccountInteraction>(
          this as AccountInteraction, _$identity);

  /// Serializes this AccountInteraction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccountInteraction &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.contractType, contractType) ||
                other.contractType == contractType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, address, publicKey, contractType);

  @override
  String toString() {
    return 'AccountInteraction(address: $address, publicKey: $publicKey, contractType: $contractType)';
  }
}

/// @nodoc
abstract mixin class $AccountInteractionCopyWith<$Res> {
  factory $AccountInteractionCopyWith(
          AccountInteraction value, $Res Function(AccountInteraction) _then) =
      _$AccountInteractionCopyWithImpl;
  @useResult
  $Res call(
      {Address address, PublicKey publicKey, WalletContractType contractType});

  $AddressCopyWith<$Res> get address;
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class _$AccountInteractionCopyWithImpl<$Res>
    implements $AccountInteractionCopyWith<$Res> {
  _$AccountInteractionCopyWithImpl(this._self, this._then);

  final AccountInteraction _self;
  final $Res Function(AccountInteraction) _then;

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? publicKey = null,
    Object? contractType = null,
  }) {
    return _then(_self.copyWith(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: null == publicKey
          ? _self.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      contractType: null == contractType
          ? _self.contractType
          : contractType // ignore: cast_nullable_to_non_nullable
              as WalletContractType,
    ));
  }

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }

  /// Create a copy of AccountInteraction
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
class _AccountInteraction implements AccountInteraction {
  const _AccountInteraction(
      {required this.address,
      required this.publicKey,
      required this.contractType});
  factory _AccountInteraction.fromJson(Map<String, dynamic> json) =>
      _$AccountInteractionFromJson(json);

  @override
  final Address address;
  @override
  final PublicKey publicKey;
  @override
  final WalletContractType contractType;

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AccountInteractionCopyWith<_AccountInteraction> get copyWith =>
      __$AccountInteractionCopyWithImpl<_AccountInteraction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AccountInteractionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AccountInteraction &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.contractType, contractType) ||
                other.contractType == contractType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, address, publicKey, contractType);

  @override
  String toString() {
    return 'AccountInteraction(address: $address, publicKey: $publicKey, contractType: $contractType)';
  }
}

/// @nodoc
abstract mixin class _$AccountInteractionCopyWith<$Res>
    implements $AccountInteractionCopyWith<$Res> {
  factory _$AccountInteractionCopyWith(
          _AccountInteraction value, $Res Function(_AccountInteraction) _then) =
      __$AccountInteractionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Address address, PublicKey publicKey, WalletContractType contractType});

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class __$AccountInteractionCopyWithImpl<$Res>
    implements _$AccountInteractionCopyWith<$Res> {
  __$AccountInteractionCopyWithImpl(this._self, this._then);

  final _AccountInteraction _self;
  final $Res Function(_AccountInteraction) _then;

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? address = null,
    Object? publicKey = null,
    Object? contractType = null,
  }) {
    return _then(_AccountInteraction(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: null == publicKey
          ? _self.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      contractType: null == contractType
          ? _self.contractType
          : contractType // ignore: cast_nullable_to_non_nullable
              as WalletContractType,
    ));
  }

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get publicKey {
    return $PublicKeyCopyWith<$Res>(_self.publicKey, (value) {
      return _then(_self.copyWith(publicKey: value));
    });
  }
}

// dart format on
