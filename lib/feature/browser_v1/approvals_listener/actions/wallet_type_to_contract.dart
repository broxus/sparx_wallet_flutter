import 'package:app/data/models/models.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

extension WalletTypeToContract on WalletType {
  /// Extension that allows convert [WalletType] to [WalletContractType] for
  /// browser usage.
  WalletContractType toContractType() => switch (this) {
    WalletTypeMultisig(:final data) => switch (data) {
      MultisigType.safeMultisigWallet => WalletContractType.safeMultisigWallet,
      MultisigType.safeMultisigWallet24h =>
        WalletContractType.safeMultisigWallet24h,
      MultisigType.setcodeMultisigWallet =>
        WalletContractType.setcodeMultisigWallet,
      MultisigType.setcodeMultisigWallet24h =>
        WalletContractType.setcodeMultisigWallet24h,
      MultisigType.bridgeMultisigWallet =>
        WalletContractType.bridgeMultisigWallet,
      MultisigType.surfWallet => WalletContractType.surfWallet,
      MultisigType.multisig2 => WalletContractType.multisig2,
      MultisigType.multisig2_1 => WalletContractType.multisig2_1,
    },
    WalletTypeEverWallet() => WalletContractType.everWallet,
    WalletTypeWalletV3() => WalletContractType.walletV3,
    WalletTypeHighloadWalletV2() => WalletContractType.highloadWalletV2,
    WalletTypeWalletV3R1() => WalletContractType.walletV3R1,
    WalletTypeWalletV3R2() => WalletContractType.walletV3R2,
    WalletTypeWalletV4R1() => WalletContractType.walletV4R1,
    WalletTypeWalletV4R2() => WalletContractType.walletV4R2,
    WalletTypeWalletV5R1() => WalletContractType.walletV5R1,
  };
}
