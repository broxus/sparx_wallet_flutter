import 'package:app/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'gasless_estimate_response_dto.g.dart';

@JsonSerializable()
class GaslessEstimateResponseDto {
  const GaslessEstimateResponseDto({
    required this.protocolName,
    required this.relayAddress,
    required this.from,
    required this.messages,
    required this.commission,
    required this.validUntil,
  });

  factory GaslessEstimateResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GaslessEstimateResponseDtoFromJson(json);

  final String protocolName;
  final Address relayAddress;
  final BigInt commission;
  final Address from;
  @timestampFromStringJsonConverter
  final DateTime validUntil;
  final List<SignRawMessageDto> messages;

  Map<String, dynamic> toJson() => _$GaslessEstimateResponseDtoToJson(this);
}

@JsonSerializable()
class SignRawMessageDto {
  const SignRawMessageDto({
    required this.address,
    required this.amount,
    this.payload,
    this.stateInit,
  });

  factory SignRawMessageDto.fromJson(Map<String, dynamic> json) =>
      _$SignRawMessageDtoFromJson(json);

  final Address address;
  final BigInt amount;
  final String? payload;
  final String? stateInit;

  Map<String, dynamic> toJson() => _$SignRawMessageDtoToJson(this);
}
