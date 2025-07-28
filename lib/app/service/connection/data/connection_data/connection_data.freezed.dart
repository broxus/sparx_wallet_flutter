// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ConnectionData _$ConnectionDataFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'gql':
      return ConnectionDataGql.fromJson(json);
    case 'proto':
      return ConnectionDataProto.fromJson(json);
    case 'jrpc':
      return ConnectionDataJrpc.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ConnectionData',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ConnectionData {
  String get id;
  String get name;
  String get group;
  NetworkType get networkType;
  String get blockExplorerUrl;
  String get nativeTokenTicker;
  bool get isPreset;
  bool get canBeEdited;
  double get sortingOrder;
  bool get isUsedOnStart;
  String get manifestUrl;
  int get nativeTokenDecimals;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionDataCopyWith<ConnectionData> get copyWith =>
      _$ConnectionDataCopyWithImpl<ConnectionData>(
          this as ConnectionData, _$identity);

  /// Serializes this ConnectionData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectionData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.blockExplorerUrl, blockExplorerUrl) ||
                other.blockExplorerUrl == blockExplorerUrl) &&
            (identical(other.nativeTokenTicker, nativeTokenTicker) ||
                other.nativeTokenTicker == nativeTokenTicker) &&
            (identical(other.isPreset, isPreset) ||
                other.isPreset == isPreset) &&
            (identical(other.canBeEdited, canBeEdited) ||
                other.canBeEdited == canBeEdited) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder) &&
            (identical(other.isUsedOnStart, isUsedOnStart) ||
                other.isUsedOnStart == isUsedOnStart) &&
            (identical(other.manifestUrl, manifestUrl) ||
                other.manifestUrl == manifestUrl) &&
            (identical(other.nativeTokenDecimals, nativeTokenDecimals) ||
                other.nativeTokenDecimals == nativeTokenDecimals));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      group,
      networkType,
      blockExplorerUrl,
      nativeTokenTicker,
      isPreset,
      canBeEdited,
      sortingOrder,
      isUsedOnStart,
      manifestUrl,
      nativeTokenDecimals);

  @override
  String toString() {
    return 'ConnectionData(id: $id, name: $name, group: $group, networkType: $networkType, blockExplorerUrl: $blockExplorerUrl, nativeTokenTicker: $nativeTokenTicker, isPreset: $isPreset, canBeEdited: $canBeEdited, sortingOrder: $sortingOrder, isUsedOnStart: $isUsedOnStart, manifestUrl: $manifestUrl, nativeTokenDecimals: $nativeTokenDecimals)';
  }
}

/// @nodoc
abstract mixin class $ConnectionDataCopyWith<$Res> {
  factory $ConnectionDataCopyWith(
          ConnectionData value, $Res Function(ConnectionData) _then) =
      _$ConnectionDataCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String group,
      NetworkType networkType,
      String blockExplorerUrl,
      String nativeTokenTicker,
      bool isPreset,
      bool canBeEdited,
      double sortingOrder,
      bool isUsedOnStart,
      String manifestUrl,
      int nativeTokenDecimals});
}

/// @nodoc
class _$ConnectionDataCopyWithImpl<$Res>
    implements $ConnectionDataCopyWith<$Res> {
  _$ConnectionDataCopyWithImpl(this._self, this._then);

  final ConnectionData _self;
  final $Res Function(ConnectionData) _then;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? group = null,
    Object? networkType = null,
    Object? blockExplorerUrl = null,
    Object? nativeTokenTicker = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
    Object? sortingOrder = null,
    Object? isUsedOnStart = null,
    Object? manifestUrl = null,
    Object? nativeTokenDecimals = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      group: null == group
          ? _self.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      blockExplorerUrl: null == blockExplorerUrl
          ? _self.blockExplorerUrl
          : blockExplorerUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenTicker: null == nativeTokenTicker
          ? _self.nativeTokenTicker
          : nativeTokenTicker // ignore: cast_nullable_to_non_nullable
              as String,
      isPreset: null == isPreset
          ? _self.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _self.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      isUsedOnStart: null == isUsedOnStart
          ? _self.isUsedOnStart
          : isUsedOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      manifestUrl: null == manifestUrl
          ? _self.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenDecimals: null == nativeTokenDecimals
          ? _self.nativeTokenDecimals
          : nativeTokenDecimals // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class ConnectionDataGql implements ConnectionData {
  const ConnectionDataGql(
      {required this.id,
      required this.name,
      required this.group,
      required final List<String> endpoints,
      required this.networkType,
      required this.isLocal,
      required this.blockExplorerUrl,
      required this.nativeTokenTicker,
      required this.isPreset,
      required this.canBeEdited,
      required this.sortingOrder,
      this.isUsedOnStart = true,
      this.manifestUrl = '',
      this.nativeTokenDecimals = 9,
      this.latencyDetectionInterval,
      this.maxLatency,
      this.endpointSelectionRetryCount,
      final String? $type})
      : _endpoints = endpoints,
        $type = $type ?? 'gql';
  factory ConnectionDataGql.fromJson(Map<String, dynamic> json) =>
      _$ConnectionDataGqlFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String group;
  final List<String> _endpoints;
  List<String> get endpoints {
    if (_endpoints is EqualUnmodifiableListView) return _endpoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_endpoints);
  }

  @override
  final NetworkType networkType;
  final bool isLocal;
  @override
  final String blockExplorerUrl;
  @override
  final String nativeTokenTicker;
  @override
  final bool isPreset;
  @override
  final bool canBeEdited;
  @override
  final double sortingOrder;
  @override
  @JsonKey()
  final bool isUsedOnStart;
  @override
  @JsonKey()
  final String manifestUrl;
  @override
  @JsonKey()
  final int nativeTokenDecimals;
  final int? latencyDetectionInterval;
  final int? maxLatency;
  final int? endpointSelectionRetryCount;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionDataGqlCopyWith<ConnectionDataGql> get copyWith =>
      _$ConnectionDataGqlCopyWithImpl<ConnectionDataGql>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectionDataGqlToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectionDataGql &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.group, group) || other.group == group) &&
            const DeepCollectionEquality()
                .equals(other._endpoints, _endpoints) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.isLocal, isLocal) || other.isLocal == isLocal) &&
            (identical(other.blockExplorerUrl, blockExplorerUrl) ||
                other.blockExplorerUrl == blockExplorerUrl) &&
            (identical(other.nativeTokenTicker, nativeTokenTicker) ||
                other.nativeTokenTicker == nativeTokenTicker) &&
            (identical(other.isPreset, isPreset) ||
                other.isPreset == isPreset) &&
            (identical(other.canBeEdited, canBeEdited) ||
                other.canBeEdited == canBeEdited) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder) &&
            (identical(other.isUsedOnStart, isUsedOnStart) ||
                other.isUsedOnStart == isUsedOnStart) &&
            (identical(other.manifestUrl, manifestUrl) ||
                other.manifestUrl == manifestUrl) &&
            (identical(other.nativeTokenDecimals, nativeTokenDecimals) ||
                other.nativeTokenDecimals == nativeTokenDecimals) &&
            (identical(
                    other.latencyDetectionInterval, latencyDetectionInterval) ||
                other.latencyDetectionInterval == latencyDetectionInterval) &&
            (identical(other.maxLatency, maxLatency) ||
                other.maxLatency == maxLatency) &&
            (identical(other.endpointSelectionRetryCount,
                    endpointSelectionRetryCount) ||
                other.endpointSelectionRetryCount ==
                    endpointSelectionRetryCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      group,
      const DeepCollectionEquality().hash(_endpoints),
      networkType,
      isLocal,
      blockExplorerUrl,
      nativeTokenTicker,
      isPreset,
      canBeEdited,
      sortingOrder,
      isUsedOnStart,
      manifestUrl,
      nativeTokenDecimals,
      latencyDetectionInterval,
      maxLatency,
      endpointSelectionRetryCount);

  @override
  String toString() {
    return 'ConnectionData.gql(id: $id, name: $name, group: $group, endpoints: $endpoints, networkType: $networkType, isLocal: $isLocal, blockExplorerUrl: $blockExplorerUrl, nativeTokenTicker: $nativeTokenTicker, isPreset: $isPreset, canBeEdited: $canBeEdited, sortingOrder: $sortingOrder, isUsedOnStart: $isUsedOnStart, manifestUrl: $manifestUrl, nativeTokenDecimals: $nativeTokenDecimals, latencyDetectionInterval: $latencyDetectionInterval, maxLatency: $maxLatency, endpointSelectionRetryCount: $endpointSelectionRetryCount)';
  }
}

/// @nodoc
abstract mixin class $ConnectionDataGqlCopyWith<$Res>
    implements $ConnectionDataCopyWith<$Res> {
  factory $ConnectionDataGqlCopyWith(
          ConnectionDataGql value, $Res Function(ConnectionDataGql) _then) =
      _$ConnectionDataGqlCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String group,
      List<String> endpoints,
      NetworkType networkType,
      bool isLocal,
      String blockExplorerUrl,
      String nativeTokenTicker,
      bool isPreset,
      bool canBeEdited,
      double sortingOrder,
      bool isUsedOnStart,
      String manifestUrl,
      int nativeTokenDecimals,
      int? latencyDetectionInterval,
      int? maxLatency,
      int? endpointSelectionRetryCount});
}

/// @nodoc
class _$ConnectionDataGqlCopyWithImpl<$Res>
    implements $ConnectionDataGqlCopyWith<$Res> {
  _$ConnectionDataGqlCopyWithImpl(this._self, this._then);

  final ConnectionDataGql _self;
  final $Res Function(ConnectionDataGql) _then;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? group = null,
    Object? endpoints = null,
    Object? networkType = null,
    Object? isLocal = null,
    Object? blockExplorerUrl = null,
    Object? nativeTokenTicker = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
    Object? sortingOrder = null,
    Object? isUsedOnStart = null,
    Object? manifestUrl = null,
    Object? nativeTokenDecimals = null,
    Object? latencyDetectionInterval = freezed,
    Object? maxLatency = freezed,
    Object? endpointSelectionRetryCount = freezed,
  }) {
    return _then(ConnectionDataGql(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      group: null == group
          ? _self.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      endpoints: null == endpoints
          ? _self._endpoints
          : endpoints // ignore: cast_nullable_to_non_nullable
              as List<String>,
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      isLocal: null == isLocal
          ? _self.isLocal
          : isLocal // ignore: cast_nullable_to_non_nullable
              as bool,
      blockExplorerUrl: null == blockExplorerUrl
          ? _self.blockExplorerUrl
          : blockExplorerUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenTicker: null == nativeTokenTicker
          ? _self.nativeTokenTicker
          : nativeTokenTicker // ignore: cast_nullable_to_non_nullable
              as String,
      isPreset: null == isPreset
          ? _self.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _self.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      isUsedOnStart: null == isUsedOnStart
          ? _self.isUsedOnStart
          : isUsedOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      manifestUrl: null == manifestUrl
          ? _self.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenDecimals: null == nativeTokenDecimals
          ? _self.nativeTokenDecimals
          : nativeTokenDecimals // ignore: cast_nullable_to_non_nullable
              as int,
      latencyDetectionInterval: freezed == latencyDetectionInterval
          ? _self.latencyDetectionInterval
          : latencyDetectionInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLatency: freezed == maxLatency
          ? _self.maxLatency
          : maxLatency // ignore: cast_nullable_to_non_nullable
              as int?,
      endpointSelectionRetryCount: freezed == endpointSelectionRetryCount
          ? _self.endpointSelectionRetryCount
          : endpointSelectionRetryCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class ConnectionDataProto implements ConnectionData {
  const ConnectionDataProto(
      {required this.id,
      required this.name,
      required this.group,
      required this.endpoint,
      required this.networkType,
      required this.blockExplorerUrl,
      required this.nativeTokenTicker,
      required this.isPreset,
      required this.canBeEdited,
      required this.sortingOrder,
      this.isUsedOnStart = true,
      this.manifestUrl = '',
      this.nativeTokenDecimals = 9,
      final String? $type})
      : $type = $type ?? 'proto';
  factory ConnectionDataProto.fromJson(Map<String, dynamic> json) =>
      _$ConnectionDataProtoFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String group;
  final String endpoint;
  @override
  final NetworkType networkType;
  @override
  final String blockExplorerUrl;
  @override
  final String nativeTokenTicker;
  @override
  final bool isPreset;
  @override
  final bool canBeEdited;
  @override
  final double sortingOrder;
  @override
  @JsonKey()
  final bool isUsedOnStart;
  @override
  @JsonKey()
  final String manifestUrl;
  @override
  @JsonKey()
  final int nativeTokenDecimals;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionDataProtoCopyWith<ConnectionDataProto> get copyWith =>
      _$ConnectionDataProtoCopyWithImpl<ConnectionDataProto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectionDataProtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectionDataProto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.blockExplorerUrl, blockExplorerUrl) ||
                other.blockExplorerUrl == blockExplorerUrl) &&
            (identical(other.nativeTokenTicker, nativeTokenTicker) ||
                other.nativeTokenTicker == nativeTokenTicker) &&
            (identical(other.isPreset, isPreset) ||
                other.isPreset == isPreset) &&
            (identical(other.canBeEdited, canBeEdited) ||
                other.canBeEdited == canBeEdited) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder) &&
            (identical(other.isUsedOnStart, isUsedOnStart) ||
                other.isUsedOnStart == isUsedOnStart) &&
            (identical(other.manifestUrl, manifestUrl) ||
                other.manifestUrl == manifestUrl) &&
            (identical(other.nativeTokenDecimals, nativeTokenDecimals) ||
                other.nativeTokenDecimals == nativeTokenDecimals));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      group,
      endpoint,
      networkType,
      blockExplorerUrl,
      nativeTokenTicker,
      isPreset,
      canBeEdited,
      sortingOrder,
      isUsedOnStart,
      manifestUrl,
      nativeTokenDecimals);

  @override
  String toString() {
    return 'ConnectionData.proto(id: $id, name: $name, group: $group, endpoint: $endpoint, networkType: $networkType, blockExplorerUrl: $blockExplorerUrl, nativeTokenTicker: $nativeTokenTicker, isPreset: $isPreset, canBeEdited: $canBeEdited, sortingOrder: $sortingOrder, isUsedOnStart: $isUsedOnStart, manifestUrl: $manifestUrl, nativeTokenDecimals: $nativeTokenDecimals)';
  }
}

/// @nodoc
abstract mixin class $ConnectionDataProtoCopyWith<$Res>
    implements $ConnectionDataCopyWith<$Res> {
  factory $ConnectionDataProtoCopyWith(
          ConnectionDataProto value, $Res Function(ConnectionDataProto) _then) =
      _$ConnectionDataProtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String group,
      String endpoint,
      NetworkType networkType,
      String blockExplorerUrl,
      String nativeTokenTicker,
      bool isPreset,
      bool canBeEdited,
      double sortingOrder,
      bool isUsedOnStart,
      String manifestUrl,
      int nativeTokenDecimals});
}

/// @nodoc
class _$ConnectionDataProtoCopyWithImpl<$Res>
    implements $ConnectionDataProtoCopyWith<$Res> {
  _$ConnectionDataProtoCopyWithImpl(this._self, this._then);

  final ConnectionDataProto _self;
  final $Res Function(ConnectionDataProto) _then;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? group = null,
    Object? endpoint = null,
    Object? networkType = null,
    Object? blockExplorerUrl = null,
    Object? nativeTokenTicker = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
    Object? sortingOrder = null,
    Object? isUsedOnStart = null,
    Object? manifestUrl = null,
    Object? nativeTokenDecimals = null,
  }) {
    return _then(ConnectionDataProto(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      group: null == group
          ? _self.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: null == endpoint
          ? _self.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      blockExplorerUrl: null == blockExplorerUrl
          ? _self.blockExplorerUrl
          : blockExplorerUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenTicker: null == nativeTokenTicker
          ? _self.nativeTokenTicker
          : nativeTokenTicker // ignore: cast_nullable_to_non_nullable
              as String,
      isPreset: null == isPreset
          ? _self.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _self.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      isUsedOnStart: null == isUsedOnStart
          ? _self.isUsedOnStart
          : isUsedOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      manifestUrl: null == manifestUrl
          ? _self.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenDecimals: null == nativeTokenDecimals
          ? _self.nativeTokenDecimals
          : nativeTokenDecimals // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class ConnectionDataJrpc implements ConnectionData {
  const ConnectionDataJrpc(
      {required this.id,
      required this.name,
      required this.group,
      required this.endpoint,
      required this.networkType,
      required this.blockExplorerUrl,
      required this.nativeTokenTicker,
      required this.isPreset,
      required this.canBeEdited,
      required this.sortingOrder,
      this.isUsedOnStart = true,
      this.manifestUrl = '',
      this.nativeTokenDecimals = 9,
      final String? $type})
      : $type = $type ?? 'jrpc';
  factory ConnectionDataJrpc.fromJson(Map<String, dynamic> json) =>
      _$ConnectionDataJrpcFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String group;
  final String endpoint;
  @override
  final NetworkType networkType;
  @override
  final String blockExplorerUrl;
  @override
  final String nativeTokenTicker;
  @override
  final bool isPreset;
  @override
  final bool canBeEdited;
  @override
  final double sortingOrder;
  @override
  @JsonKey()
  final bool isUsedOnStart;
  @override
  @JsonKey()
  final String manifestUrl;
  @override
  @JsonKey()
  final int nativeTokenDecimals;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionDataJrpcCopyWith<ConnectionDataJrpc> get copyWith =>
      _$ConnectionDataJrpcCopyWithImpl<ConnectionDataJrpc>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectionDataJrpcToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectionDataJrpc &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.blockExplorerUrl, blockExplorerUrl) ||
                other.blockExplorerUrl == blockExplorerUrl) &&
            (identical(other.nativeTokenTicker, nativeTokenTicker) ||
                other.nativeTokenTicker == nativeTokenTicker) &&
            (identical(other.isPreset, isPreset) ||
                other.isPreset == isPreset) &&
            (identical(other.canBeEdited, canBeEdited) ||
                other.canBeEdited == canBeEdited) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder) &&
            (identical(other.isUsedOnStart, isUsedOnStart) ||
                other.isUsedOnStart == isUsedOnStart) &&
            (identical(other.manifestUrl, manifestUrl) ||
                other.manifestUrl == manifestUrl) &&
            (identical(other.nativeTokenDecimals, nativeTokenDecimals) ||
                other.nativeTokenDecimals == nativeTokenDecimals));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      group,
      endpoint,
      networkType,
      blockExplorerUrl,
      nativeTokenTicker,
      isPreset,
      canBeEdited,
      sortingOrder,
      isUsedOnStart,
      manifestUrl,
      nativeTokenDecimals);

  @override
  String toString() {
    return 'ConnectionData.jrpc(id: $id, name: $name, group: $group, endpoint: $endpoint, networkType: $networkType, blockExplorerUrl: $blockExplorerUrl, nativeTokenTicker: $nativeTokenTicker, isPreset: $isPreset, canBeEdited: $canBeEdited, sortingOrder: $sortingOrder, isUsedOnStart: $isUsedOnStart, manifestUrl: $manifestUrl, nativeTokenDecimals: $nativeTokenDecimals)';
  }
}

/// @nodoc
abstract mixin class $ConnectionDataJrpcCopyWith<$Res>
    implements $ConnectionDataCopyWith<$Res> {
  factory $ConnectionDataJrpcCopyWith(
          ConnectionDataJrpc value, $Res Function(ConnectionDataJrpc) _then) =
      _$ConnectionDataJrpcCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String group,
      String endpoint,
      NetworkType networkType,
      String blockExplorerUrl,
      String nativeTokenTicker,
      bool isPreset,
      bool canBeEdited,
      double sortingOrder,
      bool isUsedOnStart,
      String manifestUrl,
      int nativeTokenDecimals});
}

/// @nodoc
class _$ConnectionDataJrpcCopyWithImpl<$Res>
    implements $ConnectionDataJrpcCopyWith<$Res> {
  _$ConnectionDataJrpcCopyWithImpl(this._self, this._then);

  final ConnectionDataJrpc _self;
  final $Res Function(ConnectionDataJrpc) _then;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? group = null,
    Object? endpoint = null,
    Object? networkType = null,
    Object? blockExplorerUrl = null,
    Object? nativeTokenTicker = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
    Object? sortingOrder = null,
    Object? isUsedOnStart = null,
    Object? manifestUrl = null,
    Object? nativeTokenDecimals = null,
  }) {
    return _then(ConnectionDataJrpc(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      group: null == group
          ? _self.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: null == endpoint
          ? _self.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      blockExplorerUrl: null == blockExplorerUrl
          ? _self.blockExplorerUrl
          : blockExplorerUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenTicker: null == nativeTokenTicker
          ? _self.nativeTokenTicker
          : nativeTokenTicker // ignore: cast_nullable_to_non_nullable
              as String,
      isPreset: null == isPreset
          ? _self.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _self.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      sortingOrder: null == sortingOrder
          ? _self.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      isUsedOnStart: null == isUsedOnStart
          ? _self.isUsedOnStart
          : isUsedOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      manifestUrl: null == manifestUrl
          ? _self.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenDecimals: null == nativeTokenDecimals
          ? _self.nativeTokenDecimals
          : nativeTokenDecimals // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
