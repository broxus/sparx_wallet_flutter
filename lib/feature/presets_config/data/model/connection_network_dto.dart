import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_network_dto.freezed.dart';
part 'connection_network_dto.g.dart';

@freezed
class ConnectionNetworkDto with _$ConnectionNetworkDto {
  const factory ConnectionNetworkDto({
    required String defaultConnectionId,
    required List<Map<String, dynamic>> networks,
    required List<Map<String, dynamic>> transports,
    List<Map<String, dynamic>>? customNetworkOtions,
  }) = _ConnectionNetworkDto;

  factory ConnectionNetworkDto.fromJson(Map<String, dynamic> json) =>
      _$ConnectionNetworkDtoFromJson(json);
}
