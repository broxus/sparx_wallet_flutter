import 'package:app/feature/ledger/ledger.dart';

class LedgerDeviceModel {
  const LedgerDeviceModel({
    required this.id,
    required this.productName,
    required this.productIdMM,
    required this.legacyUsbProductId,
    required this.memorySize,
    required this.masks,
    required this.blockSize,
    required this.bluetoothSpec,
  });

  final DeviceModelId id;
  final String productName;
  final int productIdMM;
  final int legacyUsbProductId;
  final int memorySize;
  final List<int> masks;
  final int blockSize;
  final LedgerBluetoothSpec bluetoothSpec;
}
