import 'package:app/app/service/connection/connection.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:dio/dio.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class CommonTransportStrategy extends AppTransportStrategy {
  CommonTransportStrategy({
    required this.dio,
    required this.transport,
    required this.connection,
    required this.availableWalletTypes,
    required this.walletDefaultAccountNames,
    required this.defaultWalletType,
    required this.nativeTokenTickerOption,
    required this.manifestOption,
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
    required ConnectionData connection,
    required ConnectionTransportData transportData,
  }) {
    return CommonTransportStrategy(
      dio: dio,
      transport: transport,
      connection: connection,
      icons: transportData.icons,
      availableWalletTypes: transportData.availableWalletTypes,
      walletDefaultAccountNames: transportData.walletDefaultAccountNames,
      defaultWalletType: transportData.defaultWalletType,
      nativeTokenTickerOption: transportData.nativeTokenTickerOption,
      manifestOption: transportData.manifestOption,
      nativeTokenAddress: transportData.nativeTokenAddress,
      networkName: transportData.networkName,
      networkType: transportData.networkType,
      seedPhraseWordsCount: transportData.seedPhraseWordsCount,
      defaultNativeCurrencyDecimal:
          transportData.defaultNativeCurrencyDecimal ??
          connection.nativeTokenDecimals,
      genericTokenType: transportData.genericTokenType,
      accountExplorerLinkType: transportData.accountExplorerLinkType,
      transactionExplorerLinkType: transportData.transactionExplorerLinkType,
      stakeInformation: transportData.stakeInformation,
      tokenApiBaseUrl: transportData.tokenApiBaseUrl,
      currencyApiBaseUrl: transportData.currencyApiBaseUrl,
      gaslessApiBaseUrl: transportData.gaslessApiBaseUrl,
      nftInformation: transportData.nftInformation,
      pollingConfig: transportData.pollingConfig ?? PollingConfig.defaultConfig,
    );
  }

  final Dio dio;

  @override
  final Transport transport;

  final ConnectionData connection;

  final TransportIcons? icons;

  @override
  final List<WalletType> availableWalletTypes;

  final WalletDefaultAccountNames walletDefaultAccountNames;

  @override
  final WalletType defaultWalletType;

  @override
  String get manifestUrl => switch (manifestOption) {
    TransportManifestOptionFromConnection() => connection.manifestUrl,
  };

  @override
  String get nativeTokenIcon =>
      icons?.nativeToken ?? Assets.images.nativeTokenDefault.path;

  final TransportNativeTokenTickerOption nativeTokenTickerOption;

  final TransportManifestOption manifestOption;

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
  String get nativeTokenTicker => switch (nativeTokenTickerOption) {
    TransportNativeTokenTickerOptionFromConnection() =>
      connection.nativeTokenTicker,
    TransportNativeTokenTickerOptionByName(:final name) => name,
  };

  @override
  String accountExplorerLink(Address accountAddress) {
    if (connection.blockExplorerUrl.isEmpty) {
      return '';
    }

    return switch (accountExplorerLinkType) {
      AccountExplorerLinkType.accounts =>
        '${connection.blockExplorerUrl}/accounts/${accountAddress.address}',
      AccountExplorerLinkType.accountDetails =>
        '${connection.blockExplorerUrl}/accounts/accountDetails?id=${accountAddress.address}',
      AccountExplorerLinkType.packAddress =>
        '${connection.blockExplorerUrl}/${packAddress(accountAddress)}',
    };
  }

  @override
  String defaultAccountName(WalletType walletType) {
    return switch (walletType) {
          WalletTypeMultisig(:final data) =>
            walletDefaultAccountNames.multisig?[data] ?? '',
          WalletTypeWalletV3() => walletDefaultAccountNames.walletV3,
          WalletTypeHighloadWalletV2() =>
            walletDefaultAccountNames.highloadWalletV2,
          WalletTypeEverWallet() => walletDefaultAccountNames.everWallet,
          WalletTypeWalletV3R1() => walletDefaultAccountNames.walletV3R1,
          WalletTypeWalletV3R2() => walletDefaultAccountNames.walletV3R2,
          WalletTypeWalletV4R1() => walletDefaultAccountNames.walletV4R1,
          WalletTypeWalletV4R2() => walletDefaultAccountNames.walletV4R2,
          WalletTypeWalletV5R1() => walletDefaultAccountNames.walletV5R1,
        } ??
        '';
  }

  @override
  String transactionExplorerLink(String transactionHash) {
    if (connection.blockExplorerUrl.isEmpty) {
      return '';
    }

    return switch (transactionExplorerLinkType) {
      TransactionExplorerLinkType.transaction =>
        '${connection.blockExplorerUrl}/transaction/$transactionHash',
      TransactionExplorerLinkType.transactions =>
        '${connection.blockExplorerUrl}/transactions/$transactionHash',
      TransactionExplorerLinkType.transactionDetails =>
        '${connection.blockExplorerUrl}/transactions/transactionDetails?id=$transactionHash',
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
