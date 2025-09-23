// import 'package:app/app/service/connection/connection.dart';
// import 'package:app/core/sentry.dart';
// import 'package:app/utils/utils.dart';
// import 'package:nekoton_repository/nekoton_repository.dart';
//
// ConnectionTransportData? mapToTransport(
//   Map<String, dynamic> transport,
// ) {
//   final networkGroup = castToString(transport['networkGroup']);
//   final defaultWalletType = _mapToWalletType(
//     castJsonMap(transport['defaultWalletType']),
//   );
//
//   final genericTokenType = GenericTokenType.values.byNameOrNull(
//     castToString(transport['genericTokenType']),
//   );
//
//   final accountExplorerLinkType = AccountExplorerLinkType.values.byNameOrNull(
//     castToString(transport['accountExplorerLinkType']),
//   );
//
//   final networkType = castToString(transport['networkType']);
//
//   if (networkGroup == null ||
//       defaultWalletType == null ||
//       genericTokenType == null ||
//       accountExplorerLinkType == null ||
//       networkType == null) {
//     return null;
//   }
//
//   return ConnectionTransportData(
//     defaultActiveAssets: _mapToDefaultActiveAssets(
//       transport['defaultActiveAssets'],
//     ),
//     icons: _mapToTransportIcons(
//       castJsonMap(transport['icons']),
//     ),
//     availableWalletTypes: _mapToAvailableWalletTypes(
//       castJsonList<Map<String, dynamic>>(transport['availableWalletTypes']),
//     ),
//     walletDefaultAccountNames: _mapRoWalletDefaultAccountNames(
//       castJsonMap(transport['walletDefaultAccountNames']),
//     ),
//     defaultWalletType: defaultWalletType,
//     nativeTokenTickerOption: _mapToNativeTokenTickerOption(
//       castJsonMap(transport['nativeTokenTickerOption']),
//     ),
//     manifestOption: _mapToManifestOption(
//       castJsonMap(transport['manifestOption']),
//     ),
//     nativeTokenAddress: Address(
//       address: castTo<String?>(transport['nativeTokenAddress']) ?? '',
//     ),
//     networkName: castToString(transport['networkName']) ?? 'Unknown',
//     networkType: NetworkType.fromJson(transport['networkType'] as String),
//     seedPhraseWordsCount: _mapToSeedPhraseWordsCount(
//       castTo<List<dynamic>>(transport['seedPhraseWordsCount']),
//     ),
//     defaultNativeCurrencyDecimal:
//         parseToInt(transport['defaultNativeCurrencyDecimal']),
//     genericTokenType: genericTokenType,
//     accountExplorerLinkType: accountExplorerLinkType,
//     transactionExplorerLinkType:
//         TransactionExplorerLinkType.values.byNameOrNull(
//       castToString(transport['transactionExplorerLinkType']),
//     ),
//     stakeInformation: _mapToStakingInformation(
//       castJsonMap(transport['stakeInformation']),
//     ),
//     tokenApiBaseUrl: castToString(transport['tokenApiBaseUrl']),
//     currencyApiBaseUrl: castToString(transport['currencyApiBaseUrl']),
//     nftInformation: (transport['nftInformation'] as Map<String, dynamic>?)
//         ?.let(NftInformation.fromJson),
//     pollingConfig: _mapToPollingConfig(
//       castJsonMap(transport['pollingConfig']),
//     ),
//   );
// }
//
// TransportIcons _mapToTransportIcons(Map<String, dynamic> json) {
//   return TransportIcons(
//     nativeToken: castToString(json['nativeToken']),
//     network: castToString(json['network']),
//     vector: castToString(json['vector']),
//   );
// }
//
// List<WalletType> _mapToAvailableWalletTypes(List<Map<String, dynamic>> list) {
//   final result = <WalletType>[];
//
//   for (final data in list) {
//     final value = _mapToWalletType(data);
//
//     if (value == null) {
//       continue;
//     }
//
//     result.add(value);
//   }
//
//   return result;
// }
//
// WalletType? _mapToWalletType(Map<String, dynamic> data) {
//   try {
//     switch (data['type'] as String) {
//       case 'multisig':
//         return WalletType.multisig(
//           MultisigType.values.byName(
//             data['value'] as String,
//           ),
//         );
//       case 'walletV3':
//         return const WalletType.walletV3();
//       case 'highloadWalletV2':
//         return const WalletType.highloadWalletV2();
//       case 'everWallet':
//         return const WalletType.everWallet();
//       case 'walletV3R1':
//         return const WalletType.walletV3R1();
//       case 'walletV3R2':
//         return const WalletType.walletV3R2();
//       case 'walletV4R1':
//         return const WalletType.walletV4R1();
//       case 'walletV4R2':
//         return const WalletType.walletV4R2();
//       case 'walletV5R1':
//         return const WalletType.walletV5R1();
//     }
//   } catch (e, s) {
//     SentryWorker.instance.captureException(e, stackTrace: s);
//   }
//   return null;
// }
//
// TransportNativeTokenTickerOption _mapToNativeTokenTickerOption(
//   Map<String, dynamic> data,
// ) {
//   switch (data['type']) {
//     case 'fromConnection':
//       return const TransportNativeTokenTickerOption.fromConnection();
//     case 'byName':
//       return TransportNativeTokenTickerOption.byName(data['name'] as String);
//   }
//
//   throw Exception('Unknown TransportNativeTokenTickerOption');
// }
//
// TransportManifestOption _mapToManifestOption(
//   Map<String, dynamic> data,
// ) {
//   switch (data['type']) {
//     case 'fromConnection':
//       return const TransportManifestOption.fromConnection();
//   }
//
//   throw Exception('Unknown TransportNativeTokenTickerOption');
// }
//
// List<int> _mapToSeedPhraseWordsCount(List<dynamic>? list) {
//   if (list == null) {
//     return [];
//   }
//
//   final result = <int>[];
//
//   for (final data in list) {
//     final number = parseToInt(data);
//     if (number != null) {
//       result.add(number);
//     }
//   }
//
//   return result;
// }
//
// StakingInformation? _mapToStakingInformation(Map<String, dynamic>? info) {
//   if (info == null) {
//     return null;
//   }
//
//   final stakingAPYLink = parseUriOrNull(castToString(info['stakingAPYLink']));
//   final stakingRootContractAddress = _parseAddress(
//     castToString(info['stakingRootContractAddress']),
//   );
//   final stakingValutAddress = _parseAddress(
//     castToString(info['stakingValutAddress']),
//   );
//   final stakeDepositAttachedFee = parseBigIntOrNull(
//     castToString(info['stakeDepositAttachedFee']),
//   );
//   final stakeRemovePendingWithdrawAttachedFee = parseBigIntOrNull(
//     castToString(info['stakeRemovePendingWithdrawAttachedFee']),
//   );
//
//   final stakeWithdrawAttachedFee = parseBigIntOrNull(
//     castToString(info['stakeWithdrawAttachedFee']),
//   );
//
//   if (stakingAPYLink == null ||
//       stakingRootContractAddress == null ||
//       stakingValutAddress == null ||
//       stakeDepositAttachedFee == null ||
//       stakeRemovePendingWithdrawAttachedFee == null ||
//       stakeWithdrawAttachedFee == null) {
//     return null;
//   }
//
//   return StakingInformation(
//     stakingAPYLink: stakingAPYLink,
//     stakingRootContractAddress: stakingRootContractAddress,
//     stakingValutAddress: stakingValutAddress,
//     stakeDepositAttachedFee: stakeDepositAttachedFee,
//     stakeRemovePendingWithdrawAttachedFee:
//         stakeRemovePendingWithdrawAttachedFee,
//     stakeWithdrawAttachedFee: stakeWithdrawAttachedFee,
//   );
// }
//
// WalletDefaultAccountNames _mapRoWalletDefaultAccountNames(
//   Map<String, dynamic> json,
// ) {
//   final multisig = castJsonMap(json['multisig']);
//   final multisigKeys = multisig.keys;
//
//   final multisigData = <MultisigType, String>{
//     MultisigType.safeMultisigWallet: 'SafeMultisig24h',
//     MultisigType.safeMultisigWallet24h: 'SafeMultisig24h',
//     MultisigType.setcodeMultisigWallet: 'SetcodeMultisig',
//     MultisigType.setcodeMultisigWallet24h: 'SetcodeMultisig24h',
//     MultisigType.bridgeMultisigWallet: 'BridgeMultisig',
//     MultisigType.surfWallet: 'Surf wallet',
//     MultisigType.multisig2: 'Legacy Multisig',
//     MultisigType.multisig2_1: 'Multisig',
//   };
//
//   for (final key in multisigKeys) {
//     final value = castToString(multisig[key]);
//
//     if (value == null) {
//       continue;
//     }
//
//     multisigData[MultisigType.values.byName(key)] = value;
//   }
//
//   return WalletDefaultAccountNames(
//     multisig: multisigData,
//     walletV3: castToString(json['walletV3']) ?? 'WalletV3',
//     highloadWalletV2:
//         castToString(json['highloadWalletV2']) ?? 'Highload WalletV2',
//     everWallet: castToString(json['everWallet']) ?? 'Ever Wallet',
//     walletV3R1: castTo<String?>(json['walletV3R1']) ?? 'WalletV3R1',
//     walletV3R2: castTo<String?>(json['walletV3R2']) ?? 'WalletV3R2',
//     walletV4R1: castToString(json['walletV4R1']) ?? 'WalletV4R1',
//     walletV4R2: castToString(json['walletV4R2']) ?? 'WalletV4R2',
//     walletV5R1: castToString(json['walletV5R1']) ?? 'WalletV5R1',
//   );
// }
//
// List<DefaultActiveAsset> _mapToDefaultActiveAssets(dynamic json) {
//   try {
//     final list = castJsonList<Map<String, dynamic>>(json);
//
//     final result = <DefaultActiveAsset>[];
//
//     for (final item in list) {
//       final address = _parseAddress(castToString(item['address']));
//
//       if (address == null) {
//         continue;
//       }
//
//       result.add(
//         DefaultActiveAsset(
//           address: address,
//         ),
//       );
//     }
//
//     return result;
//   } catch (_) {
//     return [];
//   }
// }
//
// PollingConfig? _mapToPollingConfig(Map<String, dynamic>? json) {
//   if (json == null) return null;
//
//   final ton = parseToInt(json['tonWalletRefreshInterval']);
//   final token = parseToInt(json['tokenWalletRefreshInterval']);
//   final intensive = parseToInt(json['intensivePollingInterval']);
//
//   return PollingConfig(
//     tonWalletRefreshInterval: ton?.let((it) => Duration(seconds: it)) ??
//         PollingConfig.defaultConfig.tonWalletRefreshInterval,
//     tokenWalletRefreshInterval: token?.let((it) => Duration(seconds: it)) ??
//         PollingConfig.defaultConfig.tokenWalletRefreshInterval,
//     intensivePollingInterval: intensive?.let((it) => Duration(seconds: it)) ??
//         PollingConfig.defaultConfig.intensivePollingInterval,
//   );
// }
//
// Address? _parseAddress(String? address) {
//   return address == null ? null : Address(address: address);
// }
