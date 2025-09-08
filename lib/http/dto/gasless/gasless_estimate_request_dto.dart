import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'gasless_estimate_request_dto.g.dart';

@JsonSerializable()
class GaslessEstimateRequestDto {
  const GaslessEstimateRequestDto({
    required this.walletAddress,
    required this.walletPublicKey,
    required this.messages,
  });

  factory GaslessEstimateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GaslessEstimateRequestDtoFromJson(json);

  final Address walletAddress;
  final PublicKey walletPublicKey;
  final List<MessageDto> messages;

  Map<String, dynamic> toJson() => _$GaslessEstimateRequestDtoToJson(this);
}

@JsonSerializable()
class MessageDto {
  const MessageDto({
    required this.boc,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  final String boc;

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);
}
