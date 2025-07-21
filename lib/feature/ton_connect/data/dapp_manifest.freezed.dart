// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dapp_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DappManifest {
  String get url;
  String get name;
  String get iconUrl;
  String? get termsOfUseUrl;
  String? get privacyPolicyUrl;

  /// Create a copy of DappManifest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DappManifestCopyWith<DappManifest> get copyWith =>
      _$DappManifestCopyWithImpl<DappManifest>(
          this as DappManifest, _$identity);

  /// Serializes this DappManifest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DappManifest &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.termsOfUseUrl, termsOfUseUrl) ||
                other.termsOfUseUrl == termsOfUseUrl) &&
            (identical(other.privacyPolicyUrl, privacyPolicyUrl) ||
                other.privacyPolicyUrl == privacyPolicyUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, name, iconUrl, termsOfUseUrl, privacyPolicyUrl);

  @override
  String toString() {
    return 'DappManifest(url: $url, name: $name, iconUrl: $iconUrl, termsOfUseUrl: $termsOfUseUrl, privacyPolicyUrl: $privacyPolicyUrl)';
  }
}

/// @nodoc
abstract mixin class $DappManifestCopyWith<$Res> {
  factory $DappManifestCopyWith(
          DappManifest value, $Res Function(DappManifest) _then) =
      _$DappManifestCopyWithImpl;
  @useResult
  $Res call(
      {String url,
      String name,
      String iconUrl,
      String? termsOfUseUrl,
      String? privacyPolicyUrl});
}

/// @nodoc
class _$DappManifestCopyWithImpl<$Res> implements $DappManifestCopyWith<$Res> {
  _$DappManifestCopyWithImpl(this._self, this._then);

  final DappManifest _self;
  final $Res Function(DappManifest) _then;

  /// Create a copy of DappManifest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? name = null,
    Object? iconUrl = null,
    Object? termsOfUseUrl = freezed,
    Object? privacyPolicyUrl = freezed,
  }) {
    return _then(_self.copyWith(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _self.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      termsOfUseUrl: freezed == termsOfUseUrl
          ? _self.termsOfUseUrl
          : termsOfUseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      privacyPolicyUrl: freezed == privacyPolicyUrl
          ? _self.privacyPolicyUrl
          : privacyPolicyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _DappManifest implements DappManifest {
  const _DappManifest(
      {required this.url,
      required this.name,
      required this.iconUrl,
      this.termsOfUseUrl,
      this.privacyPolicyUrl});
  factory _DappManifest.fromJson(Map<String, dynamic> json) =>
      _$DappManifestFromJson(json);

  @override
  final String url;
  @override
  final String name;
  @override
  final String iconUrl;
  @override
  final String? termsOfUseUrl;
  @override
  final String? privacyPolicyUrl;

  /// Create a copy of DappManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DappManifestCopyWith<_DappManifest> get copyWith =>
      __$DappManifestCopyWithImpl<_DappManifest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DappManifestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DappManifest &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.termsOfUseUrl, termsOfUseUrl) ||
                other.termsOfUseUrl == termsOfUseUrl) &&
            (identical(other.privacyPolicyUrl, privacyPolicyUrl) ||
                other.privacyPolicyUrl == privacyPolicyUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, name, iconUrl, termsOfUseUrl, privacyPolicyUrl);

  @override
  String toString() {
    return 'DappManifest(url: $url, name: $name, iconUrl: $iconUrl, termsOfUseUrl: $termsOfUseUrl, privacyPolicyUrl: $privacyPolicyUrl)';
  }
}

/// @nodoc
abstract mixin class _$DappManifestCopyWith<$Res>
    implements $DappManifestCopyWith<$Res> {
  factory _$DappManifestCopyWith(
          _DappManifest value, $Res Function(_DappManifest) _then) =
      __$DappManifestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String url,
      String name,
      String iconUrl,
      String? termsOfUseUrl,
      String? privacyPolicyUrl});
}

/// @nodoc
class __$DappManifestCopyWithImpl<$Res>
    implements _$DappManifestCopyWith<$Res> {
  __$DappManifestCopyWithImpl(this._self, this._then);

  final _DappManifest _self;
  final $Res Function(_DappManifest) _then;

  /// Create a copy of DappManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? url = null,
    Object? name = null,
    Object? iconUrl = null,
    Object? termsOfUseUrl = freezed,
    Object? privacyPolicyUrl = freezed,
  }) {
    return _then(_DappManifest(
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _self.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      termsOfUseUrl: freezed == termsOfUseUrl
          ? _self.termsOfUseUrl
          : termsOfUseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      privacyPolicyUrl: freezed == privacyPolicyUrl
          ? _self.privacyPolicyUrl
          : privacyPolicyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
