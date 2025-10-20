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
  @JsonKey(includeFromJson: false, includeToJson: false)
  Connection get defaultConnection;
  ConnectionDefaultSettings get defaultSettings;
  List<Connection> get connections;
  List<StartConnectionData> get startConnections;
  List<CustomNetworkOption> get customNetworkOptions;
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
            (identical(other.defaultConnection, defaultConnection) ||
                other.defaultConnection == defaultConnection) &&
            (identical(other.defaultSettings, defaultSettings) ||
                other.defaultSettings == defaultSettings) &&
            const DeepCollectionEquality()
                .equals(other.connections, connections) &&
            const DeepCollectionEquality()
                .equals(other.startConnections, startConnections) &&
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
      defaultConnection,
      defaultSettings,
      const DeepCollectionEquality().hash(connections),
      const DeepCollectionEquality().hash(startConnections),
      const DeepCollectionEquality().hash(customNetworkOptions),
      const DeepCollectionEquality().hash(customNetworkOptionTypes));

  @override
  String toString() {
    return 'ConnectionConfig(defaultConnectionId: $defaultConnectionId, defaultConnection: $defaultConnection, defaultSettings: $defaultSettings, connections: $connections, startConnections: $startConnections, customNetworkOptions: $customNetworkOptions, customNetworkOptionTypes: $customNetworkOptionTypes)';
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
      @JsonKey(includeFromJson: false, includeToJson: false)
      Connection defaultConnection,
      ConnectionDefaultSettings defaultSettings,
      List<Connection> connections,
      List<StartConnectionData> startConnections,
      List<CustomNetworkOption> customNetworkOptions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<NetworkType>? customNetworkOptionTypes});

  $ConnectionCopyWith<$Res> get defaultConnection;
  $ConnectionDefaultSettingsCopyWith<$Res> get defaultSettings;
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
    Object? defaultConnection = null,
    Object? defaultSettings = null,
    Object? connections = null,
    Object? startConnections = null,
    Object? customNetworkOptions = null,
    Object? customNetworkOptionTypes = freezed,
  }) {
    return _then(_self.copyWith(
      defaultConnectionId: null == defaultConnectionId
          ? _self.defaultConnectionId
          : defaultConnectionId // ignore: cast_nullable_to_non_nullable
              as String,
      defaultConnection: null == defaultConnection
          ? _self.defaultConnection
          : defaultConnection // ignore: cast_nullable_to_non_nullable
              as Connection,
      defaultSettings: null == defaultSettings
          ? _self.defaultSettings
          : defaultSettings // ignore: cast_nullable_to_non_nullable
              as ConnectionDefaultSettings,
      connections: null == connections
          ? _self.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<Connection>,
      startConnections: null == startConnections
          ? _self.startConnections
          : startConnections // ignore: cast_nullable_to_non_nullable
              as List<StartConnectionData>,
      customNetworkOptions: null == customNetworkOptions
          ? _self.customNetworkOptions
          : customNetworkOptions // ignore: cast_nullable_to_non_nullable
              as List<CustomNetworkOption>,
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

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionDefaultSettingsCopyWith<$Res> get defaultSettings {
    return $ConnectionDefaultSettingsCopyWith<$Res>(_self.defaultSettings,
        (value) {
      return _then(_self.copyWith(defaultSettings: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, createFactory: false)
class _ConnectionConfig implements ConnectionConfig {
  const _ConnectionConfig(
      {required this.defaultConnectionId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      required this.defaultConnection,
      required this.defaultSettings,
      required final List<Connection> connections,
      required final List<StartConnectionData> startConnections,
      required final List<CustomNetworkOption> customNetworkOptions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      required final List<NetworkType>? customNetworkOptionTypes})
      : _connections = connections,
        _startConnections = startConnections,
        _customNetworkOptions = customNetworkOptions,
        _customNetworkOptionTypes = customNetworkOptionTypes;

  @override
  final String defaultConnectionId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Connection defaultConnection;
  @override
  final ConnectionDefaultSettings defaultSettings;
  final List<Connection> _connections;
  @override
  List<Connection> get connections {
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connections);
  }

  final List<StartConnectionData> _startConnections;
  @override
  List<StartConnectionData> get startConnections {
    if (_startConnections is EqualUnmodifiableListView)
      return _startConnections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_startConnections);
  }

  final List<CustomNetworkOption> _customNetworkOptions;
  @override
  List<CustomNetworkOption> get customNetworkOptions {
    if (_customNetworkOptions is EqualUnmodifiableListView)
      return _customNetworkOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customNetworkOptions);
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
            (identical(other.defaultConnection, defaultConnection) ||
                other.defaultConnection == defaultConnection) &&
            (identical(other.defaultSettings, defaultSettings) ||
                other.defaultSettings == defaultSettings) &&
            const DeepCollectionEquality()
                .equals(other._connections, _connections) &&
            const DeepCollectionEquality()
                .equals(other._startConnections, _startConnections) &&
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
      defaultConnection,
      defaultSettings,
      const DeepCollectionEquality().hash(_connections),
      const DeepCollectionEquality().hash(_startConnections),
      const DeepCollectionEquality().hash(_customNetworkOptions),
      const DeepCollectionEquality().hash(_customNetworkOptionTypes));

  @override
  String toString() {
    return 'ConnectionConfig._(defaultConnectionId: $defaultConnectionId, defaultConnection: $defaultConnection, defaultSettings: $defaultSettings, connections: $connections, startConnections: $startConnections, customNetworkOptions: $customNetworkOptions, customNetworkOptionTypes: $customNetworkOptionTypes)';
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
      @JsonKey(includeFromJson: false, includeToJson: false)
      Connection defaultConnection,
      ConnectionDefaultSettings defaultSettings,
      List<Connection> connections,
      List<StartConnectionData> startConnections,
      List<CustomNetworkOption> customNetworkOptions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<NetworkType>? customNetworkOptionTypes});

  @override
  $ConnectionCopyWith<$Res> get defaultConnection;
  @override
  $ConnectionDefaultSettingsCopyWith<$Res> get defaultSettings;
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
    Object? defaultConnection = null,
    Object? defaultSettings = null,
    Object? connections = null,
    Object? startConnections = null,
    Object? customNetworkOptions = null,
    Object? customNetworkOptionTypes = freezed,
  }) {
    return _then(_ConnectionConfig(
      defaultConnectionId: null == defaultConnectionId
          ? _self.defaultConnectionId
          : defaultConnectionId // ignore: cast_nullable_to_non_nullable
              as String,
      defaultConnection: null == defaultConnection
          ? _self.defaultConnection
          : defaultConnection // ignore: cast_nullable_to_non_nullable
              as Connection,
      defaultSettings: null == defaultSettings
          ? _self.defaultSettings
          : defaultSettings // ignore: cast_nullable_to_non_nullable
              as ConnectionDefaultSettings,
      connections: null == connections
          ? _self._connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<Connection>,
      startConnections: null == startConnections
          ? _self._startConnections
          : startConnections // ignore: cast_nullable_to_non_nullable
              as List<StartConnectionData>,
      customNetworkOptions: null == customNetworkOptions
          ? _self._customNetworkOptions
          : customNetworkOptions // ignore: cast_nullable_to_non_nullable
              as List<CustomNetworkOption>,
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

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionDefaultSettingsCopyWith<$Res> get defaultSettings {
    return $ConnectionDefaultSettingsCopyWith<$Res>(_self.defaultSettings,
        (value) {
      return _then(_self.copyWith(defaultSettings: value));
    });
  }
}

// dart format on
