import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/feature/presets_config/presets_config.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class PresetsConnectionService {
  PresetsConnectionService(this._presetsConfigReader);

  final PresetsConfigReader _presetsConfigReader;

  final _presetsConnectionsSubj = BehaviorSubject<ConnectionConfig?>();

  ConnectionConfig? get _connectionConnection => _presetsConnectionsSubj.value;

  List<NetworkType>? get customNetworkOptions =>
      _connectionConnection?.customNetworkOptionTypes;

  ConnectionConfig? get _data => _presetsConnectionsSubj.valueOrNull;

  List<StartConnectionData> get startConnections =>
      _data?.startConnections ?? [];

  List<Connection> get connections => _data?.connections ?? [];

  Connection get defaultConnection =>
      _data?.defaultConnection ?? defaultPresetConnection;

  ConnectionDefaultSettings? get defaultSettings => _data?.defaultSettings;

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
