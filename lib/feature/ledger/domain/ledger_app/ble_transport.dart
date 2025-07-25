import 'dart:async';
import 'dart:typed_data';

import 'package:app/feature/ledger/ledger.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:logging/logging.dart';
import 'package:mutex/mutex.dart';

class BleTransport {
  BleTransport({
    required BluetoothDevice device,
    required LedgerDeviceModel deviceModel,
  }) {
    _device = device;
    _bleService = device.servicesList.firstWhere(
      (e) => e.uuid.toString() == deviceModel.bluetoothSpec.serviceUuid,
    );
    _writeCharacteristic = _bleService.characteristics.firstWhere(
      (c) => c.uuid.toString() == deviceModel.bluetoothSpec.writeUuid,
    );
    _notifyCharacteristic = _bleService.characteristics.firstWhere(
      (c) => c.uuid.toString() == deviceModel.bluetoothSpec.notifyUuid,
    );

    _mtu = device.mtuNow;
    _mtuSubscription = device.mtu.listen((mtu) async {
      if (_mtu == mtu) return;

      await _mutex.acquire();
      try {
        _mtu = mtu;
        _logger.info('MTU updated: $_mtu');
      } finally {
        _mutex.release();
      }
    });
  }

  static final _logger = Logger('BleTransport');

  final _mutex = Mutex();
  final _packer = BlePacker();
  late final BluetoothDevice _device;
  late final BluetoothService _bleService;
  late final BluetoothCharacteristic _writeCharacteristic;
  late final BluetoothCharacteristic _notifyCharacteristic;
  late final StreamSubscription<int> _mtuSubscription;
  late int _mtu;

  int get mtu => _mtu;

  Future<void> dispose() async {
    await _mtuSubscription.cancel();
  }

  Future<LedgerResponse> exchange(List<int> data) async {
    StreamSubscription<List<int>>? subscription;
    LedgerDataReader? reader;

    await _mutex.acquire();

    try {
      final completer = Completer<LedgerResponse>();
      final packets = _packer.pack(Uint8List.fromList(data), mtu);

      subscription = _notifyCharacteristic.onValueReceived.listen(
        (value) {
          try {
            if (reader == null) {
              reader = LedgerDataReader.fromBytes(value);
            } else {
              reader!.add(value);
            }

            if (reader!.isCompleted) {
              subscription?.cancel();
              completer.complete(reader!);
            }
          } catch (e, st) {
            _logger.severe('Error processing received value: $e', e, st);
            subscription?.cancel();
            completer.completeError(
              LedgerException('Error processing received value: $e'),
              st,
            );
          }
        },
        onError: (Object e, StackTrace st) {
          _logger.severe('Error in subscription: $e', e, st);
          subscription?.cancel();
          completer.completeError(
            LedgerException('Error in subscription: $e'),
            st,
          );
        },
      );

      _device.cancelWhenDisconnected(subscription);

      if (!_notifyCharacteristic.isNotifying) {
        await _notifyCharacteristic.setNotifyValue(true, timeout: 5);
      }

      for (final packet in packets) {
        await _writeCharacteristic.write(packet, timeout: 5);
      }

      return completer.future;
    } catch (e, st) {
      _logger.severe('Failed to write data: $e', e, st);
      await subscription?.cancel();
      throw LedgerException('Failed to write data: $e');
    } finally {
      _mutex.release();
    }
  }
}
