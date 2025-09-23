// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'default_active_asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DefaultActiveAsset {
  @AddressStringConverter()
  Address get address;

  /// Create a copy of DefaultActiveAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DefaultActiveAssetCopyWith<DefaultActiveAsset> get copyWith =>
      _$DefaultActiveAssetCopyWithImpl<DefaultActiveAsset>(
          this as DefaultActiveAsset, _$identity);

  /// Serializes this DefaultActiveAsset to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DefaultActiveAsset &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, address);

  @override
  String toString() {
    return 'DefaultActiveAsset(address: $address)';
  }
}

/// @nodoc
abstract mixin class $DefaultActiveAssetCopyWith<$Res> {
  factory $DefaultActiveAssetCopyWith(
          DefaultActiveAsset value, $Res Function(DefaultActiveAsset) _then) =
      _$DefaultActiveAssetCopyWithImpl;
  @useResult
  $Res call({@AddressStringConverter() Address address});

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class _$DefaultActiveAssetCopyWithImpl<$Res>
    implements $DefaultActiveAssetCopyWith<$Res> {
  _$DefaultActiveAssetCopyWithImpl(this._self, this._then);

  final DefaultActiveAsset _self;
  final $Res Function(DefaultActiveAsset) _then;

  /// Create a copy of DefaultActiveAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_self.copyWith(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of DefaultActiveAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _DefaultActiveAsset implements DefaultActiveAsset {
  _DefaultActiveAsset({@AddressStringConverter() required this.address});
  factory _DefaultActiveAsset.fromJson(Map<String, dynamic> json) =>
      _$DefaultActiveAssetFromJson(json);

  @override
  @AddressStringConverter()
  final Address address;

  /// Create a copy of DefaultActiveAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DefaultActiveAssetCopyWith<_DefaultActiveAsset> get copyWith =>
      __$DefaultActiveAssetCopyWithImpl<_DefaultActiveAsset>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DefaultActiveAssetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DefaultActiveAsset &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, address);

  @override
  String toString() {
    return 'DefaultActiveAsset(address: $address)';
  }
}

/// @nodoc
abstract mixin class _$DefaultActiveAssetCopyWith<$Res>
    implements $DefaultActiveAssetCopyWith<$Res> {
  factory _$DefaultActiveAssetCopyWith(
          _DefaultActiveAsset value, $Res Function(_DefaultActiveAsset) _then) =
      __$DefaultActiveAssetCopyWithImpl;
  @override
  @useResult
  $Res call({@AddressStringConverter() Address address});

  @override
  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$DefaultActiveAssetCopyWithImpl<$Res>
    implements _$DefaultActiveAssetCopyWith<$Res> {
  __$DefaultActiveAssetCopyWithImpl(this._self, this._then);

  final _DefaultActiveAsset _self;
  final $Res Function(_DefaultActiveAsset) _then;

  /// Create a copy of DefaultActiveAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? address = null,
  }) {
    return _then(_DefaultActiveAsset(
      address: null == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of DefaultActiveAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_self.address, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

// dart format on
