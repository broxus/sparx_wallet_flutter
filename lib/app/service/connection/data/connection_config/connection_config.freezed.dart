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
  String get defaultNetworkId;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ConnectionNetwork get defaultNetwork;
  List<ConnectionNetwork>? get networks;
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
            (identical(other.defaultNetworkId, defaultNetworkId) ||
                other.defaultNetworkId == defaultNetworkId) &&
            (identical(other.defaultNetwork, defaultNetwork) ||
                other.defaultNetwork == defaultNetwork) &&
            const DeepCollectionEquality().equals(other.networks, networks) &&
            const DeepCollectionEquality()
                .equals(other.customNetworkOptions, customNetworkOptions) &&
            const DeepCollectionEquality().equals(
                other.customNetworkOptionTypes, customNetworkOptionTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      defaultNetworkId,
      defaultNetwork,
      const DeepCollectionEquality().hash(networks),
      const DeepCollectionEquality().hash(customNetworkOptions),
      const DeepCollectionEquality().hash(customNetworkOptionTypes));

  @override
  String toString() {
    return 'ConnectionConfig(defaultNetworkId: $defaultNetworkId, defaultNetwork: $defaultNetwork, networks: $networks, customNetworkOptions: $customNetworkOptions, customNetworkOptionTypes: $customNetworkOptionTypes)';
  }
}

/// @nodoc
abstract mixin class $ConnectionConfigCopyWith<$Res> {
  factory $ConnectionConfigCopyWith(
          ConnectionConfig value, $Res Function(ConnectionConfig) _then) =
      _$ConnectionConfigCopyWithImpl;
  @useResult
  $Res call(
      {String defaultNetworkId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ConnectionNetwork defaultNetwork,
      List<ConnectionNetwork>? networks,
      List<CustomNetworkOption>? customNetworkOptions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<NetworkType>? customNetworkOptionTypes});

  $ConnectionNetworkCopyWith<$Res> get defaultNetwork;
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
    Object? defaultNetworkId = null,
    Object? defaultNetwork = null,
    Object? networks = freezed,
    Object? customNetworkOptions = freezed,
    Object? customNetworkOptionTypes = freezed,
  }) {
    return _then(_self.copyWith(
      defaultNetworkId: null == defaultNetworkId
          ? _self.defaultNetworkId
          : defaultNetworkId // ignore: cast_nullable_to_non_nullable
              as String,
      defaultNetwork: null == defaultNetwork
          ? _self.defaultNetwork
          : defaultNetwork // ignore: cast_nullable_to_non_nullable
              as ConnectionNetwork,
      networks: freezed == networks
          ? _self.networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<ConnectionNetwork>?,
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
  $ConnectionNetworkCopyWith<$Res> get defaultNetwork {
    return $ConnectionNetworkCopyWith<$Res>(_self.defaultNetwork, (value) {
      return _then(_self.copyWith(defaultNetwork: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, createFactory: false)
class _ConnectionConfig implements ConnectionConfig {
  const _ConnectionConfig(
      {required this.defaultNetworkId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      required this.defaultNetwork,
      final List<ConnectionNetwork>? networks,
      final List<CustomNetworkOption>? customNetworkOptions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final List<NetworkType>? customNetworkOptionTypes})
      : _networks = networks,
        _customNetworkOptions = customNetworkOptions,
        _customNetworkOptionTypes = customNetworkOptionTypes;

  @override
  final String defaultNetworkId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ConnectionNetwork defaultNetwork;
  final List<ConnectionNetwork>? _networks;
  @override
  List<ConnectionNetwork>? get networks {
    final value = _networks;
    if (value == null) return null;
    if (_networks is EqualUnmodifiableListView) return _networks;
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
            (identical(other.defaultNetworkId, defaultNetworkId) ||
                other.defaultNetworkId == defaultNetworkId) &&
            (identical(other.defaultNetwork, defaultNetwork) ||
                other.defaultNetwork == defaultNetwork) &&
            const DeepCollectionEquality().equals(other._networks, _networks) &&
            const DeepCollectionEquality()
                .equals(other._customNetworkOptions, _customNetworkOptions) &&
            const DeepCollectionEquality().equals(
                other._customNetworkOptionTypes, _customNetworkOptionTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      defaultNetworkId,
      defaultNetwork,
      const DeepCollectionEquality().hash(_networks),
      const DeepCollectionEquality().hash(_customNetworkOptions),
      const DeepCollectionEquality().hash(_customNetworkOptionTypes));

  @override
  String toString() {
    return 'ConnectionConfig._(defaultNetworkId: $defaultNetworkId, defaultNetwork: $defaultNetwork, networks: $networks, customNetworkOptions: $customNetworkOptions, customNetworkOptionTypes: $customNetworkOptionTypes)';
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
      {String defaultNetworkId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      ConnectionNetwork defaultNetwork,
      List<ConnectionNetwork>? networks,
      List<CustomNetworkOption>? customNetworkOptions,
      @JsonKey(includeFromJson: false, includeToJson: false)
      List<NetworkType>? customNetworkOptionTypes});

  @override
  $ConnectionNetworkCopyWith<$Res> get defaultNetwork;
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
    Object? defaultNetworkId = null,
    Object? defaultNetwork = null,
    Object? networks = freezed,
    Object? customNetworkOptions = freezed,
    Object? customNetworkOptionTypes = freezed,
  }) {
    return _then(_ConnectionConfig(
      defaultNetworkId: null == defaultNetworkId
          ? _self.defaultNetworkId
          : defaultNetworkId // ignore: cast_nullable_to_non_nullable
              as String,
      defaultNetwork: null == defaultNetwork
          ? _self.defaultNetwork
          : defaultNetwork // ignore: cast_nullable_to_non_nullable
              as ConnectionNetwork,
      networks: freezed == networks
          ? _self._networks
          : networks // ignore: cast_nullable_to_non_nullable
              as List<ConnectionNetwork>?,
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
  $ConnectionNetworkCopyWith<$Res> get defaultNetwork {
    return $ConnectionNetworkCopyWith<$Res>(_self.defaultNetwork, (value) {
      return _then(_self.copyWith(defaultNetwork: value));
    });
  }
}

// dart format on
