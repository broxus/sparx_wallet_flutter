import 'package:app/feature/ledger/ledger.dart';
import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class LedgerService {
  LedgerService(
    this._storageService,
    this._connectionHandler,
    this._nekotonRepository,
  );

  static final _logger = Logger('LedgerService');

  final LedgerStorageService _storageService;
  final LedgerConnectionHandlerImpl _connectionHandler;
  final NekotonRepository _nekotonRepository;

  final _interactionSubject = BehaviorSubject<LedgerInteraction>();

  Stream<LedgerInteraction> get interactionStream => _interactionSubject.stream;

  LedgerInteraction? get currentInteraction => _interactionSubject.valueOrNull;

  Stream<BluetoothAdapterState> get adapterState =>
      FlutterBluePlus.adapterState;

  LedgerAppInterface? get appInterface => _connectionHandler.appInterface;

  Future<bool> checkPermissions() async {
    final state = await FlutterBluePlus.adapterState.firstWhere(
      (state) => state != BluetoothAdapterState.unknown,
    );

    return state != BluetoothAdapterState.unauthorized;
  }

  /// This method should be called before using any Ledger functionality.
  Future<void> initLedgerConnection(LedgerAppInterface appInterface) async {
    await _connectionHandler.setAppInterface(appInterface);
  }

  Future<void> closeLedgerConnection() async {
    await _connectionHandler.setAppInterface(null);
  }

  bool hasConnectedLedger(PublicKey masterKey) =>
      _storageService.connected.containsKey(masterKey);

  Future<ConnectedLedger> connect({
    required PublicKey masterKey,
    required BluetoothDevice device,
    required DeviceModelId deviceModelId,
  }) async {
    try {
      final connected = ConnectedLedger(
        masterKey: masterKey,
        remoteId: device.remoteId.str,
        deviceModelId: deviceModelId,
      );

      _storageService.addConnectedLedger(connected);

      return connected;
    } catch (e, st) {
      _logger.severe('Error connecting Ledger device', e, st);
      _storageService.removeConnectedLedger(masterKey);
      rethrow;
    }
  }

  /// Connect to a Ledger device and return an instance of [LedgerAppInterface].
  Future<LedgerAppInterface> getAppInterface({
    required BluetoothDevice device,
    required DeviceModelId deviceModelId,
  }) async {
    try {
      await device.tryConnect();

      final app = LedgerAppInterface(
        device: device,
        deviceModelId: deviceModelId,
      );

      return app;
    } catch (e, st) {
      _logger.severe('Error connecting to Ledger device', e, st);
      rethrow;
    }
  }

  /// Retrieves the currently connected Bluetooth device, if any.
  ///
  /// Returns a [ConnectedLedger] and [BluetoothDevice] if a device is connected
  /// or `null` if no device is connected.
  Future<(ConnectedLedger, BluetoothDevice)?> getConnectedDevice(
    PublicKey masterKey,
  ) async {
    try {
      final connected = _storageService.connected[masterKey];
      if (connected == null) return null;

      final device = FlutterBluePlus.connectedDevices.firstWhereOrNull(
            (d) => d.remoteId.str == connected.remoteId,
          ) ??
          BluetoothDevice.fromId(connected.remoteId);

      return (connected, device);
    } catch (e, st) {
      _logger.severe('Failed to get connected device', e, st);
      return null;
    }
  }

  LedgerSignatureContext prepareSignatureContext(
    PrepareSignatureContext params,
  ) {
    // some magic goes here ¯\_(ツ)_/¯
    var context = LedgerSignatureContext(
      decimals: params.decimals,
      asset: params.asset,
    );

    final wallet = params.wallet;
    final workchain = wallet.address.workchain;
    if (workchain != 0) {
      context = context.copyWith(
        workchainId: workchain,
      );
    }

    final requiresAddressForSignature = switch (params.wallet.walletType) {
      WalletTypeMultisig(:final data)
          when data == MultisigType.multisig2 ||
              data == MultisigType.multisig2_1 =>
        true,
      WalletTypeEverWallet() => true,
      _ => false,
    };

    if (requiresAddressForSignature) {
      if (params is PrepareSignatureContextConfirm) {
        context = context.copyWith(
          address: wallet.address.hash,
        );
      } else if (params is PrepareSignatureContextTransfer) {
        final multicustodian = (wallet.custodians?.length ?? 0) > 1;
        if (wallet.address.isZeroState ||
            (multicustodian && wallet.publicKey != params.custodian)) {
          context = context.copyWith(
            address: wallet.address.hash,
          );
        }
      }
    }

    return context;
  }

  // I don't like it, but it works for now
  Future<T> runWithLedger<T>({
    required LedgerInteractionType interactionType,
    required PublicKey publicKey,
    required Future<T> Function() action,
    bool showBottomSheet = true,
  }) async {
    LedgerInteraction? interaction;
    final masterKey = _nekotonRepository.seedList
        .findSeedByAnyPublicKey(publicKey)!
        .masterKey;

    if (masterKey.isLedger) {
      final (connected, device) =
          await getConnectedDevice(masterKey.publicKey) ?? (null, null);

      if (connected == null || device == null) {
        throw LedgerException(
          'No connected Ledger found for "${masterKey.name}" ($publicKey)',
        );
      }

      // check if previous interaction was successful
      // and device is still connected
      if (currentInteraction == null ||
          currentInteraction?.interactionType != interactionType ||
          currentInteraction?.state != LedgerInteractionState.done ||
          appInterface == null ||
          appInterface?.device.isConnected == false) {
        interaction = LedgerInteraction(
          interactionType: interactionType,
          device: device,
          connected: connected,
          showBottomSheet: showBottomSheet,
        );
        _interactionSubject.add(interaction);

        await initLedgerConnection(
          await interaction.prepare(),
        );
      }
    }

    try {
      await interaction?.start();
      final result = await action();
      await interaction?.finish();

      return result;
    } catch (_) {
      await interaction?.cancel();
      rethrow;
    } finally {
      await interaction?.dispose();
    }
  }
}
