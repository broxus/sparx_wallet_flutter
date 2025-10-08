import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/connection_default_settings.dart';
import 'package:app/app/service/connection/data/custom_network/custom_network_option.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/default_network.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_config.freezed.dart';

@Freezed(fromJson: false, toJson: false)
abstract class ConnectionConfig with _$ConnectionConfig {
  factory ConnectionConfig({
    required Connection currentConnection,
    required Connection defaultConnection,
    required ConnectionDefaultSettings defaultSettings,
    List<Connection>? connections,
    List<CustomNetworkOption>? customNetworkOptions,
  }) = _ConnectionConfig;

  factory ConnectionConfig.fromJson(Map<String, dynamic> json) {
    final connectionsJSON = castJsonList<dynamic>(json['connections']);
    final customNetworkOptionsJSON =
        castJsonList<dynamic>(json['customNetworkOptions']);
    final defaultConnectionId = json['defaultConnectionId'] as String;

    final commonWalletDefaultAccountNames = castJsonMap(
      castJsonMap(json['defaultSettings'])['walletAccountNames'],
    );

    final connections = <Connection>[];

    for (final connection in connectionsJSON) {
      connections.add(
        Connection.fromJson(
          json: castJsonMap(connection),
          commonWalletDefaultAccountNames: commonWalletDefaultAccountNames,
        ),
      );
    }

    final defaultConnection = connections.firstWhereOrNull(
          (connection) => connection.id == defaultConnectionId,
        ) ??
        defaultPresetConnection;

    return ConnectionConfig(
      currentConnection: defaultConnection,
      defaultConnection: defaultConnection,
      defaultSettings: ConnectionDefaultSettings.fromJson(
        castJsonMap(json['defaultSettings']),
      ),
      connections: connections,
      customNetworkOptions: [
        for (final option in customNetworkOptionsJSON)
          CustomNetworkOption.fromJson(castJsonMap(option)),
      ],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'defaultConnectionId': defaultConnection.id,
      'customNetworkOptions': [
        if (customNetworkOptions != null)
          for (final option in customNetworkOptions!) option.toJson(),
      ],
      'defaultSettings': defaultSettings.toJson(),
      'connections': [
        if (connections != null)
          for (final connection in connections!) connection.toJson(),
      ],
    };
  }
}

extension ConnectionConfigExt on ConnectionConfig {
  String get currentConnectionId => currentConnection.id;

  String get defaultConnectionId => defaultConnection.id;

  List<NetworkType> get customNetworkOptionTypes => [
        if (customNetworkOptions != null)
          for (final option in customNetworkOptions!) option.networkType,
      ];
}
