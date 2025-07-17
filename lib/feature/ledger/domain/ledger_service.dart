import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class LedgerService {
  LedgerService(
    this._storageService,
    this._connectionHandler,
    this._nekotonRepository,
    this._permissionsService,
  );

  static final _logger = Logger('LedgerService');

  final LedgerStorageService _storageService;
  final LedgerConnectionHandlerImpl _connectionHandler;
  final NekotonRepository _nekotonRepository;
  final AppPermissionsService _permissionsService;

  Stream<BluetoothAdapterState> get adapterState =>
      FlutterBluePlus.adapterState;

  LedgerAppInterface? get current => _connectionHandler.appInterface;

  Future<bool> checkPermissions() async {
    final isGranted = await _permissionsService.requestPermissions([
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ]);

    return isGranted;
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

  Future<T> runWithLedger<T>({
    required BuildContext context,
    required LedgerInteractionType interactionType,
    required PublicKey publicKey,
    required Future<T> Function() action,
  }) async {
    BehaviorSubject<LedgerInteractionState>? subject;
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

      subject = BehaviorSubject.seeded(
        LedgerInteractionState.connecting,
      );
      final tmp = showLedgerInteractionSheet(
        context: context,
        interactionType: interactionType,
        stateStream: subject.stream,
      );

      final appInterface = await getAppInterface(
        device: device,
        deviceModelId: connected.deviceModelId,
      );
    }

    try {
      if (interactionType.needsConfirmation) {
        subject?.add(LedgerInteractionState.confirming);
      }

      final result = await action();
      subject?.add(LedgerInteractionState.done);

      return result;
    } catch (_) {
      subject?.add(LedgerInteractionState.cancelled);
      rethrow;
    } finally {
      await subject?.close();
    }
  }

  // TODO: prepare ledger interaction
}
