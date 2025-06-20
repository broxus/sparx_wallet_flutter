import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'nft_prepare_transfer_data.freezed.dart';

@freezed
class NftPrepareTransferData with _$NftPrepareTransferData {
  const factory NftPrepareTransferData({
    required KeyAccount account,
    required PublicKey custodian,
    required NftItem item,
    required NftCollection collection,
    required List<PublicKey>? localCustodians,
  }) = _NftPrepareTransferData;
}
