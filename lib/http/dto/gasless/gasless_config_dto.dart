import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'gasless_config_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GaslessConfigDto {
  const GaslessConfigDto({
    required this.relayAddress,
    required this.gasJettons,
  });

  factory GaslessConfigDto.fromJson(Map<String, dynamic> json) =>
      _$GaslessConfigDtoFromJson(json);

  final Address relayAddress;
  final List<GasJettonDto> gasJettons;

  Map<String, dynamic> toJson() => _$GaslessConfigDtoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GasJettonDto {
  const GasJettonDto({required this.masterId});

  factory GasJettonDto.fromJson(Map<String, dynamic> json) =>
      _$GasJettonDtoFromJson(json);

  final Address masterId;

  Map<String, dynamic> toJson() => _$GasJettonDtoToJson(this);
}
