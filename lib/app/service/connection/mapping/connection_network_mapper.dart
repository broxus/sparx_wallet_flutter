import 'package:app/app/service/connection/data/connection_config/connection_config.dart';
import 'package:app/app/service/connection/mapping/custom_network_options_mapper.dart';
import 'package:app/app/service/connection/mapping/networks_mapper.dart';
import 'package:app/feature/presets_config/data/connection_network_dto.dart';
import 'package:app/utils/json/json_utils.dart';

// TODO(levitckii-daniil): Replace old json mapping logic with JsonSerializable
//  tools based on custom converters.
ConnectionConfig mapToConnectionNetworkFromJson(ConnectionNetworkDto json) {
  return ConnectionConfig(
    defaultConnectionId: json.defaultConnectionId,
    customNetworkOptions: mapToCustomNetworkOptions(
      json.customNetworkOtions,
    ),
    networks: mapToNetworkList(
      castJsonList<Map<String, dynamic>>(json.networks),
    ),
  );
}
