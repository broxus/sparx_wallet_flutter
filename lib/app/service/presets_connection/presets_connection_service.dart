import 'dart:async';

import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/connection_config/connection_config.dart';
import 'package:app/app/service/connection/data/default_active_asset.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/data/transport_icons.dart';
import 'package:app/app/service/connection/default_network.dart';
import 'package:app/app/service/connection/group.dart';
import 'package:app/feature/presets_config/presets_config.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class PresetsConnectionService {
  PresetsConnectionService(
    this._presetsConfigReader,
  );

  final PresetsConfigReader _presetsConfigReader;

  final _presetsConnectionsSubj = BehaviorSubject<ConnectionConfig?>();

  ConnectionConfig? get _connectionConnection => _presetsConnectionsSubj.value;

  List<NetworkType>? get customNetworkOptions =>
      _connectionConnection?.customNetworkOptionTypes;

  ConnectionConfig? get _data => _presetsConnectionsSubj.valueOrNull;

  List<Connection> get connections => _data?.connections ?? [];

  String? get defaultConnectionId => _data?.defaultConnectionId;

  Connection get defaultConnection =>
      _data?.defaultConnection ?? defaultPresetConnection;

  String? currentPresetId;

  TransportIcons getTransportIconsByNetworkGroup(NetworkGroup networkGroup) {
    for (final connection in connections) {
      for (final workchain in connection.workchains) {
        if (workchain.networkGroup == networkGroup) {
          return workchain.icons;
        }
      }
    }
    return TransportIcons();
  }

  List<DefaultActiveAsset> getDefaultActiveAsset(NetworkGroup networkGroup) {
    for (final connection in connections) {
      for (final workchain in connection.workchains) {
        if (workchain.networkGroup == networkGroup) {
          return workchain.defaultActiveAssets;
        }
      }
    }
    return [];
  }

  Future<void> fetchConnectionsList() async {
    _presetsConnectionsSubj.add(
      await _presetsConfigReader.getConfig(PresetConfigType.connections),
    );
  }
}
