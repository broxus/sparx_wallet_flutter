// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_assets_manifest_version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TonAssetsManifestVersion {
  int get major;
  int get minor;
  int get patch;

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonAssetsManifestVersionCopyWith<TonAssetsManifestVersion> get copyWith =>
      _$TonAssetsManifestVersionCopyWithImpl<TonAssetsManifestVersion>(
          this as TonAssetsManifestVersion, _$identity);

  /// Serializes this TonAssetsManifestVersion to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonAssetsManifestVersion &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.minor, minor) || other.minor == minor) &&
            (identical(other.patch, patch) || other.patch == patch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, major, minor, patch);

  @override
  String toString() {
    return 'TonAssetsManifestVersion(major: $major, minor: $minor, patch: $patch)';
  }
}

/// @nodoc
abstract mixin class $TonAssetsManifestVersionCopyWith<$Res> {
  factory $TonAssetsManifestVersionCopyWith(TonAssetsManifestVersion value,
          $Res Function(TonAssetsManifestVersion) _then) =
      _$TonAssetsManifestVersionCopyWithImpl;
  @useResult
  $Res call({int major, int minor, int patch});
}

/// @nodoc
class _$TonAssetsManifestVersionCopyWithImpl<$Res>
    implements $TonAssetsManifestVersionCopyWith<$Res> {
  _$TonAssetsManifestVersionCopyWithImpl(this._self, this._then);

  final TonAssetsManifestVersion _self;
  final $Res Function(TonAssetsManifestVersion) _then;

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? major = null,
    Object? minor = null,
    Object? patch = null,
  }) {
    return _then(_self.copyWith(
      major: null == major
          ? _self.major
          : major // ignore: cast_nullable_to_non_nullable
              as int,
      minor: null == minor
          ? _self.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      patch: null == patch
          ? _self.patch
          : patch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TonAssetsManifestVersion implements TonAssetsManifestVersion {
  const _TonAssetsManifestVersion(
      {required this.major, required this.minor, required this.patch});
  factory _TonAssetsManifestVersion.fromJson(Map<String, dynamic> json) =>
      _$TonAssetsManifestVersionFromJson(json);

  @override
  final int major;
  @override
  final int minor;
  @override
  final int patch;

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TonAssetsManifestVersionCopyWith<_TonAssetsManifestVersion> get copyWith =>
      __$TonAssetsManifestVersionCopyWithImpl<_TonAssetsManifestVersion>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TonAssetsManifestVersionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TonAssetsManifestVersion &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.minor, minor) || other.minor == minor) &&
            (identical(other.patch, patch) || other.patch == patch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, major, minor, patch);

  @override
  String toString() {
    return 'TonAssetsManifestVersion(major: $major, minor: $minor, patch: $patch)';
  }
}

/// @nodoc
abstract mixin class _$TonAssetsManifestVersionCopyWith<$Res>
    implements $TonAssetsManifestVersionCopyWith<$Res> {
  factory _$TonAssetsManifestVersionCopyWith(_TonAssetsManifestVersion value,
          $Res Function(_TonAssetsManifestVersion) _then) =
      __$TonAssetsManifestVersionCopyWithImpl;
  @override
  @useResult
  $Res call({int major, int minor, int patch});
}

/// @nodoc
class __$TonAssetsManifestVersionCopyWithImpl<$Res>
    implements _$TonAssetsManifestVersionCopyWith<$Res> {
  __$TonAssetsManifestVersionCopyWithImpl(this._self, this._then);

  final _TonAssetsManifestVersion _self;
  final $Res Function(_TonAssetsManifestVersion) _then;

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? major = null,
    Object? minor = null,
    Object? patch = null,
  }) {
    return _then(_TonAssetsManifestVersion(
      major: null == major
          ? _self.major
          : major // ignore: cast_nullable_to_non_nullable
              as int,
      minor: null == minor
          ? _self.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      patch: null == patch
          ? _self.patch
          : patch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
