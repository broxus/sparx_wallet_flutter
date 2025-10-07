import 'package:app/app/service/connection/data/account_explorer/account_explorer_link_type.dart';
import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/transaction_explorer/transaction_explorer_link_type.dart';
import 'package:app/app/service/connection/data/transport_icons.dart';
import 'package:app/app/service/connection/data/wallet_default_account_names.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/app/service/connection/data/work_chain/workchain_transport_type.dart';
import 'package:app/app/service/connection/generic_token_subscriber.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:uuid/uuid.dart';

final Connection defaultPresetConnection = (() {
  final connectionId = const Uuid().v4();
  const networkName = 'Everscale';

  return Connection(
    id: connectionId,
    networkName: networkName,
    defaultWorkchainId: 0,
    isPreset: true,
    canBeEdited: false,
    isUsedOnStart: true,
    workchains: [
      ConnectionWorkchain(
        id: 0,
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
        endpoints: [
          'https://jrpc.everwallet.net',
        ],
        blockExplorerUrl: 'https://everscan.io',
        isLocal: true,
        defaultNativeCurrencyDecimal: 9,
      ),
    ],
    sortingOrder: 1,
  );
})();
