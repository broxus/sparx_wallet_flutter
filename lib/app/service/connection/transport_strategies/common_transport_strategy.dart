import 'package:app/app/service/connection/data/account_explorer/account_explorer_link_type.dart';
import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/nft_information/nft_information.dart';
import 'package:app/app/service/connection/data/transaction_explorer/transaction_explorer_link_type.dart';
import 'package:app/app/service/connection/data/transport_icons.dart';
import 'package:app/app/service/connection/data/wallet_default_account_names.dart';
import 'package:app/app/service/connection/generic_token_subscriber.dart';
import 'package:app/app/service/connection/group.dart';
import 'package:app/app/service/connection/transport_strategies/app_transport_strategy.dart';
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
    required Connection connection,
  }) {
    final workchain = connection.defaultWorkchain;

    return CommonTransportStrategy(
      dio: dio,
      transport: transport,
      connection: connection,
      icons: workchain.icons,
      availableWalletTypes: workchain.availableWalletTypes,
      walletDefaultAccountNames: workchain.walletDefaultAccountNames,
      defaultWalletType: workchain.defaultWalletType,
      nativeTokenAddress: workchain.nativeTokenAddress,
      networkName: workchain.networkName,
      networkType: workchain.networkType,
      seedPhraseWordsCount: workchain.seedPhraseWordsCount,
      defaultNativeCurrencyDecimal: workchain.defaultNativeCurrencyDecimal ??
          workchain.nativeTokenDecimals,
      genericTokenType: workchain.genericTokenType,
      accountExplorerLinkType: workchain.accountExplorerLinkType,
      transactionExplorerLinkType: workchain.transactionExplorerLinkType,
      stakeInformation: workchain.stakeInformation,
      tokenApiBaseUrl: workchain.tokenApiBaseUrl,
      currencyApiBaseUrl: workchain.currencyApiBaseUrl,
      nftInformation: workchain.nftInformation,
      pollingConfig: workchain.pollingConfig ?? PollingConfig.defaultConfig,
      pollingConfig: transportData.pollingConfig ?? PollingConfig.defaultConfig,
    );
  }

  final Dio dio;

  @override
  final Transport transport;

  final Connection connection;

  final TransportIcons? icons;

  @override
  final List<WalletType> availableWalletTypes;

  final WalletDefaultAccountNames walletDefaultAccountNames;

  @override
  final WalletType defaultWalletType;

  @override
  String get manifestUrl => connection.defaultWorkchain.manifestUrl;

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

  late final _subscriber = switch (genericTokenType) {
    GenericTokenType.tip3 => Tip3TokenWalletSubscriber(inject()),
    GenericTokenType.jetton => JettonTokenWalletSubscriber(inject()),
  };

  NetworkGroup get networkGroup => transport.group;

  @override
  String get nativeTokenTicker =>
      connection.defaultWorkchain.nativeTokenTicker.name;

  @override
  String accountExplorerLink(Address accountAddress) {
    if (connection.defaultWorkchain.blockExplorerUrl.isEmpty) {
      return '';
    }

    return switch (accountExplorerLinkType) {
      AccountExplorerLinkType.accounts =>
        '${connection.defaultWorkchain.blockExplorerUrl}/accounts/${accountAddress.address}',
      AccountExplorerLinkType.accountDetails =>
        '${connection.defaultWorkchain.blockExplorerUrl}/accounts/accountDetails?id=${accountAddress.address}',
      AccountExplorerLinkType.packAddress =>
        '${connection.defaultWorkchain.blockExplorerUrl}/${packAddress(accountAddress)}',
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
    if (connection.defaultWorkchain.blockExplorerUrl.isEmpty) {
      return '';
    }

    return switch (transactionExplorerLinkType) {
      TransactionExplorerLinkType.transaction =>
        '${connection.defaultWorkchain.blockExplorerUrl}/transaction/$transactionHash',
      TransactionExplorerLinkType.transactions =>
        '${connection.defaultWorkchain.blockExplorerUrl}/transactions/$transactionHash',
      TransactionExplorerLinkType.transactionDetails =>
        '${connection.defaultWorkchain.blockExplorerUrl}/transactions/transactionDetails?id=$transactionHash',
      _ => '',
    };
  }

  @override
  Future<GenericTokenWallet> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
  }) =>
      _subscriber.subscribeToken(
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
