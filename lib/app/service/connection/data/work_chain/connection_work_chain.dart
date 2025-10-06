import 'package:app/app/service/connection/data/account_explorer/account_explorer_link_type.dart';
import 'package:app/app/service/connection/data/default_active_asset.dart';
import 'package:app/app/service/connection/data/native_token_ticker/native_token_ticker.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/nft_information/nft_information.dart';
import 'package:app/app/service/connection/data/transaction_explorer/transaction_explorer_link_type.dart';
import 'package:app/app/service/connection/data/transport_icons.dart';
import 'package:app/app/service/connection/data/wallet_default_account_names.dart';
import 'package:app/app/service/connection/data/work_chain/workchain_type.dart';
import 'package:app/app/service/connection/generic_token_subscriber.dart';
import 'package:app/app/service/connection/json_converters/address_converter.dart';
import 'package:app/app/service/connection/json_converters/polling_config_converter.dart';
import 'package:app/app/service/connection/json_converters/staking_information_converter.dart';
import 'package:app/app/service/connection/json_converters/wallet_type_converter.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:uuid/uuid.dart';

part 'connection_work_chain.freezed.dart';

part 'connection_work_chain.g.dart';

@freezed
abstract class ConnectionWorkchain with _$ConnectionWorkchain {
  factory ConnectionWorkchain({
    required int id,
    required String parentConnectionId,
    required NetworkType networkType,
    required String networkName,
    required String networkGroup,
    required WorkchainType type,
    required List<String> endpoints,
    required TransportIcons icons,
    @WalletTypeListConverter() required List<WalletType> availableWalletTypes,
    @WalletTypeConverter() required WalletType defaultWalletType,
    @AddressStringConverter() required Address nativeTokenAddress,
    required List<int> seedPhraseWordsCount,
    required int? defaultNativeCurrencyDecimal,
    required GenericTokenType genericTokenType,
    required AccountExplorerLinkType accountExplorerLinkType,
    required TransactionExplorerLinkType? transactionExplorerLinkType,
    required WalletDefaultAccountNames walletDefaultAccountNames,
    @Default('') String blockExplorerUrl,
    @Default(NativeTokenTicker()) NativeTokenTicker nativeTokenTicker,
    @Default(false) bool isLocal,
    @Default(true) bool isPreset,
    @Default(false) bool canBeEdited,
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
  }) = _ConnectionWorkchain;

  factory ConnectionWorkchain.custom({
    required int id,
    required String parentConnectionId,
    required NetworkType networkType,
    required String networkName,
    required List<String> endpoints,
    required String blockExplorerUrl,
    required String manifestUrl,
    required int defaultNativeCurrencyDecimal,
    bool canBeEdited = true,
    bool isLocal = true,
    bool isPreset = false,
    String? networkGroup,
    int? latencyDetectionInterval,
    int? maxLatency,
    NativeTokenTicker nativeTokenTicker = const NativeTokenTicker(),
    int nativeTokenDecimals = 9,
  }) {
    return ConnectionWorkchain(
      id: id,
      parentConnectionId: parentConnectionId,
      networkType: networkType,
      networkName: networkName,
      type: WorkchainType.proto,
      networkGroup: networkGroup ?? const Uuid().v4(),
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
      endpoints: endpoints,
      blockExplorerUrl: blockExplorerUrl,
      isLocal: isLocal,
      nativeTokenTicker: nativeTokenTicker,
      nativeTokenDecimals: nativeTokenDecimals,
      isPreset: isPreset,
      canBeEdited: canBeEdited,
      defaultNativeCurrencyDecimal: defaultNativeCurrencyDecimal,
      manifestUrl: manifestUrl,
      latencyDetectionInterval: latencyDetectionInterval,
      maxLatency: maxLatency,
    );
  }

  factory ConnectionWorkchain.fromJson(Map<String, dynamic> json) =>
      _$ConnectionWorkchainFromJson(json);

  factory ConnectionWorkchain.fromJsonCustom({
    required Map<String, dynamic> json,
    required String parentId,
    required String networkName,
  }) {
    final map = Map<String, dynamic>.from(json)
      ..['parentConnectionId'] = parentId
      ..['networkName'] = networkName;

    return _$ConnectionWorkchainFromJson(map);
  }
}
