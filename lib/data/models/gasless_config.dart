import 'package:nekoton_repository/nekoton_repository.dart';

class GaslessConfig {
  const GaslessConfig({required this.relayAddress, required this.gasJettons});

  final Address relayAddress;
  final List<GasJetton> gasJettons;
}

class GasJetton {
  const GasJetton({required this.masterId});

  final Address masterId;
}
