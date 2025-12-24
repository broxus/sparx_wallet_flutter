import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:dio/dio.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class CommonTransportStrategy extends AppTransportStrategy {
  CommonTransportStrategy({
    required this.dio,
    required this.transport,
    required this.workchain,
    required this.availableWalletTypes,
    required this.walletDefaultAccountNames,
    required this.defaultWalletType,
    required this.nativeTokenAddress,
    required this.networkName,
    required this.seedPhraseWordsCount,
    required this.defaultNativeCurrencyDecimal,
    required this.genericTokenType,
    required this.accountExplorerLinkType,
    required this.networkType,
    required this.pollingConfig,
    this.icons,
    this.transactionExplorerLinkType,
    this.stakeInformation,
    this.tokenApiBaseUrl,
    this.currencyApiBaseUrl,
    this.gaslessApiBaseUrl,
    this.nftInformation,
  });

  factory CommonTransportStrategy.fromData({
    required Dio dio,
    required Transport transport,
    required ConnectionWorkchain workchain,
  }) {
    return CommonTransportStrategy(
      dio: dio,
      transport: transport,
      workchain: workchain,
      icons: workchain.icons,
      availableWalletTypes: workchain.availableWalletTypes,
      walletDefaultAccountNames: workchain.walletDefaultAccountNames,
      defaultWalletType: workchain.defaultWalletType,
      nativeTokenAddress: workchain.nativeTokenAddress,
      networkName: workchain.networkName,
      networkType: workchain.networkType,
      seedPhraseWordsCount: workchain.seedPhraseWordsCount,
      defaultNativeCurrencyDecimal:
          workchain.defaultNativeCurrencyDecimal ??
          workchain.nativeTokenDecimals,
      genericTokenType: workchain.genericTokenType,
      accountExplorerLinkType: workchain.accountExplorerLinkType,
      transactionExplorerLinkType: workchain.transactionExplorerLinkType,
      stakeInformation: workchain.stakeInformation,
      tokenApiBaseUrl: workchain.tokenApiBaseUrl,
      currencyApiBaseUrl: workchain.currencyApiBaseUrl,
      gaslessApiBaseUrl: workchain.gaslessApiBaseUrl,
      nftInformation: workchain.nftInformation,
      pollingConfig: workchain.pollingConfig ?? PollingConfig.defaultConfig,
    );
  }

  final Dio dio;

  @override
  final Transport transport;

  final ConnectionWorkchain workchain;

  final TransportIcons? icons;

  @override
  final List<WalletType> availableWalletTypes;

  final WalletDefaultAccountNames walletDefaultAccountNames;

  @override
  final WalletType defaultWalletType;

  @override
  String get manifestUrl => workchain.manifestUrl;

  @override
  String get nativeTokenIcon =>
      icons?.nativeToken ?? Assets.images.nativeTokenDefault.path;

  @override
  final Address nativeTokenAddress;

  @override
  final String networkName;

  final NetworkType networkType;

  @override
  final List<int> seedPhraseWordsCount;

  @override
  int defaultNativeCurrencyDecimal;

  final GenericTokenType genericTokenType;

  final AccountExplorerLinkType accountExplorerLinkType;

  final TransactionExplorerLinkType? transactionExplorerLinkType;

  final NftInformation? nftInformation;

  @override
  final PollingConfig pollingConfig;

  @override
  StakingInformation? stakeInformation;

  @override
  String? tokenApiBaseUrl;

  @override
  String? currencyApiBaseUrl;

  String? gaslessApiBaseUrl;

  @override
  String? get nftApiBaseUrl => nftInformation?.apiBaseUrl;

  late final _subscriber = switch (genericTokenType) {
    GenericTokenType.tip3 => Tip3TokenWalletSubscriber(inject()),
    GenericTokenType.jetton => JettonTokenWalletSubscriber(inject()),
  };

  NetworkGroup get networkGroup => transport.group;

  @override
  String get nativeTokenTicker => workchain.nativeTokenTicker.name;

  @override
  String accountExplorerLink(Address accountAddress) {
    if (workchain.blockExplorerUrl.isEmpty) {
      return '';
    }

    return switch (accountExplorerLinkType) {
      AccountExplorerLinkType.accounts =>
        '${workchain.blockExplorerUrl}/accounts/${accountAddress.address}',
      AccountExplorerLinkType.accountDetails =>
        '${workchain.blockExplorerUrl}/accounts/accountDetails?id=${accountAddress.address}',
      AccountExplorerLinkType.packAddress =>
        '${workchain.blockExplorerUrl}/${packAddress(accountAddress)}',
    };
  }

  @override
  String defaultAccountName(WalletType walletType) {
    return switch (walletType) {
      WalletTypeMultisig(:final data) =>
        walletDefaultAccountNames.multisig[data] ?? '',
      WalletTypeWalletV3() => walletDefaultAccountNames.walletV3,
      WalletTypeHighloadWalletV2() =>
        walletDefaultAccountNames.highloadWalletV2,
      WalletTypeEverWallet() => walletDefaultAccountNames.everWallet,
      WalletTypeWalletV3R1() => walletDefaultAccountNames.walletV3R1,
      WalletTypeWalletV3R2() => walletDefaultAccountNames.walletV3R2,
      WalletTypeWalletV4R1() => walletDefaultAccountNames.walletV4R1,
      WalletTypeWalletV4R2() => walletDefaultAccountNames.walletV4R2,
      WalletTypeWalletV5R1() => walletDefaultAccountNames.walletV5R1,
    };
  }

  @override
  String transactionExplorerLink(String transactionHash) {
    if (workchain.blockExplorerUrl.isEmpty) {
      return '';
    }

    return switch (transactionExplorerLinkType) {
      TransactionExplorerLinkType.transaction =>
        '${workchain.blockExplorerUrl}/transaction/$transactionHash',
      TransactionExplorerLinkType.transactions =>
        '${workchain.blockExplorerUrl}/transactions/$transactionHash',
      TransactionExplorerLinkType.transactionDetails =>
        '${workchain.blockExplorerUrl}/transactions/transactionDetails?id=$transactionHash',
      _ => '',
    };
  }

  @override
  Future<GenericTokenWallet> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
  }) => _subscriber.subscribeToken(
    owner: owner,
    rootTokenContract: rootTokenContract,
    transport: transport,
  );

  @override
  Future<Map<String, dynamic>?> fetchJson(String url) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(url);
      return response.data;
    } catch (_) {
      return null;
    }
  }
}
