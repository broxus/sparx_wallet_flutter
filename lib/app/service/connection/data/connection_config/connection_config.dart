import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/custom_network/custom_network_option.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/default_network.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_config.freezed.dart';

part 'connection_config.g.dart';

@Freezed(fromJson: false, toJson: true)
abstract class ConnectionConfig with _$ConnectionConfig {
  factory ConnectionConfig({
    required String defaultConnectionId,
    required Map<String, dynamic> rawDefaultSettings,
    List<Connection>? connections,
    List<CustomNetworkOption>? customNetworkOptions,
  }) {
    final defaultConnection = connections?.firstWhereOrNull(
          (connection) => connection.id == defaultConnectionId,
        ) ??
        defaultPresetConnection;

    return ConnectionConfig._(
      defaultConnectionId: defaultConnection.id,
      rawDefaultSettings: rawDefaultSettings,
      connections: connections,
      customNetworkOptions: customNetworkOptions,
      defaultConnection: defaultConnection,
      customNetworkOptionTypes: customNetworkOptions == null
          ? [NetworkType.ever, NetworkType.tycho, NetworkType.custom]
          : [
              for (final option in customNetworkOptions) option.networkType,
            ],
    );
  }

  @JsonSerializable(
    explicitToJson: true,
    createFactory: false,
  )
  const factory ConnectionConfig._({
    required String defaultConnectionId,
    required Map<String, dynamic> rawDefaultSettings,
    @JsonKey(includeFromJson: false, includeToJson: false)
    required Connection defaultConnection,
    List<Connection>? connections,
    List<CustomNetworkOption>? customNetworkOptions,
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<NetworkType>? customNetworkOptionTypes,
  }) = _ConnectionConfig;

  factory ConnectionConfig.fromJson(Map<String, dynamic> json) {
    final connections = castJsonList<dynamic>(json['connections']);

    final customNetworkOptions =
        castJsonList<dynamic>(json['customNetworkOptions']);

    return ConnectionConfig(
      defaultConnectionId: json['defaultConnectionId'] as String,
      rawDefaultSettings: castJsonMap(json['defaultSettings']),
      connections: [
        for (final connection in connections)
          Connection.fromJson(
            json: castJsonMap(connection),
            commonWalletDefaultAccountNames: castJsonMap(
              castJsonMap(json['defaultSettings'])['walletAccountNames'],
            ),
          ),
      ],
      customNetworkOptions: [
        for (final option in customNetworkOptions)
          CustomNetworkOption.fromJson(castJsonMap(option)),
      ],
    );
  }
}
