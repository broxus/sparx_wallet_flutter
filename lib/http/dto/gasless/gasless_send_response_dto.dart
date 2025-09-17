import 'package:json_annotation/json_annotation.dart';

part 'gasless_send_response_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GaslessSendResponseDto {
  const GaslessSendResponseDto({
    required this.protocolName,
    required this.transactionHash,
  });

  factory GaslessSendResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GaslessSendResponseDtoFromJson(json);

  final String protocolName;
  final String transactionHash;

  Map<String, dynamic> toJson() => _$GaslessSendResponseDtoToJson(this);
}
