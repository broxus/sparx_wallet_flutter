import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show Address;

part 'connect_item_reply.freezed.dart';
part 'connect_item_reply.g.dart';

@Freezed(unionKey: 'name')
sealed class ConnectItemReply with _$ConnectItemReply {
  @FreezedUnionValue('ton_addr')
  const factory ConnectItemReply.tonAddress({
    required Address address,
    required String network,
    required String publicKey,
    required String walletStateInit,
  }) = _TonAddress;

  @FreezedUnionValue('ton_proof')
  const factory ConnectItemReply.tonProofSuccess() = _TonProofSuccess;

  factory ConnectItemReply.fromJson(Map<String, dynamic> json) =>
      _$ConnectItemReplyFromJson(json);
}
