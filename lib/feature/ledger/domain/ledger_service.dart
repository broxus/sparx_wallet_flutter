import 'package:app/feature/ledger/ledger.dart';
import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _defaultTimeout = Duration(seconds: 10);

@singleton
class LedgerService {
  LedgerService(
    this._storageService,
    this._connectionHandler,
  );

  static final _logger = Logger('LedgerService');

  final LedgerStorageService _storageService;
  final LedgerConnectionHandlerImpl _connectionHandler;

  LedgerAppInterface? get current => _connectionHandler.appInterface;

  /// This method should be called before using any Ledger functionality.
  Future<void> initLedgerConnection(LedgerAppInterface appInterface) async {
    await _connectionHandler.setAppInterface(appInterface);
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
    Duration timeout = _defaultTimeout,
  }) async {
    try {
      if (!device.isConnected) {
        await device.connect(timeout: timeout);
      }

      if (device.servicesList.isEmpty) {
        await device.discoverServices();
      }

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
}
