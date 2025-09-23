// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nft_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NftInformation {
  String? get marketplaceUrl; // TODO проверить ок ли конвертер
  @AddressListConverter()
  List<Address>? get defaultCollections;

  /// Create a copy of NftInformation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NftInformationCopyWith<NftInformation> get copyWith =>
      _$NftInformationCopyWithImpl<NftInformation>(
          this as NftInformation, _$identity);

  /// Serializes this NftInformation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NftInformation &&
            (identical(other.marketplaceUrl, marketplaceUrl) ||
                other.marketplaceUrl == marketplaceUrl) &&
            const DeepCollectionEquality()
                .equals(other.defaultCollections, defaultCollections));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, marketplaceUrl,
      const DeepCollectionEquality().hash(defaultCollections));

  @override
  String toString() {
    return 'NftInformation(marketplaceUrl: $marketplaceUrl, defaultCollections: $defaultCollections)';
  }
}

/// @nodoc
abstract mixin class $NftInformationCopyWith<$Res> {
  factory $NftInformationCopyWith(
          NftInformation value, $Res Function(NftInformation) _then) =
      _$NftInformationCopyWithImpl;
  @useResult
  $Res call(
      {String? marketplaceUrl,
      @AddressListConverter() List<Address>? defaultCollections});
}

/// @nodoc
class _$NftInformationCopyWithImpl<$Res>
    implements $NftInformationCopyWith<$Res> {
  _$NftInformationCopyWithImpl(this._self, this._then);

  final NftInformation _self;
  final $Res Function(NftInformation) _then;

  /// Create a copy of NftInformation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? marketplaceUrl = freezed,
    Object? defaultCollections = freezed,
  }) {
    return _then(_self.copyWith(
      marketplaceUrl: freezed == marketplaceUrl
          ? _self.marketplaceUrl
          : marketplaceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultCollections: freezed == defaultCollections
          ? _self.defaultCollections
          : defaultCollections // ignore: cast_nullable_to_non_nullable
              as List<Address>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _NftInformation implements NftInformation {
  const _NftInformation(
      {this.marketplaceUrl,
      @AddressListConverter() final List<Address>? defaultCollections})
      : _defaultCollections = defaultCollections;
  factory _NftInformation.fromJson(Map<String, dynamic> json) =>
      _$NftInformationFromJson(json);

  @override
  final String? marketplaceUrl;
// TODO проверить ок ли конвертер
  final List<Address>? _defaultCollections;
// TODO проверить ок ли конвертер
  @override
  @AddressListConverter()
  List<Address>? get defaultCollections {
    final value = _defaultCollections;
    if (value == null) return null;
    if (_defaultCollections is EqualUnmodifiableListView)
      return _defaultCollections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of NftInformation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NftInformationCopyWith<_NftInformation> get copyWith =>
      __$NftInformationCopyWithImpl<_NftInformation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NftInformationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NftInformation &&
            (identical(other.marketplaceUrl, marketplaceUrl) ||
                other.marketplaceUrl == marketplaceUrl) &&
            const DeepCollectionEquality()
                .equals(other._defaultCollections, _defaultCollections));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, marketplaceUrl,
      const DeepCollectionEquality().hash(_defaultCollections));

  @override
  String toString() {
    return 'NftInformation(marketplaceUrl: $marketplaceUrl, defaultCollections: $defaultCollections)';
  }
}

/// @nodoc
abstract mixin class _$NftInformationCopyWith<$Res>
    implements $NftInformationCopyWith<$Res> {
  factory _$NftInformationCopyWith(
          _NftInformation value, $Res Function(_NftInformation) _then) =
      __$NftInformationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? marketplaceUrl,
      @AddressListConverter() List<Address>? defaultCollections});
}

/// @nodoc
class __$NftInformationCopyWithImpl<$Res>
    implements _$NftInformationCopyWith<$Res> {
  __$NftInformationCopyWithImpl(this._self, this._then);

  final _NftInformation _self;
  final $Res Function(_NftInformation) _then;

  /// Create a copy of NftInformation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? marketplaceUrl = freezed,
    Object? defaultCollections = freezed,
  }) {
    return _then(_NftInformation(
      marketplaceUrl: freezed == marketplaceUrl
          ? _self.marketplaceUrl
          : marketplaceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultCollections: freezed == defaultCollections
          ? _self._defaultCollections
          : defaultCollections // ignore: cast_nullable_to_non_nullable
              as List<Address>?,
    ));
  }
}

// dart format on
