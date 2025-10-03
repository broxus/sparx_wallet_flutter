import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/parse_utils.dart';
import 'package:collection/collection.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

const _connectionsDomain = 'connections';
const _connectionsKey = 'connections';
const _currentConnectionIdKey = 'current_connection_id';
const _connectionsIdsKey = 'connections_ids';

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

  /// Subject of [Connection] items
  final _connectionsSubject = BehaviorSubject<List<Connection>>.seeded([]);

  /// Subject of current connection id
  final _currentConnectionIdSubject = BehaviorSubject<String>();

  /// Subject of conntection id to network id (global id) map
  /// This map is used to cache network id, which can only be obtained
  /// only from network
  final _connectionsIdsSubject = BehaviorSubject<Map<String, int>>();

  /// Stream of [Connection] items
  Stream<List<Connection>> get connectionsStream => _connectionsSubject;

  /// Stream of currect connection id
  Stream<String> get currentConnectionIdStream => _currentConnectionIdSubject;

  /// Get last cached [Connection] items
  List<Connection> get connections => _connectionsSubject.valueOrNull ?? [];

  int get lastNetworkGroupNumber {
    var number = 10000;

    for (final connection in connections) {
      for (final workchain in connection.workchains) {
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

  Connection? get baseNetwork {
    final list = [...connections];
    final first = list.firstOrNull;

    if (first == null) {
      return null;
    }

    final defaultWorkchainId = _defaultConnection.defaultWorkchainId;

    final defaultNetworkType = _defaultConnection.workchains
        .firstWhereOrNull((w) => w.id == defaultWorkchainId)
        ?.networkType;

    for (final network in connections) {
      for (final workchain in network.workchains) {
        if (workchain.networkType == defaultNetworkType) {
          return network;
        }
      }
    }

    return first;
  }

  /// Get last cached current connection id
  String? get currentConnectionId => _currentConnectionIdSubject.valueOrNull;

  /// Get last cached conntection id to network id map
  Map<String, int> get connectionsIds => _connectionsIdsSubject.value;

  /// Stream of currect connection id
  Stream<Connection> get currentConnectionStream => Rx.combineLatest2(
        connectionsStream,
        currentConnectionIdStream,
        (connections, String currentNetworkId) {
          for (final connection in connections) {
            if (connection.id == currentConnectionId) return connection;
          }

          return _defaultConnection;
        },
      );

  // Get last cached currect connection
  Connection get currentConnection {
    final connections = this.connections;
    final currentConnectionId = this.currentConnectionId;

    Connection? connection;

    for (final c in connections) {
      if (c.id != currentConnectionId) continue;
      connection = c;
      break;
    }

    if (connection == null) {
      _log.warning(
        'Current connection with id $currentConnectionId '
        'not found. '
        'Returning default connection',
      );

      return _defaultConnection;
    }

    return connection;
  }

  Connection get _defaultConnection =>
      _presetsConnectionService.defaultConnection;

  List<Connection> get _connectionPresets =>
      _presetsConnectionService.connections;

  String? get _defaultConnectionId =>
      _presetsConnectionService.defaultConnectionId;

  /// Put [Connection] items to stream
  void _streamedConnections() => _connectionsSubject.add(
        [...readConnections()]..sort(
            (a, b) => (a.sortingOrder - b.sortingOrder).sign.toInt(),
          ),
      );

  /// Put current connection id to stream
  void _streamedCurrentConnectionId() {
    final id = readCurrentConnectionId();

    if (id != null) {
      _currentConnectionIdSubject.add(id);
    }
  }

  void _streamedConnectionsIds() =>
      _connectionsIdsSubject.add(readConnectionsIds());

  /// Read list of [Connection] items from presets and storage
  List<Connection> readConnections() {
    final list = _storage.read<List<dynamic>>(_connectionsKey);
    var connections = <Connection>[];

    if (list != null) {
      final customConnections = list
          .map(
            (entry) => Connection.fromJson(entry as Map<String, dynamic>),
          )
          .toList();

      if (customConnections.isNotEmpty) {
        // Remove persistent presets from custom connections
        customConnections.removeWhere(
          (connection) =>
              connection.isPreset && connection.canBeEdited == false,
        );
        // And add them from presets because we want to update them from
        // code
        connections = [..._connectionPresets, ...customConnections];
      }
    }

    if (connections.isEmpty) {
      _log.info('Connections not found. Using presets.');
      connections = _connectionPresets;
    }

    final connectionsText = connections
        .map(
          (connection) => 'name: ${connection.networkName}; '
              'isPreset: ${connection.isPreset}; '
              'id: ${connection.id}',
        )
        .join(',\n');
    _log.info('Connections:\n$connectionsText');

    return connections;
  }

  /// Read current connection id from storage
  String? readCurrentConnectionId() {
    final connectionId =
        (_storage.read<dynamic>(_currentConnectionIdKey) as String?) ??
            _defaultConnectionId;

    _log.info('Current connection connection id: $connectionId');

    return connectionId;
  }

  /// Read connections ids from storage
  Map<String, int> readConnectionsIds() {
    final encoded = _storage.read<Map<String, dynamic>>(_connectionsIdsKey);
    var map = <String, int>{};

    if (encoded != null) {
      map = Map.castFrom(encoded);
    }

    return map;
  }

  /// Save list of [Connection] items to storage
  void saveConnections(List<Connection> connections) {
    _storage.write(
      _connectionsKey,
      connections.map((e) => e.toJson()).toList(),
    );
    _streamedConnections();
  }

  /// Save current connection id to storage
  void saveCurrentConnectionId(String connectionId) {
    String? id = connectionId;

    if (connections.firstWhereOrNull((n) => n.id == connectionId) == null) {
      _log.warning(
        'Trying to set current connection with id '
        '$connectionId that not exists. '
        'Setting default connection as current',
      );

      id = _defaultConnectionId;
    }

    _storage.write(_currentConnectionIdKey, id);
    _streamedCurrentConnectionId();
  }

  void updateConnectionsIds(Iterable<(String, int)> values) {
    final map = Map<String, int>.from(connectionsIds)
      ..addEntries(
        values.map((value) => MapEntry(value.$1, value.$2)),
      );

    _storage.write(_connectionsIdsKey, map);
    _streamedConnectionsIds();
  }

  /// Clear [Connection] list
  @override
  Future<void> clear() async {
    await _storage.erase();

    _streamedConnections();
    _streamedCurrentConnectionId();
    _streamedConnectionsIds();
  }

  /// Add [Connection] item
  void addConnection(Connection item) {
    saveConnections([...connections, item]);
  }

  /// Remove [Connection] item by id
  void removeConnection(String id) {
    if (id == currentConnectionId) {
      _log.info(
        'Trying to remove current connection. '
        'Setting default connection as current',
      );

      if (_defaultConnectionId != null) {
        saveCurrentConnectionId(_defaultConnectionId!);
      }
    }

    final savedConnections = connections;
    final items = [...savedConnections]..removeWhere(
        (item) => item.id == id,
      );

    saveConnections(items);

    _messengerService.show(
      Message.info(
        message: LocaleKeys.networkDeleted.tr(),
        actionText: LocaleKeys.undo.tr(),
        onAction: () => saveConnections(savedConnections),
      ),
    );
  }

  /// Update [Connection] item
  void updateConnection(Connection item) {
    final index = connections.indexWhere((element) => element.id == item.id);
    if (index < 0) {
      _log.warning('Unable to update connection with id ${item.id}. '
          'Connection not found.');

      return;
    }
    final newConnections = [...connections];
    newConnections[index] = item;

    saveConnections(newConnections);

    _messengerService.show(
      Message.info(
        message: LocaleKeys.networkSaved.tr(),
      ),
    );
  }

  /// Revert item to defaults from preset
  void revertConnection(String id) {
    final preset =
        _connectionPresets.firstWhereOrNull((element) => element.id == id);
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
    _streamedConnections();
    _streamedCurrentConnectionId();
    _streamedConnectionsIds();
  }
}
