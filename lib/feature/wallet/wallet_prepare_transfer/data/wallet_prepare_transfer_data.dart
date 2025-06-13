import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_transfer_asset.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class WalletPrepareTransferData {
  WalletPrepareTransferData({
    this.account,
    this.selectedCustodian,
    this.localCustodians,
    this.selectedAsset,
  });

  final KeyAccount? account;
  final PublicKey? selectedCustodian;
  final List<PublicKey>? localCustodians;
  final WalletPrepareTransferAsset? selectedAsset;

  bool get isEmpty =>
      account == null &&
      selectedCustodian == null &&
      localCustodians == null &&
      selectedAsset == null;

  WalletPrepareTransferData copyWith({
    KeyAccount? account,
    PublicKey? selectedCustodian,
    List<PublicKey>? localCustodians,
    WalletPrepareTransferAsset? selectedAsset,
  }) {
    return WalletPrepareTransferData(
      account: account ?? this.account,
      selectedCustodian: selectedCustodian ?? this.selectedCustodian,
      localCustodians: localCustodians ?? this.localCustodians,
      selectedAsset: selectedAsset ?? this.selectedAsset,
    );
  }
}
