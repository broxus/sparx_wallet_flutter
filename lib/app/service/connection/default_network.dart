import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/data/network_type.dart';

final defaultPresetNetwork = ConnectionNetwork.protoPreset(
  id: 'preset_ever_mainnet_proto',
  name: 'Everscale',
  group: 'mainnet',
  endpoint: 'https://jrpc.everwallet.net',
  networkType: NetworkType.ever,
  blockExplorerUrl: 'https://everscan.io',
  manifestUrl:
      'https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json',
  canBeEdited: false,
  sortingOrder: 1,
);
