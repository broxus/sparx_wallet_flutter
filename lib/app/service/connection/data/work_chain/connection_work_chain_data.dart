import 'package:app/app/service/connection/data/account_explorer/account_explorer_link_type.dart';
import 'package:app/app/service/connection/data/default_active_asset.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/nft_information/nft_information.dart';
import 'package:app/app/service/connection/data/transaction_explorer/transaction_explorer_link_type.dart';
import 'package:app/app/service/connection/data/transport_icons.dart';
import 'package:app/app/service/connection/data/transport_manifest_option/transport_manifest_option.dart';
import 'package:app/app/service/connection/data/transport_native_token_option/transport_native_token_option.dart';
import 'package:app/app/service/connection/data/wallet_default_account_names.dart';
import 'package:app/app/service/connection/generic_token_subscriber.dart';
import 'package:app/app/service/connection/json_converters/address_converter.dart';
import 'package:app/app/service/connection/json_converters/polling_config_converter.dart';
import 'package:app/app/service/connection/json_converters/staking_information_converter.dart';
import 'package:app/app/service/connection/json_converters/wallet_type_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'connection_work_chain_data.freezed.dart';

part 'connection_work_chain_data.g.dart';

@freezed
abstract class ConnectionWorkChainData with _$ConnectionWorkChainData {
  factory ConnectionWorkChainData({
    required int id,
    required String type,
    required NetworkType networkType,
    required String networkGroup,
    required List<String> endpoints,
    required String blockExplorerUrl,
    required bool isLocal,
    required String nativeTokenTicker,
    required bool isPreset,
    required bool canBeEdited,
    required TransportIcons icons,
    @WalletTypeListConverter()
    required List<WalletType> availableWalletTypes,
    @WalletTypeConverter()
    required WalletType defaultWalletType,
    required TransportNativeTokenTickerOption nativeTokenTickerOption,
    required TransportManifestOption manifestOption,
    @AddressStringConverter()
    required Address nativeTokenAddress,
    required List<int> seedPhraseWordsCount,
    required int? defaultNativeCurrencyDecimal,
    required GenericTokenType genericTokenType,
    required AccountExplorerLinkType accountExplorerLinkType,
    required TransactionExplorerLinkType? transactionExplorerLinkType,
    required WalletDefaultAccountNames walletDefaultAccountNames,
    @Default(true) bool isUsedOnStart,
    @Default('') String manifestUrl,
    @Default(9) int nativeTokenDecimals,
    @Default([]) List<DefaultActiveAsset> defaultActiveAssets,
    int? latencyDetectionInterval,
    int? maxLatency,
    int? endpointSelectionRetryCount,
    String? tokenApiBaseUrl,
    String? currencyApiBaseUrl,
    @PollingConfigSecondsConverter() PollingConfig? pollingConfig,
    @StakingInformationConverter() StakingInformation? stakeInformation,
    NftInformation? nftInformation,
  }) = _ConnectionWorkChainData;

  factory ConnectionWorkChainData.fromJson(Map<String, dynamic> json) =>
      _$ConnectionWorkChainDataFromJson(json);
}
