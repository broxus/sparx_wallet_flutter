import 'package:app/app/service/connection/connection.dart';
import 'package:app/utils/utils.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

Map<NetworkGroup, ConnectionTransportData>? mapToTransports(
  List<Map<String, dynamic>> list,
) {
  final result = <NetworkGroup, ConnectionTransportData>{};

  for (final transport in list) {
    result[transport['networkGroup'] as String] = ConnectionTransportData(
      defaultActiveAssets: _mapToDefaultActiveAssets(
        transport['defaultActiveAssets'],
      ),
      icons: _mapToTransportIcons(
        transport['icons'] as Map<String, dynamic>,
      ),
      availableWalletTypes: _mapToAvailableWalletTypes(
        castJsonList<Map<String, dynamic>>(transport['availableWalletTypes']),
      ),
      walletDefaultAccountNames: _mapRoWalletDefaultAccountNames(
        transport['walletDefaultAccountNames'] as Map<String, dynamic>,
      ),
      defaultWalletType: _mapToWalletType(
        transport['defaultWalletType'] as Map<String, dynamic>,
      ),
      nativeTokenTickerOption: _mapToNativeTokenTickerOption(
        transport['nativeTokenTickerOption'] as Map<String, dynamic>,
      ),
      manifestOption: _mapToManifestOption(
        transport['manifestOption'] as Map<String, dynamic>,
      ),
      nativeTokenAddress: Address(
        address: (transport['nativeTokenAddress'] as String?) ?? '',
      ),
      networkName: transport['networkName'] as String,
      networkType: NetworkType.fromJson(transport['networkType'] as String),
      seedPhraseWordsCount: _mapToSeedPhraseWordsCount(
        transport['seedPhraseWordsCount'] as List<dynamic>,
      ),
      defaultNativeCurrencyDecimal:
          parseToInt(transport['defaultNativeCurrencyDecimal']),
      genericTokenType: GenericTokenType.values.byName(
        transport['genericTokenType'] as String,
      ),
      accountExplorerLinkType: AccountExplorerLinkType.values.byName(
        transport['accountExplorerLinkType'] as String,
      ),
      transactionExplorerLinkType: TransactionExplorerLinkType.values.byName(
        transport['transactionExplorerLinkType'] as String,
      ),
      baseCurrencyUrl: transport['baseCurrencyUrl'] as String?,
      stakeInformation: _mapToStakingInformation(
        transport['stakeInformation'] as Map<String, dynamic>?,
      ),
      tokenApiBaseUrl: transport['tokenApiBaseUrl'] as String?,
      currencyApiBaseUrl: transport['currencyApiBaseUrl'] as String?,
      nftInformation: (transport['nftInformation'] as Map<String, dynamic>?)
          ?.let(NftInformation.fromJson),
      pollingConfig: _mapToPollingConfig(
        transport['pollingConfig'] as Map<String, dynamic>?,
      ),
    );
  }

  return result;
}

TransportIcons _mapToTransportIcons(Map<String, dynamic> json) {
  return TransportIcons(
    nativeToken: json['nativeToken'] as String?,
    network: json['network'] as String?,
    vector: json['vector'] as String?,
  );
}

List<WalletType> _mapToAvailableWalletTypes(List<Map<String, dynamic>> list) {
  return [
    for (final data in list) _mapToWalletType(data),
  ];
}

WalletType _mapToWalletType(Map<String, dynamic> data) {
  switch (data['type'] as String) {
    case 'multisig':
      return WalletType.multisig(
        MultisigType.values.byName(data['value'] as String),
      );
    case 'walletV3':
      return const WalletType.walletV3();
    case 'highloadWalletV2':
      return const WalletType.highloadWalletV2();
    case 'everWallet':
      return const WalletType.everWallet();
    case 'walletV3R1':
      return const WalletType.walletV3R1();
    case 'walletV3R2':
      return const WalletType.walletV3R2();
    case 'walletV4R1':
      return const WalletType.walletV4R1();
    case 'walletV4R2':
      return const WalletType.walletV4R2();
    case 'walletV5R1':
      return const WalletType.walletV5R1();
  }

  throw Exception('Unknown wallet type');
}

TransportNativeTokenTickerOption _mapToNativeTokenTickerOption(
  Map<String, dynamic> data,
) {
  switch (data['type']) {
    case 'fromConnection':
      return const TransportNativeTokenTickerOption.fromConnection();
    case 'byName':
      return TransportNativeTokenTickerOption.byName(data['name'] as String);
  }

  throw Exception('Unknown TransportNativeTokenTickerOption');
}

TransportManifestOption _mapToManifestOption(
  Map<String, dynamic> data,
) {
  switch (data['type']) {
    case 'fromConnection':
      return const TransportManifestOption.fromConnection();
  }

  throw Exception('Unknown TransportNativeTokenTickerOption');
}

List<int> _mapToSeedPhraseWordsCount(List<dynamic> list) {
  final result = <int>[];

  for (final data in list) {
    final number = parseToInt(data);
    if (number != null) {
      result.add(number);
    }
  }

  return result;
}

StakingInformation? _mapToStakingInformation(Map<String, dynamic>? info) {
  if (info == null) {
    return null;
  }

  return StakingInformation(
    stakingAPYLink: Uri.parse(info['stakingAPYLink'] as String),
    stakingRootContractAddress: Address(
      address: info['stakingRootContractAddress'] as String,
    ),
    stakingVaultAddress: Address(
      // config typo workaround (stakingValutAddress -> stakingVaultAddress)
      address: (info['stakingValutAddress'] as String?) ??
          info['stakingVaultAddress'] as String,
    ),
    stakeDepositAttachedFee: BigInt.parse(
      info['stakeDepositAttachedFee'] as String,
    ),
    stakeRemovePendingWithdrawAttachedFee: BigInt.parse(
      info['stakeRemovePendingWithdrawAttachedFee'] as String,
    ),
    stakeWithdrawAttachedFee: BigInt.parse(
      info['stakeWithdrawAttachedFee'] as String,
    ),
  );
}

WalletDefaultAccountNames _mapRoWalletDefaultAccountNames(
  Map<String, dynamic> json,
) {
  final multisig = json['multisig'] as Map<String, dynamic>;
  final multisigKeys = multisig.keys;

  final multisigData = <MultisigType, String>{};

  for (final key in multisigKeys) {
    multisigData[MultisigType.values.byName(key)] = multisig[key] as String;
  }

  return WalletDefaultAccountNames(
    multisig: multisigData,
    walletV3: json['walletV3'] as String,
    highloadWalletV2: json['highloadWalletV2'] as String,
    everWallet: json['everWallet'] as String,
    walletV3R1: json['walletV3R1'] as String? ?? 'WalletV3R1',
    walletV3R2: json['walletV3R2'] as String? ?? 'WalletV3R2',
    walletV4R1: json['walletV4R1'] as String,
    walletV4R2: json['walletV4R2'] as String,
    walletV5R1: json['walletV5R1'] as String,
  );
}

List<DefaultActiveAsset> _mapToDefaultActiveAssets(dynamic json) {
  try {
    final list = castJsonList<Map<String, dynamic>>(json);

    return [
      for (final item in list)
        DefaultActiveAsset(
          address: Address(address: item['address'] as String),
        ),
    ];
  } catch (_) {
    return [];
  }
}

PollingConfig? _mapToPollingConfig(Map<String, dynamic>? json) {
  if (json == null) return null;

  final ton = parseToInt(json['tonWalletRefreshInterval']);
  final token = parseToInt(json['tokenWalletRefreshInterval']);
  final intensive = parseToInt(json['intensivePollingInterval']);

  return PollingConfig(
    tonWalletRefreshInterval: ton?.let((it) => Duration(seconds: it)) ??
        PollingConfig.defaultConfig.tonWalletRefreshInterval,
    tokenWalletRefreshInterval: token?.let((it) => Duration(seconds: it)) ??
        PollingConfig.defaultConfig.tokenWalletRefreshInterval,
    intensivePollingInterval: intensive?.let((it) => Duration(seconds: it)) ??
        PollingConfig.defaultConfig.intensivePollingInterval,
  );
}
