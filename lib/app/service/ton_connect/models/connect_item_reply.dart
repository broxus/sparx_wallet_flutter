import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'connect_item_reply.freezed.dart';
part 'connect_item_reply.g.dart';

@Freezed(unionKey: 'name')
sealed class ConnectItemReply with _$ConnectItemReply {
  @FreezedUnionValue('ton_addr')
  const factory ConnectItemReply.tonAddress({
    required Address address,
    required TonNetwork network,
    required PublicKey publicKey,
    required String walletStateInit,
  }) = TonAddressItemReply;

  @FreezedUnionValue('ton_proof')
  const factory ConnectItemReply.tonProofSuccess({
    required TonProof proof,
  }) = TonProofItemReplySuccess;

  factory ConnectItemReply.fromJson(Map<String, dynamic> json) =>
      _$ConnectItemReplyFromJson(json);
}
