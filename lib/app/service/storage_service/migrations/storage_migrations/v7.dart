import 'package:app/app/service/service.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:app/utils/json/json.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class StorageMigrationV7 implements StorageMigration {
  StorageMigrationV7(this._storageAdapter);

  static const int version = 7;

  final StorageAdapter _storageAdapter;

  @override
  Future<void> apply() async {
    await _migrateIdsGroup();
  }

  @override
  Future<void> complete() async {}

  Future<void> _migrateIdsGroup() async {
    await _storageAdapter.init(ConnectionsStorageService.container);

    final storage = _storageAdapter.box(ConnectionsStorageService.container);

    final storageData = storage.read<dynamic>('connections');

    if (storageData != null) {
      final connectionsJsonList = castJsonList<Map<String, dynamic>>(
        storageData,
      );

      final result = <Map<String, dynamic>>[];

      for (final connection in connectionsJsonList) {
        final isPreset = connection['isPreset'] as bool;

        final endpoint = connection['endpoint'];
        final endpoints = connection['endpoints'];

        final nativeTokenTicker = connection['nativeTokenTicker'];

        if (isPreset) {
          continue;
        }
        result.add(
          Connection(
            id: connection['id'] as String,
            networkName: connection['name'] as String,
            defaultWorkchainId: 0,
            workchains: [
              ConnectionWorkchain(
                id: 0,
                parentConnectionId: connection['id'] as String,
                networkType: NetworkType.fromJson(
                  connection['networkType'] as String,
                ),
                networkName: connection['name'] as String,
                networkGroup: connection['group'] as String,
                transportType: WorkchainTransportType.values.byName(
                  connection['runtimeType'] as String,
                ),
                endpoints: [
                  if (endpoint != null) endpoint as String,
                  if (endpoints != null) ...castJsonList<String>(endpoints),
                ],
                icons: TransportIcons(
                  nativeToken: Assets.images.tokenDefaultIcon.path,
                  network: Assets.images.networkDefault.path,
                  vector: Assets.images.networkVectorDefault.path,
                ),
                availableWalletTypes: const [
                  WalletType.everWallet(),
                  WalletType.multisig(MultisigType.multisig2_1),
                ],
                defaultWalletType: const WalletType.everWallet(),
                nativeTokenAddress: const Address(address: ''),
                seedPhraseWordsCount: [12, 24],
                defaultNativeCurrencyDecimal:
                    connection['nativeTokenDecimals'] as int,
                genericTokenType: GenericTokenType.tip3,
                accountExplorerLinkType: AccountExplorerLinkType.accounts,
                transactionExplorerLinkType:
                    TransactionExplorerLinkType.transactions,
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
                ),
                blockExplorerUrl: connection['blockExplorerUrl'] as String,
                nativeTokenTicker: nativeTokenTicker == null
                    ? const NativeTokenTicker()
                    : NativeTokenTicker(name: nativeTokenTicker as String),
                isLocal: true,
                isPreset: false,
                canBeEdited: true,
                manifestUrl: connection['manifestUrl'] as String,
                nativeTokenDecimals: connection['nativeTokenDecimals'] as int,
                latencyDetectionInterval:
                    connection['latencyDetectionInterval'] as int?,
                maxLatency: connection['maxLatency'] as int?,
                endpointSelectionRetryCount:
                    connection['endpointSelectionRetryCount'] as int?,
              ),
            ],
            isPreset: false,
            canBeEdited: true,
          ).toJson(),
        );
      }
      await storage.remove('connections');

      await storage.write('connections', result);
    }

    await storage.remove('networks_ids');
  }
}
