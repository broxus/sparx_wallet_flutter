// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_work_chain_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectionWorkchainData _$ConnectionWorkchainDataFromJson(
        Map<String, dynamic> json) =>
    _ConnectionWorkchainData(
      id: (json['id'] as num).toInt(),
      parentNetworkId: json['parentNetworkId'] as String,
      networkType: NetworkType.fromJson(json['networkType'] as String),
      networkName: json['networkName'] as String,
      networkGroup: json['networkGroup'] as String,
      endpoints:
          (json['endpoints'] as List<dynamic>).map((e) => e as String).toList(),
      blockExplorerUrl: json['blockExplorerUrl'] as String,
      isLocal: json['isLocal'] as bool,
      nativeTokenTicker: json['nativeTokenTicker'] as String,
      isPreset: json['isPreset'] as bool,
      canBeEdited: json['canBeEdited'] as bool,
      icons: TransportIcons.fromJson(json['icons'] as Map<String, dynamic>),
      availableWalletTypes: const WalletTypeListConverter()
          .fromJson(json['availableWalletTypes'] as List),
      defaultWalletType: const WalletTypeConverter()
          .fromJson(json['defaultWalletType'] as Map<String, dynamic>),
      nativeTokenTickerOption: TransportNativeTokenTickerOption.fromJson(
          json['nativeTokenTickerOption'] as Map<String, dynamic>),
      manifestOption: TransportManifestOption.fromJson(
          json['manifestOption'] as Map<String, dynamic>),
      nativeTokenAddress: const AddressStringConverter()
          .fromJson(json['nativeTokenAddress'] as String),
      seedPhraseWordsCount: (json['seedPhraseWordsCount'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      defaultNativeCurrencyDecimal:
          (json['defaultNativeCurrencyDecimal'] as num?)?.toInt(),
      genericTokenType:
          $enumDecode(_$GenericTokenTypeEnumMap, json['genericTokenType']),
      accountExplorerLinkType: $enumDecode(
          _$AccountExplorerLinkTypeEnumMap, json['accountExplorerLinkType']),
      transactionExplorerLinkType: $enumDecodeNullable(
          _$TransactionExplorerLinkTypeEnumMap,
          json['transactionExplorerLinkType']),
      walletDefaultAccountNames: WalletDefaultAccountNames.fromJson(
          json['walletDefaultAccountNames'] as Map<String, dynamic>),
      isUsedOnStart: json['isUsedOnStart'] as bool? ?? true,
      manifestUrl: json['manifestUrl'] as String? ?? '',
      nativeTokenDecimals: (json['nativeTokenDecimals'] as num?)?.toInt() ?? 9,
      defaultActiveAssets: (json['defaultActiveAssets'] as List<dynamic>?)
              ?.map(
                  (e) => DefaultActiveAsset.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      latencyDetectionInterval:
          (json['latencyDetectionInterval'] as num?)?.toInt(),
      maxLatency: (json['maxLatency'] as num?)?.toInt(),
      endpointSelectionRetryCount:
          (json['endpointSelectionRetryCount'] as num?)?.toInt(),
      tokenApiBaseUrl: json['tokenApiBaseUrl'] as String?,
      currencyApiBaseUrl: json['currencyApiBaseUrl'] as String?,
      pollingConfig: const PollingConfigSecondsConverter()
          .fromJson(json['pollingConfig'] as Map<String, dynamic>?),
      stakeInformation: const StakingInformationConverter()
          .fromJson(json['stakeInformation'] as Map<String, dynamic>?),
      nftInformation: json['nftInformation'] == null
          ? null
          : NftInformation.fromJson(
              json['nftInformation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConnectionWorkchainDataToJson(
        _ConnectionWorkchainData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentNetworkId': instance.parentNetworkId,
      'networkType': instance.networkType.toJson(),
      'networkName': instance.networkName,
      'networkGroup': instance.networkGroup,
      'endpoints': instance.endpoints,
      'blockExplorerUrl': instance.blockExplorerUrl,
      'isLocal': instance.isLocal,
      'nativeTokenTicker': instance.nativeTokenTicker,
      'isPreset': instance.isPreset,
      'canBeEdited': instance.canBeEdited,
      'icons': instance.icons.toJson(),
      'availableWalletTypes':
          const WalletTypeListConverter().toJson(instance.availableWalletTypes),
      'defaultWalletType':
          const WalletTypeConverter().toJson(instance.defaultWalletType),
      'nativeTokenTickerOption': instance.nativeTokenTickerOption.toJson(),
      'manifestOption': instance.manifestOption.toJson(),
      'nativeTokenAddress':
          const AddressStringConverter().toJson(instance.nativeTokenAddress),
      'seedPhraseWordsCount': instance.seedPhraseWordsCount,
      'defaultNativeCurrencyDecimal': instance.defaultNativeCurrencyDecimal,
      'genericTokenType': _$GenericTokenTypeEnumMap[instance.genericTokenType]!,
      'accountExplorerLinkType':
          _$AccountExplorerLinkTypeEnumMap[instance.accountExplorerLinkType]!,
      'transactionExplorerLinkType': _$TransactionExplorerLinkTypeEnumMap[
          instance.transactionExplorerLinkType],
      'walletDefaultAccountNames': instance.walletDefaultAccountNames.toJson(),
      'isUsedOnStart': instance.isUsedOnStart,
      'manifestUrl': instance.manifestUrl,
      'nativeTokenDecimals': instance.nativeTokenDecimals,
      'defaultActiveAssets':
          instance.defaultActiveAssets.map((e) => e.toJson()).toList(),
      'latencyDetectionInterval': instance.latencyDetectionInterval,
      'maxLatency': instance.maxLatency,
      'endpointSelectionRetryCount': instance.endpointSelectionRetryCount,
      'tokenApiBaseUrl': instance.tokenApiBaseUrl,
      'currencyApiBaseUrl': instance.currencyApiBaseUrl,
      'pollingConfig':
          const PollingConfigSecondsConverter().toJson(instance.pollingConfig),
      'stakeInformation':
          const StakingInformationConverter().toJson(instance.stakeInformation),
      'nftInformation': instance.nftInformation?.toJson(),
    };

const _$GenericTokenTypeEnumMap = {
  GenericTokenType.tip3: 'tip3',
  GenericTokenType.jetton: 'jetton',
};

const _$AccountExplorerLinkTypeEnumMap = {
  AccountExplorerLinkType.accounts: 'accounts',
  AccountExplorerLinkType.accountDetails: 'accountDetails',
  AccountExplorerLinkType.packAddress: 'packAddress',
};

const _$TransactionExplorerLinkTypeEnumMap = {
  TransactionExplorerLinkType.transaction: 'transaction',
  TransactionExplorerLinkType.transactions: 'transactions',
  TransactionExplorerLinkType.transactionDetails: 'transactionDetails',
};
