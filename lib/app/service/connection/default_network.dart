import 'package:app/app/service/service.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:uuid/uuid.dart';

final Connection defaultPresetConnection = (() {
  final connectionId = const Uuid().v4();
  const networkName = 'Everscale';
  const defaultWorkchainId = 0;

  return Connection(
    id: connectionId,
    networkName: networkName,
    defaultWorkchainId: defaultWorkchainId,
    isPreset: true,
    canBeEdited: false,
    workchains: [
      ConnectionWorkchain(
        id: defaultWorkchainId,
        parentConnectionId: connectionId,
        networkName: networkName,
        networkType: NetworkType.ever,
        networkGroup: 'mainnet',
        transportType: WorkchainTransportType.proto,
        manifestUrl:
            'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json',
        icons: TransportIcons(
          nativeToken: Assets.images.tokenDefaultIcon.path,
          network: Assets.images.networkDefault.path,
          vector: Assets.images.networkVectorDefault.path,
        ),
        availableWalletTypes: const [
          WalletType.everWallet(),
          WalletType.multisig(MultisigType.multisig2_1),
        ],
        walletDefaultAccountNames: WalletDefaultAccountNames(
          multisig: {
            MultisigType.safeMultisigWallet: 'SafeMultisig24h',
            MultisigType.safeMultisigWallet24h: 'SafeMultisig24h',
            MultisigType.setcodeMultisigWallet: 'SetcodeMultisig',
            MultisigType.setcodeMultisigWallet24h: 'SetcodeMultisig24h',
            MultisigType.bridgeMultisigWallet: 'BridgeMultisig',
            MultisigType.surfWallet: 'Surf wallet',
            MultisigType.multisig2: 'Legacy Multisig',
            MultisigType.multisig2_1: 'Multisig',
          },
          walletV3: 'Wallet V3',
          highloadWalletV2: 'Highload Wallet V2',
          walletV3R1: 'Wallet V3R1',
          walletV3R2: 'Wallet V3R2',
          walletV4R1: 'Wallet V4R1',
          walletV4R2: 'Wallet V4R2',
          walletV5R1: 'Wallet V5R1',
        ),
        defaultWalletType: const WalletType.everWallet(),
        nativeTokenAddress: const Address(address: ''),
        seedPhraseWordsCount: [12, 24],
        genericTokenType: GenericTokenType.tip3,
        accountExplorerLinkType: AccountExplorerLinkType.accounts,
        transactionExplorerLinkType: TransactionExplorerLinkType.transactions,
        endpoints: ['https://jrpc.everwallet.net'],
        blockExplorerUrl: 'https://everscan.io',
        isLocal: true,
        defaultNativeCurrencyDecimal: 9,
      ),
    ],
  );
})();
