// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'connection_network_dto.freezed.dart';
//
// part 'connection_network_dto.g.dart';
//
// /// Network connection configuration data transfer object.
// ///
// /// Contains information about available networks, transports, and
// /// the default connection to use in the application.
// @freezed
// abstract class ConnectionNetworkDto with _$ConnectionNetworkDto {
//   const factory ConnectionNetworkDto({
//     /// Identifier for the default network connection to use.
//     required String defaultConnectionId,
//
//     /// List of available networks with their configuration details.
//     required List<Map<String, dynamic>> networks,
//
//     /// Optional custom network configuration options.
//     List<Map<String, dynamic>>? customNetworkOtions,
//   }) = _ConnectionNetworkDto;
//
//   factory ConnectionNetworkDto.fromJson(Map<String, dynamic> json) =>
//       _$ConnectionNetworkDtoFromJson(json);
// }
