import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/data/current_connection_data.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain_data.dart';
import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/json/json.dart';
import 'package:app/utils/parse_utils.dart';
import 'package:collection/collection.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

const _connectionsDomain = 'connections';
const _networksKey = 'networks';
const _currentConnectionIdKey = 'current_connection_id';
const _networksIdsKey = 'networks_ids';

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with custom connection - related data.
@singleton
class ConnectionsStorageService extends AbstractStorageService {
  ConnectionsStorageService(
    @Named(container) this._storage,
    this._presetsConnectionService,
    this._messengerService,
  );

  final _log = Logger('ConnectionsStorageService');
  static const container = _connectionsDomain;

  /// Storage that is used to store data
  final GetStorage _storage;
  final PresetsConnectionService _presetsConnectionService;
  final MessengerService _messengerService;

  /// Subject of [ConnectionNetwork] items
  final _networksSubject = BehaviorSubject<List<ConnectionNetwork>>.seeded([]);

  /// Subject of current connection id
  final _currentConnectionDataSubject =
      BehaviorSubject<CurrentConnectionData>();

  /// Subject of conntection id to network id (global id) map
  /// This map is used to cache network id, which can only be obtained
  /// only from network
  final _networksIdsSubject = BehaviorSubject<Map<String, int>>();

  /// Stream of [ConnectionNetwork] items
  Stream<List<ConnectionNetwork>> get networksStream => _networksSubject;

  /// Stream of currect connection id
  Stream<CurrentConnectionData> get currentConnectionDataStream =>
      _currentConnectionDataSubject;

  /// Stream of conntection id to network id map
  Stream<Map<String, int>> get networksIdsStream => _networksIdsSubject;

  /// Get last cached [ConnectionNetwork] items
  List<ConnectionNetwork> get networks => _networksSubject.valueOrNull ?? [];

  int get lastNetworkGroupNumber {
    var number = 10000;

    for (final network in networks) {
      for (final workchain in network.workchains) {
        final connectionNumber = parseToInt(
          workchain.networkGroup.split('-').last,
        );
        if (connectionNumber != null && connectionNumber > number) {
          number = connectionNumber;
        }
      }
    }
    return 10000;
  }

  ConnectionNetwork? get baseNetwork {
    final list = [...networks];
    final first = list.firstOrNull;

    if (first == null) {
      return null;
    }

    final defaultWorkchainId = _defaultNetwork.defaultWorkchainId;

    final defaultNetworkType = _defaultNetwork.workchains
        .firstWhereOrNull((w) => w.id == defaultWorkchainId)
        ?.networkType;

    for (final network in networks) {
      for (final workchain in network.workchains) {
        if (workchain.networkType == defaultNetworkType) {
          return network;
        }
      }
    }

    return first;
  }

  /// Get last cached current connection id
  CurrentConnectionData? get currentConnectionData =>
      _currentConnectionDataSubject.valueOrNull;

  /// Get last cached conntection id to network id map
  Map<String, int> get networksIds => _networksIdsSubject.value;

  /// Stream of currect connection id
  Stream<ConnectionNetwork> get currentConnectionStream => Rx.combineLatest2(
        networksStream,
        currentConnectionDataStream,
        (networks, CurrentConnectionData data) {
          for (final network in networks) {
            if (network.id != data.networkId) continue;
            for (final workchain in network.workchains) {
              if (workchain.id == data.workchainId) {
                return network;
              }
            }
          }

          return _defaultNetwork;
        },
      );

  // Get last cached currect network
  ConnectionNetwork get currentNetwork {
    final networks = this.networks;
    final currentConnectionData = this.currentConnectionData;

    ConnectionNetwork? network;

    for (final n in networks) {
      if (n.id != currentConnectionData.networkId) continue;
      for (final workchain in n.workchains) {
        if (workchain.id == data.workchainId) {
          network = n;
        }
      }
    }

    if (network == null) {
      _log.warning(
        'Current network with id ${currentConnectionData.networkId}'
        'and workchain with id ${currentConnectionData.workchainId} not found. '
        'Returning default connection',
      );

      return _defaultNetwork;
    }

    return network;
  }

  ConnectionNetwork get _defaultNetwork =>
      _presetsConnectionService.defaultNetwork;

  List<ConnectionNetwork> get _networkPresets =>
      _presetsConnectionService.networks;

  String? get _defaultNetworkId => _presetsConnectionService.defaultNetworkId;

  /// Put [ConnectionNetwork] items to stream
  void _streamedNetworks() => _networksSubject.add(
        [...readNetworks()]..sort(
            (a, b) => (a.sortingOrder - b.sortingOrder).sign.toInt(),
          ),
      );

  /// Put current connection id to stream
  void _streamedCurrentConnectionId() {
    final id = readCurrentConnectionId();

    if (id != null) {
      _currentConnectionDataSubject.add(id);
    }
  }

  void _streamedNetworksIds() => _networksIdsSubject.add(readNetworksIds());

  /// Read list of [ConnectionNetwork] items from presets and storage
  List<ConnectionNetwork> readNetworks() {
    final list = _storage.read<List<dynamic>>(_networksKey);
    var networks = <ConnectionNetwork>[];

    if (list != null) {
      final customNetworks = list
          .map(
            (entry) =>
                ConnectionNetwork.fromJson(entry as Map<String, dynamic>),
          )
          .toList();

      if (customNetworks.isNotEmpty) {
        final persistentPresets = _networkPresets.where(
          (preset) => !preset.canBeEdited,
        );
        // Remove persistent presets from custom connections
        customConnections.removeWhere(
          (connection) =>
              connection.isPreset && connection.canBeEdited == false,
        );
        // And add them from presets because we want to update them from
        // code
        connections = [...persistentPresets, ...customConnections];
      }
    }

    if (connections.isEmpty) {
      _log.info('Connections not found. Using presets.');
      connections = _networkPresets;
    }

    final connectionsText = connections
        .map(
          (connection) => 'name: ${connection.name}; '
              'networkType: ${connection.networkType}; '
              'isPreset: ${connection.isPreset}; '
              'id: ${connection.id}',
        )
        .join(',\n');
    _log.info('Connections:\n$connectionsText');

    return connections;
  }

  /// Read current connection id from storage
  CurrentConnectionData? readCurrentConnectionId() {
    final json = _storage.read<dynamic>(_currentConnectionIdKey);

    CurrentConnectionData? data;

    if (json != null) {
      data = CurrentConnectionData.fromJson(
        castJsonMap(json),
      );
    } else if (_defaultNetworkId != null) {
      data = CurrentConnectionData(
        networkId: _defaultNetworkId!,
        workchainId: _defaultNetwork.defaultWorkchainId,
      );
    }

    _log.info('Current connection '
        'networkid: ${data.networkId}; '
        'workchain id: ${data.workchainId}'
        '');

    return data;
  }

  /// Read networks ids from storage
  Map<String, int> readNetworksIds() {
    final encoded = _storage.read<Map<String, dynamic>>(_networksIdsKey);
    var map = <String, int>{};

    if (encoded != null) {
      map = Map.castFrom(encoded);
    }

    return map;
  }

  /// Save list of [ConnectionNetwork] items to storage
  void saveNetworks(List<ConnectionNetwork> networks) {
    _storage.write(
      _networksKey,
      networks.map((e) => e.toJson()).toList(),
    );
    _streamedNetworks();
  }

  /// Save current connection id to storage
  void saveCurrentConnectionData(CurrentConnectionData data) {
    var newData = data;
    if (networks.firstWhereOrNull((n) => n.id == data.networkId) == null) {
      _log.warning(
        'Trying to set current network with id '
        '${data.networkId} that not exists. '
        'Setting default connection as current',
      );

      if (_defaultNetworkId != null) {
        newData = CurrentConnectionData(
          networkId: _defaultNetworkId!,
          workchainId: _defaultNetwork.defaultWorkchainId,
        );
      }
    }

    _storage.write(_currentConnectionIdKey, newData.toJson());
    _streamedCurrentConnectionId();
  }

  void updateNetworksIds(Iterable<(String, int)> values) {
    final map = Map<String, int>.from(networksIds)
      ..addEntries(
        values.map((value) => MapEntry(value.$1, value.$2)),
      );

    _storage.write(_networksIdsKey, map);
    _streamedNetworksIds();
  }

  /// Clear [ConnectionNetwork] list
  @override
  Future<void> clear() async {
    await _storage.erase();

    _streamedNetworks();
    _streamedCurrentConnectionId();
    _streamedNetworksIds();
  }

  /// Add [ConnectionNetwork] item
  void addNetwork(ConnectionNetwork item) {
    saveNetworks([...networks, item]);
  }

  /// Remove [ConnectionNetwork] item by id
  void removeConnection({
    required String networkId,
    required String workchainId,
  }) {
    if (networkId == currentConnectionData.networkId &&
        workchainId == currentConnectionData.workchainId) {
      _log.info(
        'Trying to remove current connection. '
        'Setting default connection as current',
      );

      if (_defaultNetworkId != null) {
        saveCurrentConnectionData(
          CurrentConnectionData(
            networkId: _defaultNetworkId!,
            workchainId: _defaultNetwork.defaultWorkchainId,
          ),
        );
      }
    }

    final savedNetworks = networks;
    final items = [...savedNetworks]..removeWhere((item) => item.id == id);

    saveNetworks(items);

    _messengerService.show(
      Message.info(
        message: LocaleKeys.networkDeleted.tr(),
        actionText: LocaleKeys.undo.tr(),
        onAction: () => saveNetworks(savedNetworks),
      ),
    );
  }

  /// Update [ConnectionNetwork] item
  void updateConnection(ConnectionNetwork item) {
    final index = networks.indexWhere((element) => element.id == item.id);
    if (index < 0) {
      _log.warning('Unable to update connection with id ${item.id}. '
          'Connection not found.');

      return;
    }
    final newNetworks = [...networks];
    newNetworks[index] = item;

    saveNetworks(newNetworks);

    _messengerService.show(
      Message.info(
        message: LocaleKeys.networkSaved.tr(),
      ),
    );
  }

  /// Revert item to defaults from preset
  void revertConnection(String id) {
    final preset =
        _networkPresets.firstWhereOrNull((element) => element.id == id);
    if (preset == null) {
      _log.warning('Unable to revert connection from preset with id $id. '
          'Connection not found');

      return;
    }

    return updateConnection(preset);
  }

  @override
  Future<void> init() async {
    await GetStorage.init(container);
    _streamedNetworks();
    _streamedCurrentConnectionId();
    _streamedNetworksIds();
  }
}
