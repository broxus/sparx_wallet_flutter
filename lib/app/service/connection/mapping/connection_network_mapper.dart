import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/mapping/custom_network_options_mapper.dart';
import 'package:app/app/service/connection/mapping/networks_mapper.dart';
import 'package:app/app/service/connection/mapping/transports_mapper.dart';
import 'package:app/feature/presets_config/data/connection_network_dto.dart';
import 'package:app/utils/json/json_utils.dart';

// TODO(levitckii-daniil): Replace old json mapping logic with JsonSerializable
//  tools based on custom converters.
ConnectionNetwork mapToConnectionNetworkFromJson(ConnectionNetworkDto json) {
  return ConnectionNetwork(
    defaultConnectionId: json.defaultConnectionId,
    customNetworkOptions: mapToCustomNetworkOptions(
      json.customNetworkOtions,
    ),
    networks: mapToConnectionDataList(
      castJsonList<Map<String, dynamic>>(json.networks),
    ),
    transports: mapToTransports(
      castJsonList<Map<String, dynamic>>(json.transports),
    ),
  );
}
