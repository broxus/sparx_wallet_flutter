import 'package:app/feature/ledger/ledger.dart';

const ledgerDevices = [
  LedgerDeviceModel(
    id: DeviceModelId.nanoX,
    productName: 'Ledger Nano X',
    productIdMM: 0x40,
    legacyUsbProductId: 0x0004,
    memorySize: 2 * 1024 * 1024,
    masks: [0x33000000],
    blockSize: 4 * 1024,
    bluetoothSpec: LedgerBluetoothSpec(
      serviceUuid: '13d63400-2c97-0004-0000-4c6564676572',
      writeUuid: '13d63400-2c97-0004-0001-4c6564676572',
      writeCmdUuid: '13d63400-2c97-0004-0002-4c6564676572',
      notifyUuid: '13d63400-2c97-0004-0003-4c6564676572',
    ),
  ),
  LedgerDeviceModel(
    id: DeviceModelId.stax,
    productName: 'Ledger Stax',
    productIdMM: 0x60,
    legacyUsbProductId: 0x0006,
    memorySize: 1533 * 1024,
    masks: [0x33200000],
    blockSize: 32,
    bluetoothSpec: LedgerBluetoothSpec(
      serviceUuid: '13d63400-2c97-6004-0000-4c6564676572',
      notifyUuid: '13d63400-2c97-6004-0001-4c6564676572',
      writeUuid: '13d63400-2c97-6004-0002-4c6564676572',
      writeCmdUuid: '13d63400-2c97-6004-0003-4c6564676572',
    ),
  ),
  LedgerDeviceModel(
    id: DeviceModelId.europa,
    productName: 'Ledger Flex',
    productIdMM: 0x70,
    legacyUsbProductId: 0x0007,
    memorySize: 1533 * 1024,
    masks: [0x33300000],
    blockSize: 32,
    bluetoothSpec: LedgerBluetoothSpec(
      serviceUuid: '13d63400-2c97-3004-0000-4c6564676572',
      notifyUuid: '13d63400-2c97-3004-0001-4c6564676572',
      writeUuid: '13d63400-2c97-3004-0002-4c6564676572',
      writeCmdUuid: '13d63400-2c97-3004-0003-4c6564676572',
    ),
  ),
];
