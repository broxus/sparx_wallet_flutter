class LedgerBluetoothSpec {
  const LedgerBluetoothSpec({
    required this.serviceUuid,
    required this.writeUuid,
    required this.writeCmdUuid,
    required this.notifyUuid,
  });

  final String serviceUuid;
  final String writeUuid;
  final String writeCmdUuid;
  final String notifyUuid;
}
