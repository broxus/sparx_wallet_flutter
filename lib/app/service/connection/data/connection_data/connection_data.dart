// import 'package:app/app/service/connection/data/network_type.dart';
// import 'package:app/utils/utils.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:uuid/uuid.dart';
//
// part 'connection_data.freezed.dart';
// part 'connection_data.g.dart';
//
// @freezed
// sealed class ConnectionData with _$ConnectionData {
//   const factory ConnectionData.gql({
//     required String id,
//     // required String name,
//     required String group,
//     required List<String> endpoints,
//     required NetworkType networkType,
//     required bool isLocal,
//     required String blockExplorerUrl,
//     required String nativeTokenTicker,
//     required bool isPreset,
//     required bool canBeEdited,
//     // required double sortingOrder,
//     @Default(true) bool isUsedOnStart,
//     @Default('') String manifestUrl,
//     @Default(9) int nativeTokenDecimals,
//     int? latencyDetectionInterval,
//     int? maxLatency,
//     int? endpointSelectionRetryCount,
//   }) = ConnectionDataGql;
//
//   factory ConnectionData.gqlCustom({
//     // required String name,
//     required String group,
//     required List<String> endpoints,
//     required bool isLocal,
//     required String blockExplorerUrl,
//     required String nativeTokenTicker,
//     required NetworkType networkType,
//     bool isUsedOnStart = false,
//     int nativeTokenDecimals = 9,
//     String? manifestUrl,
//     String? id,
//     int? latencyDetectionInterval,
//     int? maxLatency,
//     int? endpointSelectionRetryCount,
//   }) =>
//       ConnectionData.gql(
//         id: id ?? const Uuid().v4(),
//         // name: name,
//         group: group,
//         endpoints: endpoints,
//         networkType: networkType,
//         isLocal: isLocal,
//         blockExplorerUrl: blockExplorerUrl,
//         manifestUrl: manifestUrl ?? '',
//         nativeTokenTicker: nativeTokenTicker,
//         isPreset: false,
//         canBeEdited: true,
//         // sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
//         latencyDetectionInterval: latencyDetectionInterval,
//         maxLatency: maxLatency,
//         endpointSelectionRetryCount: endpointSelectionRetryCount,
//         isUsedOnStart: isUsedOnStart,
//         nativeTokenDecimals: nativeTokenDecimals,
//       );
//
//   factory ConnectionData.gqlPreset({
//     required String id,
//     // required String name,
//     required String group,
//     required List<String> endpoints,
//     required NetworkType networkType,
//     required String blockExplorerUrl,
//     required bool canBeEdited,
//     // required double sortingOrder,
//     bool isUsedOnStart = true,
//     int nativeTokenDecimals = 9,
//     String? manifestUrl,
//     int? latencyDetectionInterval,
//     int? maxLatency,
//     int? endpointSelectionRetryCount,
//   }) =>
//       ConnectionData.gql(
//         id: id,
//         // name: name,
//         group: group,
//         endpoints: endpoints,
//         networkType: networkType,
//         isLocal: false,
//         blockExplorerUrl: blockExplorerUrl,
//         manifestUrl: manifestUrl ?? '',
//         nativeTokenTicker: '',
//         isPreset: true,
//         canBeEdited: canBeEdited,
//         // sortingOrder: sortingOrder,
//         latencyDetectionInterval: latencyDetectionInterval,
//         maxLatency: maxLatency,
//         endpointSelectionRetryCount: endpointSelectionRetryCount,
//         isUsedOnStart: isUsedOnStart,
//         nativeTokenDecimals: nativeTokenDecimals,
//       );
//
//   factory ConnectionData.gqlTemporary({
//     required List<String> endpoints,
//     required bool isLocal,
//     required NetworkType networkType,
//     bool isUsedOnStart = false,
//     int nativeTokenDecimals = 9,
//     int? latencyDetectionInterval,
//     int? maxLatency,
//     int? endpointSelectionRetryCount,
//   }) =>
//       ConnectionData.gql(
//         id: const Uuid().v4(),
//         // name: const Uuid().v4(),
//         group: const Uuid().v4(),
//         endpoints: endpoints,
//         networkType: networkType,
//         isLocal: isLocal,
//         blockExplorerUrl: '',
//         nativeTokenTicker: '',
//         isPreset: false,
//         canBeEdited: true,
//         // sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
//         latencyDetectionInterval: latencyDetectionInterval,
//         maxLatency: maxLatency,
//         endpointSelectionRetryCount: endpointSelectionRetryCount,
//         isUsedOnStart: isUsedOnStart,
//         nativeTokenDecimals: nativeTokenDecimals,
//       );
//
//   const factory ConnectionData.proto({
//     required String id,
//     // required String name,
//     required String group,
//     required String endpoint,
//     required NetworkType networkType,
//     required String blockExplorerUrl,
//     required String nativeTokenTicker,
//     required bool isPreset,
//     required bool canBeEdited,
//     // required double sortingOrder,
//     @Default(true) bool isUsedOnStart,
//     @Default('') String manifestUrl,
//     @Default(9) int nativeTokenDecimals,
//   }) = ConnectionDataProto;
//
//   factory ConnectionData.protoCustom({
//     // required String name,
//     required String group,
//     required String endpoint,
//     required String blockExplorerUrl,
//     required String nativeTokenTicker,
//     required NetworkType networkType,
//     bool isUsedOnStart = false,
//     int nativeTokenDecimals = 9,
//     String? manifestUrl,
//     String? id,
//   }) =>
//       ConnectionData.proto(
//         id: id ?? const Uuid().v4(),
//         // name: name,
//         group: group,
//         endpoint: endpoint,
//         networkType: networkType,
//         blockExplorerUrl: blockExplorerUrl,
//         manifestUrl: manifestUrl ?? '',
//         nativeTokenTicker: nativeTokenTicker,
//         isPreset: false,
//         canBeEdited: true,
//         // sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
//         isUsedOnStart: isUsedOnStart,
//         nativeTokenDecimals: nativeTokenDecimals,
//       );
//
//   factory ConnectionData.protoPreset({
//     required String id,
//     // required String name,
//     required String group,
//     required String endpoint,
//     required NetworkType networkType,
//     required String blockExplorerUrl,
//     required bool canBeEdited,
//     // required double sortingOrder,
//     bool isUsedOnStart = true,
//     int nativeTokenDecimals = 9,
//     String? manifestUrl,
//   }) =>
//       ConnectionData.proto(
//         id: id,
//         // name: name,
//         group: group,
//         endpoint: endpoint,
//         networkType: networkType,
//         blockExplorerUrl: blockExplorerUrl,
//         manifestUrl: manifestUrl ?? '',
//         nativeTokenTicker: '',
//         isPreset: true,
//         canBeEdited: canBeEdited,
//         // sortingOrder: sortingOrder,
//         isUsedOnStart: isUsedOnStart,
//         nativeTokenDecimals: nativeTokenDecimals,
//       );
//
//   factory ConnectionData.protoTemporary({
//     required String endpoint,
//     required NetworkType networkType,
//     bool isUsedOnStart = false,
//     int nativeTokenDecimals = 9,
//   }) =>
//       ConnectionData.proto(
//         id: const Uuid().v4(),
//         // name: const Uuid().v4(),
//         group: const Uuid().v4(),
//         endpoint: endpoint,
//         networkType: networkType,
//         blockExplorerUrl: '',
//         nativeTokenTicker: '',
//         isPreset: false,
//         canBeEdited: true,
//         // sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
//         isUsedOnStart: isUsedOnStart,
//         nativeTokenDecimals: nativeTokenDecimals,
//       );
//
//   const factory ConnectionData.jrpc({
//     required String id,
//     // required String name,
//     required String group,
//     required String endpoint,
//     required NetworkType networkType,
//     required String blockExplorerUrl,
//     required String nativeTokenTicker,
//     required bool isPreset,
//     required bool canBeEdited,
//     // required double sortingOrder,
//     @Default(true) bool isUsedOnStart,
//     @Default('') String manifestUrl,
//     @Default(9) int nativeTokenDecimals,
//   }) = ConnectionDataJrpc;
//
//   factory ConnectionData.jrpcCustom({
//     // required String name,
//     required String group,
//     required String endpoint,
//     required String blockExplorerUrl,
//     required String nativeTokenTicker,
//     required NetworkType networkType,
//     bool isUsedOnStart = false,
//     int nativeTokenDecimals = 9,
//     String? manifestUrl,
//     String? id,
//   }) =>
//       ConnectionData.jrpc(
//         id: id ?? const Uuid().v4(),
//         // name: name,
//         group: group,
//         endpoint: endpoint,
//         networkType: networkType,
//         blockExplorerUrl: blockExplorerUrl,
//         manifestUrl: manifestUrl ?? '',
//         nativeTokenTicker: nativeTokenTicker,
//         isPreset: false,
//         canBeEdited: true,
//         // sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
//         isUsedOnStart: isUsedOnStart,
//         nativeTokenDecimals: nativeTokenDecimals,
//       );
//
//   factory ConnectionData.jrpcPreset({
//     required String id,
//     // required String name,
//     required String group,
//     required String endpoint,
//     required NetworkType networkType,
//     required String blockExplorerUrl,
//     required bool canBeEdited,
//     // required double sortingOrder,
//     bool isUsedOnStart = true,
//     int nativeTokenDecimals = 9,
//     String? manifestUrl,
//   }) =>
//       ConnectionData.jrpc(
//         id: id,
//         // name: name,
//         group: group,
//         endpoint: endpoint,
//         networkType: networkType,
//         blockExplorerUrl: blockExplorerUrl,
//         manifestUrl: manifestUrl ?? '',
//         nativeTokenTicker: '',
//         isPreset: true,
//         canBeEdited: canBeEdited,
//         // sortingOrder: sortingOrder,
//         isUsedOnStart: isUsedOnStart,
//         nativeTokenDecimals: nativeTokenDecimals,
//       );
//
//   factory ConnectionData.jrpcTemporary({
//     required String endpoint,
//     required NetworkType networkType,
//     bool isUsedOnStart = false,
//     int nativeTokenDecimals = 9,
//   }) =>
//       ConnectionData.proto(
//         id: const Uuid().v4(),
//         // name: const Uuid().v4(),
//         group: const Uuid().v4(),
//         endpoint: endpoint,
//         networkType: networkType,
//         blockExplorerUrl: '',
//         nativeTokenTicker: '',
//         isPreset: false,
//         canBeEdited: true,
//         // sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
//         isUsedOnStart: isUsedOnStart,
//         nativeTokenDecimals: nativeTokenDecimals,
//       );
//
//   factory ConnectionData.fromJson(Map<String, dynamic> json) =>
//       _$ConnectionDataFromJson(json);
// }
