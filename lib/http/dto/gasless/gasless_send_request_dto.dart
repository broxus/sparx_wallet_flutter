import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'gasless_send_request_dto.g.dart';

@JsonSerializable()
class GaslessSendRequestDto {
  const GaslessSendRequestDto({
    required this.walletPublicKey,
    required this.boc,
  });

  factory GaslessSendRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GaslessSendRequestDtoFromJson(json);

  final PublicKey walletPublicKey;
  final String boc;

  Map<String, dynamic> toJson() => _$GaslessSendRequestDtoToJson(this);
}
