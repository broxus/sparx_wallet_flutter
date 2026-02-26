import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton_network.g.dart';

@JsonEnum(alwaysCreate: true)
enum TonNetwork {
  @JsonValue('-239')
  mainnet,
  @JsonValue('-3')
  testnet,
  @JsonValue('662387')
  tetra;

  int toInt() => int.parse(_$TonNetworkEnumMap[this]!);
}
