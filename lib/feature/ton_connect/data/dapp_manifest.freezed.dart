// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dapp_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DappManifest _$DappManifestFromJson(Map<String, dynamic> json) {
  return _DappManifest.fromJson(json);
}

/// @nodoc
mixin _$DappManifest {
  String get url => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get iconUrl => throw _privateConstructorUsedError;
  String? get termsOfUseUrl => throw _privateConstructorUsedError;
  String? get privacyPolicyUrl => throw _privateConstructorUsedError;

  /// Serializes this DappManifest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DappManifest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DappManifestCopyWith<DappManifest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DappManifestCopyWith<$Res> {
  factory $DappManifestCopyWith(
          DappManifest value, $Res Function(DappManifest) then) =
      _$DappManifestCopyWithImpl<$Res, DappManifest>;
  @useResult
  $Res call(
      {String url,
      String name,
      String iconUrl,
      String? termsOfUseUrl,
      String? privacyPolicyUrl});
}

/// @nodoc
class _$DappManifestCopyWithImpl<$Res, $Val extends DappManifest>
    implements $DappManifestCopyWith<$Res> {
  _$DappManifestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      termsOfUseUrl: freezed == termsOfUseUrl
          ? _value.termsOfUseUrl
          : termsOfUseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      privacyPolicyUrl: freezed == privacyPolicyUrl
          ? _value.privacyPolicyUrl
          : privacyPolicyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DappManifestImplCopyWith<$Res>
    implements $DappManifestCopyWith<$Res> {
  factory _$$DappManifestImplCopyWith(
          _$DappManifestImpl value, $Res Function(_$DappManifestImpl) then) =
      __$$DappManifestImplCopyWithImpl<$Res>;
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
class __$$DappManifestImplCopyWithImpl<$Res>
    extends _$DappManifestCopyWithImpl<$Res, _$DappManifestImpl>
    implements _$$DappManifestImplCopyWith<$Res> {
  __$$DappManifestImplCopyWithImpl(
      _$DappManifestImpl _value, $Res Function(_$DappManifestImpl) _then)
      : super(_value, _then);

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
    return _then(_$DappManifestImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      termsOfUseUrl: freezed == termsOfUseUrl
          ? _value.termsOfUseUrl
          : termsOfUseUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      privacyPolicyUrl: freezed == privacyPolicyUrl
          ? _value.privacyPolicyUrl
          : privacyPolicyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DappManifestImpl implements _DappManifest {
  const _$DappManifestImpl(
      {required this.url,
      required this.name,
      required this.iconUrl,
      this.termsOfUseUrl,
      this.privacyPolicyUrl});

  factory _$DappManifestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DappManifestImplFromJson(json);

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

  @override
  String toString() {
    return 'DappManifest(url: $url, name: $name, iconUrl: $iconUrl, termsOfUseUrl: $termsOfUseUrl, privacyPolicyUrl: $privacyPolicyUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DappManifestImpl &&
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

  /// Create a copy of DappManifest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DappManifestImplCopyWith<_$DappManifestImpl> get copyWith =>
      __$$DappManifestImplCopyWithImpl<_$DappManifestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DappManifestImplToJson(
      this,
    );
  }
}

abstract class _DappManifest implements DappManifest {
  const factory _DappManifest(
      {required final String url,
      required final String name,
      required final String iconUrl,
      final String? termsOfUseUrl,
      final String? privacyPolicyUrl}) = _$DappManifestImpl;

  factory _DappManifest.fromJson(Map<String, dynamic> json) =
      _$DappManifestImpl.fromJson;

  @override
  String get url;
  @override
  String get name;
  @override
  String get iconUrl;
  @override
  String? get termsOfUseUrl;
  @override
  String? get privacyPolicyUrl;

  /// Create a copy of DappManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DappManifestImplCopyWith<_$DappManifestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
