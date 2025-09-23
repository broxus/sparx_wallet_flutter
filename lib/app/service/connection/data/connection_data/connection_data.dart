import 'package:app/app/service/connection/data/network_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'connection_data.freezed.dart';

part 'connection_data.g.dart';

@freezed
sealed class ConnectionData with _$ConnectionData {
  const factory ConnectionData.gql({
    required String name,
    required String group,
    required List<String> endpoints,
    required NetworkType networkType,
    required bool isLocal,
    required String blockExplorerUrl,
    required String nativeTokenTicker,
    required bool isPreset,
    required bool canBeEdited,
    @Default(true) bool isUsedOnStart,
    @Default('') String manifestUrl,
    @Default(9) int nativeTokenDecimals,
    int? latencyDetectionInterval,
    int? maxLatency,
    int? endpointSelectionRetryCount,
  }) = ConnectionDataGql;

  factory ConnectionData.gqlCustom({
    required String name,
    required String group,
    required List<String> endpoints,
    required bool isLocal,
    required String blockExplorerUrl,
    required String nativeTokenTicker,
    required NetworkType networkType,
    bool isUsedOnStart = false,
    int nativeTokenDecimals = 9,
    String? manifestUrl,
    int? latencyDetectionInterval,
    int? maxLatency,
    int? endpointSelectionRetryCount,
  }) =>
      ConnectionData.gql(
        name: name,
        group: group,
        endpoints: endpoints,
        networkType: networkType,
        isLocal: isLocal,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl ?? '',
        nativeTokenTicker: nativeTokenTicker,
        isPreset: false,
        canBeEdited: true,
        latencyDetectionInterval: latencyDetectionInterval,
        maxLatency: maxLatency,
        endpointSelectionRetryCount: endpointSelectionRetryCount,
        isUsedOnStart: isUsedOnStart,
        nativeTokenDecimals: nativeTokenDecimals,
      );

  factory ConnectionData.gqlPreset({
    required String name,
    required String group,
    required List<String> endpoints,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required bool canBeEdited,
    bool isUsedOnStart = true,
    int nativeTokenDecimals = 9,
    String? manifestUrl,
    int? latencyDetectionInterval,
    int? maxLatency,
    int? endpointSelectionRetryCount,
  }) =>
      ConnectionData.gql(
        name: name,
        group: group,
        endpoints: endpoints,
        networkType: networkType,
        isLocal: false,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl ?? '',
        nativeTokenTicker: '',
        isPreset: true,
        canBeEdited: canBeEdited,
        latencyDetectionInterval: latencyDetectionInterval,
        maxLatency: maxLatency,
        endpointSelectionRetryCount: endpointSelectionRetryCount,
        isUsedOnStart: isUsedOnStart,
        nativeTokenDecimals: nativeTokenDecimals,
      );

  factory ConnectionData.gqlTemporary({
    required List<String> endpoints,
    required bool isLocal,
    required NetworkType networkType,
    bool isUsedOnStart = false,
    int nativeTokenDecimals = 9,
    int? latencyDetectionInterval,
    int? maxLatency,
    int? endpointSelectionRetryCount,
  }) =>
      ConnectionData.gql(
        name: const Uuid().v4(),
        group: const Uuid().v4(),
        endpoints: endpoints,
        networkType: networkType,
        isLocal: isLocal,
        blockExplorerUrl: '',
        nativeTokenTicker: '',
        isPreset: false,
        canBeEdited: true,
        latencyDetectionInterval: latencyDetectionInterval,
        maxLatency: maxLatency,
        endpointSelectionRetryCount: endpointSelectionRetryCount,
        isUsedOnStart: isUsedOnStart,
        nativeTokenDecimals: nativeTokenDecimals,
      );

  const factory ConnectionData.proto({
    required String name,
    required String group,
    required String endpoint,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required String nativeTokenTicker,
    required bool isPreset,
    required bool canBeEdited,
    @Default(true) bool isUsedOnStart,
    @Default('') String manifestUrl,
    @Default(9) int nativeTokenDecimals,
  }) = ConnectionDataProto;

  factory ConnectionData.protoCustom({
    required String name,
    required String group,
    required String endpoint,
    required String blockExplorerUrl,
    required String nativeTokenTicker,
    required NetworkType networkType,
    bool isUsedOnStart = false,
    int nativeTokenDecimals = 9,
    String? manifestUrl,
  }) =>
      ConnectionData.proto(
        name: name,
        group: group,
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl ?? '',
        nativeTokenTicker: nativeTokenTicker,
        isPreset: false,
        canBeEdited: true,
        isUsedOnStart: isUsedOnStart,
        nativeTokenDecimals: nativeTokenDecimals,
      );

  factory ConnectionData.protoPreset({
    required String name,
    required String group,
    required String endpoint,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required bool canBeEdited,
    bool isUsedOnStart = true,
    int nativeTokenDecimals = 9,
    String? manifestUrl,
  }) =>
      ConnectionData.proto(
        name: name,
        group: group,
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl ?? '',
        nativeTokenTicker: '',
        isPreset: true,
        canBeEdited: canBeEdited,
        isUsedOnStart: isUsedOnStart,
        nativeTokenDecimals: nativeTokenDecimals,
      );

  factory ConnectionData.protoTemporary({
    required String endpoint,
    required NetworkType networkType,
    bool isUsedOnStart = false,
    int nativeTokenDecimals = 9,
  }) =>
      ConnectionData.proto(
        name: const Uuid().v4(),
        group: const Uuid().v4(),
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: '',
        nativeTokenTicker: '',
        isPreset: false,
        canBeEdited: true,
        isUsedOnStart: isUsedOnStart,
        nativeTokenDecimals: nativeTokenDecimals,
      );

  const factory ConnectionData.jrpc({
    required String name,
    required String group,
    required String endpoint,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required String nativeTokenTicker,
    required bool isPreset,
    required bool canBeEdited,
    @Default(true) bool isUsedOnStart,
    @Default('') String manifestUrl,
    @Default(9) int nativeTokenDecimals,
  }) = ConnectionDataJrpc;

  factory ConnectionData.jrpcCustom({
    required String name,
    required String group,
    required String endpoint,
    required String blockExplorerUrl,
    required String nativeTokenTicker,
    required NetworkType networkType,
    bool isUsedOnStart = false,
    int nativeTokenDecimals = 9,
    String? manifestUrl,
    String? id,
  }) =>
      ConnectionData.jrpc(
        name: name,
        group: group,
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl ?? '',
        nativeTokenTicker: nativeTokenTicker,
        isPreset: false,
        canBeEdited: true,
        isUsedOnStart: isUsedOnStart,
        nativeTokenDecimals: nativeTokenDecimals,
      );

  factory ConnectionData.jrpcPreset({
    required String name,
    required String group,
    required String endpoint,
    required NetworkType networkType,
    required String blockExplorerUrl,
    required bool canBeEdited,
    bool isUsedOnStart = true,
    int nativeTokenDecimals = 9,
    String? manifestUrl,
  }) =>
      ConnectionData.jrpc(
        name: name,
        group: group,
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: blockExplorerUrl,
        manifestUrl: manifestUrl ?? '',
        nativeTokenTicker: '',
        isPreset: true,
        canBeEdited: canBeEdited,
        isUsedOnStart: isUsedOnStart,
        nativeTokenDecimals: nativeTokenDecimals,
      );

  factory ConnectionData.jrpcTemporary({
    required String endpoint,
    required NetworkType networkType,
    bool isUsedOnStart = false,
    int nativeTokenDecimals = 9,
  }) =>
      ConnectionData.proto(
        name: const Uuid().v4(),
        group: const Uuid().v4(),
        endpoint: endpoint,
        networkType: networkType,
        blockExplorerUrl: '',
        nativeTokenTicker: '',
        isPreset: false,
        canBeEdited: true,
        isUsedOnStart: isUsedOnStart,
        nativeTokenDecimals: nativeTokenDecimals,
      );

  factory ConnectionData.fromJson(Map<String, dynamic> json) =>
      _$ConnectionDataFromJson(json);
}
