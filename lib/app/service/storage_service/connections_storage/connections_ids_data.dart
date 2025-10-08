class ConnectionIdsData {
  ConnectionIdsData({
    required this.connectionId,
    required this.workchainId,
    required this.networkId,
  });

  final String connectionId;
  final int workchainId;
  final int networkId;

  late final fullId = '$connectionId$workchainId';
}
