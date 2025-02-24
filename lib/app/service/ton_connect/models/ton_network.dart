import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum TonNetwork {
  @JsonValue('-239')
  mainnet,
  @JsonValue('-3')
  testnet;
}
