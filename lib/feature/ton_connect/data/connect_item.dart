import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_item.freezed.dart';
part 'connect_item.g.dart';

@Freezed(unionKey: 'name')
sealed class ConnectItem with _$ConnectItem {
  @FreezedUnionValue('ton_addr')
  const factory ConnectItem.tonAddress() = TonAddressItem;

  @FreezedUnionValue('ton_proof')
  const factory ConnectItem.tonProof({required String payload}) = TonProofItem;

  factory ConnectItem.fromJson(Map<String, dynamic> json) =>
      _$ConnectItemFromJson(json);
}
