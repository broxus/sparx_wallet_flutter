import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/feature/presets_config/presets_config.dart';
import 'package:app/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class PresetsConnectionService {
  PresetsConnectionService(this._presetsConfigReader);

  final PresetsConfigReader _presetsConfigReader;

  final _presetsConnectionsSubj = BehaviorSubject<ConnectionNetwork?>();

  ConnectionNetwork? get _connectionNetwork => _presetsConnectionsSubj.value;

  List<NetworkType>? get customNetworkOptions =>
      _connectionNetwork?.customNetworkOptionTypes;

  ConnectionNetwork? get _data => _presetsConnectionsSubj.valueOrNull;

  List<ConnectionData> get networks => _data?.networks ?? [];

  Map<NetworkGroup, ConnectionTransportData> get transports =>
      _data?.transports ?? {};

  String? get defaultConnectionId => _data?.defaultConnectionId;

  ConnectionData get defaultNetwork =>
      _data?.defaultNetwork ?? defaultPresetNetwork;

  String? currentPresetId;

  TransportIcons getTransportIconsByNetwork(NetworkGroup networkGroup) {
    return transports[networkGroup]?.icons ?? TransportIcons();
  }

  List<DefaultActiveAsset> getDefaultActiveAsset(NetworkGroup group) {
    return transports[group]?.defaultActiveAssets ?? [];
  }

  Future<void> fetchConnectionsList() async {
    _presetsConnectionsSubj.add(
      (await _presetsConfigReader.getConfig(
        PresetConfigType.connections,
      ))?.let(mapToConnectionNetworkFromJson),
    );
  }
}
