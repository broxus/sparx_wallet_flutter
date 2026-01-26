import 'package:app/app/service/service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/json/json.dart';
import 'package:app/utils/map_utils.dart';
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
    required WorkchainTransportType transportType,
    required List<String> endpoints,
    required TransportIcons icons,
    @WalletTypeListConverter() required List<WalletType> availableWalletTypes,
    @WalletTypeConverter() required WalletType defaultWalletType,
    required Address nativeTokenAddress,
    required List<int> seedPhraseWordsCount,
    required GenericTokenType genericTokenType,
    required AccountExplorerLinkType accountExplorerLinkType,
    required TransactionExplorerLinkType? transactionExplorerLinkType,
    required WalletDefaultAccountNames walletDefaultAccountNames,
    @Default('') String blockExplorerUrl,
    @Default(NativeTokenTicker()) NativeTokenTicker nativeTokenTicker,
    @Default(false) bool isLocal,
    @Default(true) bool isPreset,
    @Default(false) bool canBeEdited,
    @Default('') String manifestUrl,
    @Default(9) int nativeTokenDecimals,
    @Default([]) List<DefaultActiveAsset> defaultActiveAssets,
    int? defaultNativeCurrencyDecimal,
    int? latencyDetectionInterval,
    int? maxLatency,
    int? endpointSelectionRetryCount,
    String? tokenApiBaseUrl,
    String? currencyApiBaseUrl,
    String? gaslessApiBaseUrl,
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
    bool canBeEdited = true,
    bool isLocal = true,
    bool isPreset = false,
    String? networkGroup,
    int? defaultNativeCurrencyDecimal,
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
      transportType: WorkchainTransportType.proto,
      networkGroup: networkGroup ?? const Uuid().v4(),
      icons: TransportIcons(
        nativeToken: Assets.images.tokenDefaultIcon.path,
        network: Assets.images.networkDefault.path,
        vector: Assets.images.networkVectorDefault.path,
      ),
      availableWalletTypes: const [
        WalletType.everWallet(),
        WalletType.multisig(MultisigType.multisig2_1),
        WalletType.walletV5R1(),
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
      defaultNativeCurrencyDecimal:
          defaultNativeCurrencyDecimal ?? nativeTokenDecimals,
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
    required Map<String, dynamic> commonWalletDefaultAccountNames,
  }) {
    final workchainWalletDefaultAccountNames =
        json['walletDefaultAccountNames'];

    var resultWalletDefaultAccountNames = commonWalletDefaultAccountNames;

    if (workchainWalletDefaultAccountNames != null) {
      resultWalletDefaultAccountNames = mergeMaps(
        commonWalletDefaultAccountNames,
        castJsonMap(workchainWalletDefaultAccountNames),
      );
    }

    return _$ConnectionWorkchainFromJson(
      Map<String, dynamic>.from(json)
        ..['parentConnectionId'] = parentId
        ..['networkName'] = networkName
        ..['walletDefaultAccountNames'] = resultWalletDefaultAccountNames,
    );
  }

  const ConnectionWorkchain._();

  String get fullId => '$parentConnectionId-$id';
}
