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
  Connection get currentConnection;
  Connection get defaultConnection;
  ConnectionDefaultSettings get defaultSettings;
  List<Connection>? get connections;
  List<CustomNetworkOption>? get customNetworkOptions;

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionConfigCopyWith<ConnectionConfig> get copyWith =>
      _$ConnectionConfigCopyWithImpl<ConnectionConfig>(
          this as ConnectionConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectionConfig &&
            (identical(other.currentConnection, currentConnection) ||
                other.currentConnection == currentConnection) &&
            (identical(other.defaultConnection, defaultConnection) ||
                other.defaultConnection == defaultConnection) &&
            (identical(other.defaultSettings, defaultSettings) ||
                other.defaultSettings == defaultSettings) &&
            const DeepCollectionEquality()
                .equals(other.connections, connections) &&
            const DeepCollectionEquality()
                .equals(other.customNetworkOptions, customNetworkOptions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentConnection,
      defaultConnection,
      defaultSettings,
      const DeepCollectionEquality().hash(connections),
      const DeepCollectionEquality().hash(customNetworkOptions));

  @override
  String toString() {
    return 'ConnectionConfig(currentConnection: $currentConnection, defaultConnection: $defaultConnection, defaultSettings: $defaultSettings, connections: $connections, customNetworkOptions: $customNetworkOptions)';
  }
}

/// @nodoc
abstract mixin class $ConnectionConfigCopyWith<$Res> {
  factory $ConnectionConfigCopyWith(
          ConnectionConfig value, $Res Function(ConnectionConfig) _then) =
      _$ConnectionConfigCopyWithImpl;
  @useResult
  $Res call(
      {Connection currentConnection,
      Connection defaultConnection,
      ConnectionDefaultSettings defaultSettings,
      List<Connection>? connections,
      List<CustomNetworkOption>? customNetworkOptions});

  $ConnectionCopyWith<$Res> get currentConnection;
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
    Object? currentConnection = null,
    Object? defaultConnection = null,
    Object? defaultSettings = null,
    Object? connections = freezed,
    Object? customNetworkOptions = freezed,
  }) {
    return _then(_self.copyWith(
      currentConnection: null == currentConnection
          ? _self.currentConnection
          : currentConnection // ignore: cast_nullable_to_non_nullable
              as Connection,
      defaultConnection: null == defaultConnection
          ? _self.defaultConnection
          : defaultConnection // ignore: cast_nullable_to_non_nullable
              as Connection,
      defaultSettings: null == defaultSettings
          ? _self.defaultSettings
          : defaultSettings // ignore: cast_nullable_to_non_nullable
              as ConnectionDefaultSettings,
      connections: freezed == connections
          ? _self.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<Connection>?,
      customNetworkOptions: freezed == customNetworkOptions
          ? _self.customNetworkOptions
          : customNetworkOptions // ignore: cast_nullable_to_non_nullable
              as List<CustomNetworkOption>?,
    ));
  }

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionCopyWith<$Res> get currentConnection {
    return $ConnectionCopyWith<$Res>(_self.currentConnection, (value) {
      return _then(_self.copyWith(currentConnection: value));
    });
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

class _ConnectionConfig implements ConnectionConfig {
  _ConnectionConfig(
      {required this.currentConnection,
      required this.defaultConnection,
      required this.defaultSettings,
      final List<Connection>? connections,
      final List<CustomNetworkOption>? customNetworkOptions})
      : _connections = connections,
        _customNetworkOptions = customNetworkOptions;

  @override
  final Connection currentConnection;
  @override
  final Connection defaultConnection;
  @override
  final ConnectionDefaultSettings defaultSettings;
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

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectionConfigCopyWith<_ConnectionConfig> get copyWith =>
      __$ConnectionConfigCopyWithImpl<_ConnectionConfig>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectionConfig &&
            (identical(other.currentConnection, currentConnection) ||
                other.currentConnection == currentConnection) &&
            (identical(other.defaultConnection, defaultConnection) ||
                other.defaultConnection == defaultConnection) &&
            (identical(other.defaultSettings, defaultSettings) ||
                other.defaultSettings == defaultSettings) &&
            const DeepCollectionEquality()
                .equals(other._connections, _connections) &&
            const DeepCollectionEquality()
                .equals(other._customNetworkOptions, _customNetworkOptions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentConnection,
      defaultConnection,
      defaultSettings,
      const DeepCollectionEquality().hash(_connections),
      const DeepCollectionEquality().hash(_customNetworkOptions));

  @override
  String toString() {
    return 'ConnectionConfig(currentConnection: $currentConnection, defaultConnection: $defaultConnection, defaultSettings: $defaultSettings, connections: $connections, customNetworkOptions: $customNetworkOptions)';
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
      {Connection currentConnection,
      Connection defaultConnection,
      ConnectionDefaultSettings defaultSettings,
      List<Connection>? connections,
      List<CustomNetworkOption>? customNetworkOptions});

  @override
  $ConnectionCopyWith<$Res> get currentConnection;
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
    Object? currentConnection = null,
    Object? defaultConnection = null,
    Object? defaultSettings = null,
    Object? connections = freezed,
    Object? customNetworkOptions = freezed,
  }) {
    return _then(_ConnectionConfig(
      currentConnection: null == currentConnection
          ? _self.currentConnection
          : currentConnection // ignore: cast_nullable_to_non_nullable
              as Connection,
      defaultConnection: null == defaultConnection
          ? _self.defaultConnection
          : defaultConnection // ignore: cast_nullable_to_non_nullable
              as Connection,
      defaultSettings: null == defaultSettings
          ? _self.defaultSettings
          : defaultSettings // ignore: cast_nullable_to_non_nullable
              as ConnectionDefaultSettings,
      connections: freezed == connections
          ? _self._connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<Connection>?,
      customNetworkOptions: freezed == customNetworkOptions
          ? _self._customNetworkOptions
          : customNetworkOptions // ignore: cast_nullable_to_non_nullable
              as List<CustomNetworkOption>?,
    ));
  }

  /// Create a copy of ConnectionConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectionCopyWith<$Res> get currentConnection {
    return $ConnectionCopyWith<$Res>(_self.currentConnection, (value) {
      return _then(_self.copyWith(currentConnection: value));
    });
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
