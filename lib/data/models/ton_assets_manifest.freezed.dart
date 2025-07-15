// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_assets_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TonAssetsManifest {
  @JsonKey(name: r'$schema')
  String get schema;
  String get name;
  TonAssetsManifestVersion get version;
  List<String> get keywords;
  String get timestamp;
  List<TokenContractAsset> get tokens;

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonAssetsManifestCopyWith<TonAssetsManifest> get copyWith =>
      _$TonAssetsManifestCopyWithImpl<TonAssetsManifest>(
          this as TonAssetsManifest, _$identity);

  /// Serializes this TonAssetsManifest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonAssetsManifest &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other.tokens, tokens));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      schema,
      name,
      version,
      const DeepCollectionEquality().hash(keywords),
      timestamp,
      const DeepCollectionEquality().hash(tokens));

  @override
  String toString() {
    return 'TonAssetsManifest(schema: $schema, name: $name, version: $version, keywords: $keywords, timestamp: $timestamp, tokens: $tokens)';
  }
}

/// @nodoc
abstract mixin class $TonAssetsManifestCopyWith<$Res> {
  factory $TonAssetsManifestCopyWith(
          TonAssetsManifest value, $Res Function(TonAssetsManifest) _then) =
      _$TonAssetsManifestCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: r'$schema') String schema,
      String name,
      TonAssetsManifestVersion version,
      List<String> keywords,
      String timestamp,
      List<TokenContractAsset> tokens});

  $TonAssetsManifestVersionCopyWith<$Res> get version;
}

/// @nodoc
class _$TonAssetsManifestCopyWithImpl<$Res>
    implements $TonAssetsManifestCopyWith<$Res> {
  _$TonAssetsManifestCopyWithImpl(this._self, this._then);

  final TonAssetsManifest _self;
  final $Res Function(TonAssetsManifest) _then;

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
    Object? version = null,
    Object? keywords = null,
    Object? timestamp = null,
    Object? tokens = null,
  }) {
    return _then(_self.copyWith(
      schema: null == schema
          ? _self.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as TonAssetsManifestVersion,
      keywords: null == keywords
          ? _self.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      tokens: null == tokens
          ? _self.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<TokenContractAsset>,
    ));
  }

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonAssetsManifestVersionCopyWith<$Res> get version {
    return $TonAssetsManifestVersionCopyWith<$Res>(_self.version, (value) {
      return _then(_self.copyWith(version: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _TonAssetsManifest implements TonAssetsManifest {
  const _TonAssetsManifest(
      {@JsonKey(name: r'$schema') required this.schema,
      required this.name,
      required this.version,
      required final List<String> keywords,
      required this.timestamp,
      required final List<TokenContractAsset> tokens})
      : _keywords = keywords,
        _tokens = tokens;
  factory _TonAssetsManifest.fromJson(Map<String, dynamic> json) =>
      _$TonAssetsManifestFromJson(json);

  @override
  @JsonKey(name: r'$schema')
  final String schema;
  @override
  final String name;
  @override
  final TonAssetsManifestVersion version;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  final String timestamp;
  final List<TokenContractAsset> _tokens;
  @override
  List<TokenContractAsset> get tokens {
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokens);
  }

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TonAssetsManifestCopyWith<_TonAssetsManifest> get copyWith =>
      __$TonAssetsManifestCopyWithImpl<_TonAssetsManifest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TonAssetsManifestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TonAssetsManifest &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      schema,
      name,
      version,
      const DeepCollectionEquality().hash(_keywords),
      timestamp,
      const DeepCollectionEquality().hash(_tokens));

  @override
  String toString() {
    return 'TonAssetsManifest(schema: $schema, name: $name, version: $version, keywords: $keywords, timestamp: $timestamp, tokens: $tokens)';
  }
}

/// @nodoc
abstract mixin class _$TonAssetsManifestCopyWith<$Res>
    implements $TonAssetsManifestCopyWith<$Res> {
  factory _$TonAssetsManifestCopyWith(
          _TonAssetsManifest value, $Res Function(_TonAssetsManifest) _then) =
      __$TonAssetsManifestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: r'$schema') String schema,
      String name,
      TonAssetsManifestVersion version,
      List<String> keywords,
      String timestamp,
      List<TokenContractAsset> tokens});

  @override
  $TonAssetsManifestVersionCopyWith<$Res> get version;
}

/// @nodoc
class __$TonAssetsManifestCopyWithImpl<$Res>
    implements _$TonAssetsManifestCopyWith<$Res> {
  __$TonAssetsManifestCopyWithImpl(this._self, this._then);

  final _TonAssetsManifest _self;
  final $Res Function(_TonAssetsManifest) _then;

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? schema = null,
    Object? name = null,
    Object? version = null,
    Object? keywords = null,
    Object? timestamp = null,
    Object? tokens = null,
  }) {
    return _then(_TonAssetsManifest(
      schema: null == schema
          ? _self.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as TonAssetsManifestVersion,
      keywords: null == keywords
          ? _self._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      tokens: null == tokens
          ? _self._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<TokenContractAsset>,
    ));
  }

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonAssetsManifestVersionCopyWith<$Res> get version {
    return $TonAssetsManifestVersionCopyWith<$Res>(_self.version, (value) {
      return _then(_self.copyWith(version: value));
    });
  }
}

// dart format on
