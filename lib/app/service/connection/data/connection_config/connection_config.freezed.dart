// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectionConfig {
  String get defaultConnectionId;
  Map<String, dynamic> get rawDefaultSettings;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Connection get defaultConnection;
  List<Connection>? get connections;
  List<CustomNetworkOption>? get customNetworkOptions;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<NetworkType>? get customNetworkOptionTypes;

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionConfigCopyWith<ConnectionConfig> get copyWith =>
      _$ConnectionConfigCopyWithImpl<ConnectionConfig>(
          this as ConnectionConfig, _$identity);

  /// Serializes this ConnectionConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectionConfig &&
            (identical(other.defaultConnectionId, defaultConnectionId) ||
                other.defaultConnectionId == defaultConnectionId) &&
            const DeepCollectionEquality()
                .equals(other.rawDefaultSettings, rawDefaultSettings) &&
            (identical(other.defaultConnection, defaultConnection) ||
                other.defaultConnection == defaultConnection) &&
            const DeepCollectionEquality()
                .equals(other.connections, connections) &&
            const DeepCollectionEquality()
                .equals(other.customNetworkOptions, customNetworkOptions) &&
            const DeepCollectionEquality().equals(
                other.customNetworkOptionTypes, customNetworkOptionTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      defaultConnectionId,
      const DeepCollectionEquality().hash(rawDefaultSettings),
      defaultConnection,
      const DeepCollectionEquality().hash(connections),
      const DeepCollectionEquality().hash(customNetworkOptions),
      const DeepCollectionEquality().hash(customNetworkOptionTypes));

  @override
  String toString() {
    return 'ConnectionConfig(defaultConnectionId: $defaultConnectionId, rawDefaultSettings: $rawDefaultSettings, defaultConnection: $defaultConnection, connections: $connections, customNetworkOptions: $customNetworkOptions, customNetworkOptionTypes: $customNetworkOptionTypes)';
  }
}

/// @nodoc
abstract mixin class $ConnectionConfigCopyWith<$Res> {
  factory $ConnectionConfigCopyWith(
          ConnectionConfig value, $Res Function(ConnectionConfig) _then) =
      _$ConnectionConfigCopyWithImpl;
  @useResult
  $Res call(
      {String defaultConnectionId,
      Map<String, dynamic> rawDefaultSettings,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Connection defaultConnection,
      List<Connection>? connections,
      List<CustomNetworkOption>? customNetworkOptions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<NetworkType>? customNetworkOptionTypes});

  $ConnectionCopyWith<$Res> get defaultConnection;
}

/// @nodoc
class _$ConnectionConfigCopyWithImpl<$Res>
    implements $ConnectionConfigCopyWith<$Res> {
  _$ConnectionConfigCopyWithImpl(this._self, this._then);

  final ConnectionConfig _self;
  final $Res Function(ConnectionConfig) _then;

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultConnectionId = null,
    Object? rawDefaultSettings = null,
    Object? defaultConnection = null,
    Object? connections = freezed,
    Object? customNetworkOptions = freezed,
    Object? customNetworkOptionTypes = freezed,
  }) {
    return _then(_self.copyWith(
      defaultConnectionId: null == defaultConnectionId
          ? _self.defaultConnectionId
          : defaultConnectionId // ignore: cast_nullable_to_non_nullable
              as String,
      rawDefaultSettings: null == rawDefaultSettings
          ? _self.rawDefaultSettings
          : rawDefaultSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      defaultConnection: null == defaultConnection
          ? _self.defaultConnection
          : defaultConnection // ignore: cast_nullable_to_non_nullable
              as Connection,
      connections: freezed == connections
          ? _self.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<Connection>?,
      customNetworkOptions: freezed == customNetworkOptions
          ? _self.customNetworkOptions
          : customNetworkOptions // ignore: cast_nullable_to_non_nullable
              as List<CustomNetworkOption>?,
      customNetworkOptionTypes: freezed == customNetworkOptionTypes
          ? _self.customNetworkOptionTypes
          : customNetworkOptionTypes // ignore: cast_nullable_to_non_nullable
              as List<NetworkType>?,
    ));
  }

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionCopyWith<$Res> get defaultConnection {
    return $ConnectionCopyWith<$Res>(_self.defaultConnection, (value) {
      return _then(_self.copyWith(defaultConnection: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, createFactory: false)
class _ConnectionConfig implements ConnectionConfig {
  const _ConnectionConfig(
      {required this.defaultConnectionId,
      required final Map<String, dynamic> rawDefaultSettings,
      @JsonKey(includeFromJson: false, includeToJson: false)
      required this.defaultConnection,
      final List<Connection>? connections,
      final List<CustomNetworkOption>? customNetworkOptions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<NetworkType>? customNetworkOptionTypes})
      : _rawDefaultSettings = rawDefaultSettings,
        _connections = connections,
        _customNetworkOptions = customNetworkOptions,
        _customNetworkOptionTypes = customNetworkOptionTypes;

  @override
  final String defaultConnectionId;
  final Map<String, dynamic> _rawDefaultSettings;
  @override
  Map<String, dynamic> get rawDefaultSettings {
    if (_rawDefaultSettings is EqualUnmodifiableMapView)
      return _rawDefaultSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rawDefaultSettings);
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Connection defaultConnection;
  final List<Connection>? _connections;
  @override
  List<Connection>? get connections {
    final value = _connections;
    if (value == null) return null;
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CustomNetworkOption>? _customNetworkOptions;
  @override
  List<CustomNetworkOption>? get customNetworkOptions {
    final value = _customNetworkOptions;
    if (value == null) return null;
    if (_customNetworkOptions is EqualUnmodifiableListView)
      return _customNetworkOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<NetworkType>? _customNetworkOptionTypes;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<NetworkType>? get customNetworkOptionTypes {
    final value = _customNetworkOptionTypes;
    if (value == null) return null;
    if (_customNetworkOptionTypes is EqualUnmodifiableListView)
      return _customNetworkOptionTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectionConfigCopyWith<_ConnectionConfig> get copyWith =>
      __$ConnectionConfigCopyWithImpl<_ConnectionConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectionConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectionConfig &&
            (identical(other.defaultConnectionId, defaultConnectionId) ||
                other.defaultConnectionId == defaultConnectionId) &&
            const DeepCollectionEquality()
                .equals(other._rawDefaultSettings, _rawDefaultSettings) &&
            (identical(other.defaultConnection, defaultConnection) ||
                other.defaultConnection == defaultConnection) &&
            const DeepCollectionEquality()
                .equals(other._connections, _connections) &&
            const DeepCollectionEquality()
                .equals(other._customNetworkOptions, _customNetworkOptions) &&
            const DeepCollectionEquality().equals(
                other._customNetworkOptionTypes, _customNetworkOptionTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      defaultConnectionId,
      const DeepCollectionEquality().hash(_rawDefaultSettings),
      defaultConnection,
      const DeepCollectionEquality().hash(_connections),
      const DeepCollectionEquality().hash(_customNetworkOptions),
      const DeepCollectionEquality().hash(_customNetworkOptionTypes));

  @override
  String toString() {
    return 'ConnectionConfig._(defaultConnectionId: $defaultConnectionId, rawDefaultSettings: $rawDefaultSettings, defaultConnection: $defaultConnection, connections: $connections, customNetworkOptions: $customNetworkOptions, customNetworkOptionTypes: $customNetworkOptionTypes)';
  }
}

/// @nodoc
abstract mixin class _$ConnectionConfigCopyWith<$Res>
    implements $ConnectionConfigCopyWith<$Res> {
  factory _$ConnectionConfigCopyWith(
          _ConnectionConfig value, $Res Function(_ConnectionConfig) _then) =
      __$ConnectionConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String defaultConnectionId,
      Map<String, dynamic> rawDefaultSettings,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Connection defaultConnection,
      List<Connection>? connections,
      List<CustomNetworkOption>? customNetworkOptions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<NetworkType>? customNetworkOptionTypes});

  @override
  $ConnectionCopyWith<$Res> get defaultConnection;
}

/// @nodoc
class __$ConnectionConfigCopyWithImpl<$Res>
    implements _$ConnectionConfigCopyWith<$Res> {
  __$ConnectionConfigCopyWithImpl(this._self, this._then);

  final _ConnectionConfig _self;
  final $Res Function(_ConnectionConfig) _then;

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? defaultConnectionId = null,
    Object? rawDefaultSettings = null,
    Object? defaultConnection = null,
    Object? connections = freezed,
    Object? customNetworkOptions = freezed,
    Object? customNetworkOptionTypes = freezed,
  }) {
    return _then(_ConnectionConfig(
      defaultConnectionId: null == defaultConnectionId
          ? _self.defaultConnectionId
          : defaultConnectionId // ignore: cast_nullable_to_non_nullable
              as String,
      rawDefaultSettings: null == rawDefaultSettings
          ? _self._rawDefaultSettings
          : rawDefaultSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      defaultConnection: null == defaultConnection
          ? _self.defaultConnection
          : defaultConnection // ignore: cast_nullable_to_non_nullable
              as Connection,
      connections: freezed == connections
          ? _self._connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<Connection>?,
      customNetworkOptions: freezed == customNetworkOptions
          ? _self._customNetworkOptions
          : customNetworkOptions // ignore: cast_nullable_to_non_nullable
              as List<CustomNetworkOption>?,
      customNetworkOptionTypes: freezed == customNetworkOptionTypes
          ? _self._customNetworkOptionTypes
          : customNetworkOptionTypes // ignore: cast_nullable_to_non_nullable
              as List<NetworkType>?,
    ));
  }

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionCopyWith<$Res> get defaultConnection {
    return $ConnectionCopyWith<$Res>(_self.defaultConnection, (value) {
      return _then(_self.copyWith(defaultConnection: value));
    });
  }
}

// dart format on
