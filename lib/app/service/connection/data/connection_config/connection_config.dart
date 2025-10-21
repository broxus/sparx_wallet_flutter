import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/connection_config/start_connection.dart';
import 'package:app/app/service/connection/data/connection_default_settings.dart';
import 'package:app/app/service/connection/data/custom_network/custom_network_option.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/default_network.dart';
import 'package:app/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connection_config.g.dart';

@JsonSerializable(
  createToJson: true,
  createFactory: false,
  explicitToJson: true,
)
class ConnectionConfig {
  ConnectionConfig({
    required String defaultConnectionId,
    required ConnectionDefaultSettings defaultSettings,
    required List<Connection> connections,
    required List<StartConnectionData> startConnections,
    required List<CustomNetworkOption> customNetworkOptions,
  }) : this._(
         defaultConnectionId: defaultConnectionId,
         defaultConnection: connections.firstWhere(
           (c) => c.id == defaultConnectionId,
           orElse: () => defaultPresetConnection,
         ),
         defaultSettings: defaultSettings,
         connections: connections,
         startConnections: startConnections,
         customNetworkOptions: customNetworkOptions,
         customNetworkOptionTypes: customNetworkOptions.isEmpty
             ? const [NetworkType.ever, NetworkType.tycho, NetworkType.custom]
             : List<NetworkType>.unmodifiable(
                 customNetworkOptions.map((o) => o.networkType),
               ),
       );

  ConnectionConfig._({
    required this.defaultConnectionId,
    @JsonKey(includeFromJson: false, includeToJson: false)
    required this.defaultConnection,
    required this.defaultSettings,
    required this.connections,
    required this.startConnections,
    required this.customNetworkOptions,
    @JsonKey(includeFromJson: false, includeToJson: false)
    required this.customNetworkOptionTypes,
  });

  factory ConnectionConfig.fromJson(Map<String, dynamic> json) {
    final connections = castJsonList<dynamic>(json['connections']);

    final startConnections = castJsonList<Map<String, dynamic>>(
      json['startConnections'],
    );

    final customNetworkOptions = castJsonList<dynamic>(
      json['customNetworkOptions'],
    );

    return ConnectionConfig(
      defaultConnectionId: json['defaultConnectionId'] as String,
      defaultSettings: ConnectionDefaultSettings.fromJson(
        castJsonMap(json['defaultSettings']),
      ),
      connections: [
        for (final connection in connections)
          Connection.fromJson(
            json: castJsonMap(connection),
            commonWalletDefaultAccountNames: castJsonMap(
              castJsonMap(json['defaultSettings'])['walletAccountNames'],
            ),
          ),
      ],
      startConnections: [
        for (final c in startConnections) StartConnectionData.fromJson(c),
      ],
      customNetworkOptions: [
        for (final option in customNetworkOptions)
          CustomNetworkOption.fromJson(castJsonMap(option)),
      ],
    );
  }

  final String defaultConnectionId;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Connection defaultConnection;

  final ConnectionDefaultSettings defaultSettings;
  final List<Connection> connections;
  final List<StartConnectionData> startConnections;
  final List<CustomNetworkOption> customNetworkOptions;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<NetworkType>? customNetworkOptionTypes;

  Map<String, dynamic> toJson() => _$ConnectionConfigToJson(this);
}
