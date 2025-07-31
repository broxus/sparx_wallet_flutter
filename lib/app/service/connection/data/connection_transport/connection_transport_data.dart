import 'package:app/app/service/connection/connection.dart';
import 'package:app/generated/generated.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class ConnectionTransportData {
  ConnectionTransportData({
    required this.icons,
    required this.availableWalletTypes,
    required this.defaultWalletType,
    required this.nativeTokenTickerOption,
    required this.manifestOption,
    required this.nativeTokenAddress,
    required this.seedPhraseWordsCount,
    required this.walletDefaultAccountNames,
    required this.networkName,
    required this.genericTokenType,
    required this.accountExplorerLinkType,
    required this.networkType,
    this.transactionExplorerLinkType,
    this.baseCurrencyUrl,
    this.stakeInformation,
    this.tokenApiBaseUrl,
    this.currencyApiBaseUrl,
    this.defaultNativeCurrencyDecimal,
    this.nftInformation,
    this.pollingConfig,
    List<DefaultActiveAsset>? defaultActiveAssets,
  }) : defaultActiveAssets = defaultActiveAssets ?? [];

  factory ConnectionTransportData.custom({
    required NetworkType networkType,
    required String networkName,
  }) =>
      ConnectionTransportData(
        networkType: networkType,
        networkName: networkName,
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
          everWallet: 'Ever Wallet',
          walletV3R1: 'Wallet V3R1',
          walletV3R2: 'Wallet V3R2',
          walletV4R1: 'Wallet V4R1',
          walletV4R2: 'Wallet V4R2',
          walletV5R1: 'Wallet V5R1',
        ),
        defaultWalletType: const WalletType.everWallet(),
        nativeTokenTickerOption:
            const TransportNativeTokenTickerOption.fromConnection(),
        manifestOption: const TransportManifestOption.fromConnection(),
        nativeTokenAddress: const Address(address: ''),
        seedPhraseWordsCount: [12, 24],
        genericTokenType: GenericTokenType.tip3,
        accountExplorerLinkType: AccountExplorerLinkType.accounts,
        transactionExplorerLinkType: TransactionExplorerLinkType.transactions,
      );

  final List<DefaultActiveAsset> defaultActiveAssets;
  final TransportIcons icons;
  final List<WalletType> availableWalletTypes;
  final WalletDefaultAccountNames walletDefaultAccountNames;
  final WalletType defaultWalletType;
  final String? baseCurrencyUrl;
  final TransportNativeTokenTickerOption nativeTokenTickerOption;
  final TransportManifestOption manifestOption;
  final Address nativeTokenAddress;
  final String networkName;
  final NetworkType networkType;
  final List<int> seedPhraseWordsCount;
  final GenericTokenType genericTokenType;
  final AccountExplorerLinkType accountExplorerLinkType;
  final TransactionExplorerLinkType? transactionExplorerLinkType;
  final StakingInformation? stakeInformation;
  final String? tokenApiBaseUrl;
  final String? currencyApiBaseUrl;
  final int? defaultNativeCurrencyDecimal;
  final NftInformation? nftInformation;
  final PollingConfig? pollingConfig;
}

class WalletDefaultAccountNames {
  WalletDefaultAccountNames({
    this.multisig,
    this.walletV3,
    this.highloadWalletV2,
    this.everWallet,
    this.walletV3R1,
    this.walletV3R2,
    this.walletV4R1,
    this.walletV4R2,
    this.walletV5R1,
  });

  final Map<MultisigType, String>? multisig;
  final String? walletV3;
  final String? highloadWalletV2;
  final String? everWallet;
  final String? walletV3R1;
  final String? walletV3R2;
  final String? walletV4R1;
  final String? walletV4R2;
  final String? walletV5R1;
}
