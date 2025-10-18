import 'dart:async';

import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/app/service/service.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_ids_data.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/json/json.dart';
import 'package:app/utils/parse_utils.dart';
import 'package:collection/collection.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
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
    this._nekotonRepository,
  );

  final _log = Logger('ConnectionsStorageService');
  static const container = _connectionsDomain;

  /// Storage that is used to store data
  final GetStorage _storage;
  final PresetsConnectionService _presetsConnectionService;
  final MessengerService _messengerService;
  final NekotonRepository _nekotonRepository;

  /// Subject of [Connection] items
  final _connectionsSubject = BehaviorSubject<List<Connection>>.seeded([]);

  /// Subject of current connection id
  final _currentConnectionIdSubject = BehaviorSubject<(String, int)?>();

  /// Subject of conntection id + workchain id to network id (global id) map
  /// This map is used to cache network id, which can only be obtained
  /// only from network
  final _connectionsIdsSubject =
      BehaviorSubject<Map<String, ConnectionIdsData>>();

  /// Stream of [Connection] items
  Stream<List<Connection>> get connectionsStream => _connectionsSubject;

  /// Stream of currect connection id
  Stream<(String, int)?> get currentConnectionIdStream =>
      _currentConnectionIdSubject;

  /// Get last cached [Connection] items
  List<Connection> get connections => _connectionsSubject.valueOrNull ?? [];

  String? get currentConnectionId =>
      _currentConnectionIdSubject.valueOrNull?.$1;

  int? get currentWorkchainId => _currentConnectionIdSubject.valueOrNull?.$2;

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

  Connection? get baseConnection {
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
  (String, int)? get currentConnectionIds =>
      _currentConnectionIdSubject.valueOrNull;

  /// Get last cached conntection id to network id map
  Map<String, ConnectionIdsData> get connectionsIds =>
      _connectionsIdsSubject.value;

  /// Stream of currect connection id
  Stream<Connection> get currentConnectionStream => Rx.combineLatest2(
        connectionsStream,
        _currentConnectionIdSubject,
        (connections, (String, int)? ids) {
          for (final connection in connections) {
            if (connection.id == ids?.$1) return connection;
          }
          return _defaultConnection;
        },
      );

  Stream<ConnectionWorkchain> get currentWorkchainStream => Rx.combineLatest2(
        connectionsStream,
        _currentConnectionIdSubject,
        (connections, (String, int)? ids) {
          for (final connection in connections) {
            if (connection.id != ids?.$1) continue;
            for (final workchain in connection.workchains) {
              if (workchain.id == ids?.$2) return workchain;
            }
          }
          return _defaultConnection.defaultWorkchain;
        },
      );

  Connection? get currentConnection {
    final id = currentConnectionId;

    if (id == null) {
      return null;
    }

    return connections.firstWhereOrNull((c) => c.id == id);
  }

  ConnectionWorkchain get currentWorkchain {
    final ids = _currentConnectionIdSubject.valueOrNull;

    final connection = ids == null
        ? null
        : connections.firstWhereOrNull((c) => c.id == ids.$1);

    final workchain =
        connection?.workchains.firstWhereOrNull((w) => w.id == ids?.$2);

    if (connection == null || workchain == null) {
      _log.warning(
        'Current connection ${connection == null ? '' : '${connection.id} '}'
        'and current workchain '
        'not found. '
        'Returning default connection',
      );

      return _defaultConnection.defaultWorkchain;
    }

    return workchain;
  }

  Connection get _defaultConnection =>
      _presetsConnectionService.defaultConnection;

  List<Connection> get _connectionPresets =>
      _presetsConnectionService.connections;

  bool checkIsCurrentWorkchain(int workchainId) =>
      workchainId == _currentConnectionIdSubject.valueOrNull?.$2;

  bool checkIsCurrentWorkchainIfExist(int workchainId) {
    return _currentConnectionIdSubject.valueOrNull?.$2 == null ||
        checkIsCurrentWorkchain(workchainId);
  }

  /// Read list of [Connection] items from presets and storage
  List<Connection> readConnections() {
    final list = _storage.read<List<dynamic>>(_connectionsKey);
    var connections = <Connection>[];

    if (list != null) {
      final customConnections = list
          .map(
            (entry) => Connection.fromJson(
              json: entry as Map<String, dynamic>,
              commonWalletDefaultAccountNames:
                  _presetsConnectionService.defaultSettings?.toJson() ?? {},
            ),
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

  /// Save list of [Connection] items to storage
  void saveConnections(List<Connection> connections) {
    _storage.write(
      _connectionsKey,
      connections.map((e) => e.toJson()).toList(),
    );
    _streamedConnections();
  }

  /// Save current connection id to storage
  Future<void> saveCurrentConnectionId({
    required String connectionId,
    int? workchainId,
  }) async {
    final connection =
        connections.firstWhereOrNull((n) => n.id == connectionId);

    String? savedConnectionId;
    int? savedWorkchainId;

    if (connection == null) {
      _log.warning(
        'Trying to set current connection with id '
        '$connectionId that not exists. '
        'Setting default connection as current',
      );

      savedConnectionId = _presetsConnectionService.defaultConnection.id;
      savedWorkchainId =
          _presetsConnectionService.defaultConnection.defaultWorkchainId;
    } else {
      savedConnectionId = connection.id;

      savedWorkchainId = workchainId == null
          ? connection.defaultWorkchainId
          : connection.workchains
                  .firstWhereOrNull((w) => w.id == workchainId)
                  ?.id ??
              connection.defaultWorkchainId;
    }

    unawaited(_storage.write(_currentConnectionIdKey, savedConnectionId));
    await _fetchAccountsForWorkchain(savedWorkchainId);
    _currentConnectionIdSubject.add((savedConnectionId, savedWorkchainId));
  }

  void updateConnectionsIds(Iterable<ConnectionIdsData> values) {
    final map = Map<String, ConnectionIdsData>.from(connectionsIds)
      ..addEntries(
        values.map((value) => MapEntry(value.fullId, value)),
      );

    _storage.write(_connectionsIdsKey, map);
    _connectionsIdsSubject.add(map);
  }

  /// Clear [Connection] list
  @override
  Future<void> clear() async {
    await _storage.erase();

    _streamedConnections();
    _currentConnectionIdSubject.add(null);
    _connectionsIdsSubject.add({});
  }

  /// Add [Connection] item
  void addConnection(Connection item) {
    saveConnections([...connections, item]);
  }

  /// Remove [Connection] item by id
  void removeConnection(String id) {
    if (id == currentConnectionIds?.$1) {
      _log.info(
        'Trying to remove current connection. '
        'Setting default connection as current',
      );

      saveCurrentConnectionId(
        connectionId: _defaultConnection.id,
        workchainId: _defaultConnection.defaultWorkchainId,
      );
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
    _currentConnectionIdSubject.add(_readCurrentConnectionId());
    _connectionsIdsSubject.add(_readConnectionsIds());
  }

  Future<void> fetchAccountsForCurrentWorkchain() async {
    if (currentWorkchainId == null) {
      return;
    }
    return _fetchAccountsForWorkchain(currentWorkchainId!);
  }

  Future<void> _fetchAccountsForWorkchain(int workchainId) async {
    final publicKeys =
        _nekotonRepository.keyStore.keys.map((e) => e.publicKey).toList();

    await _nekotonRepository.triggerAddingAccounts(
      publicKeys,
      workchainId: workchainId,
    );

    final hasAny = _nekotonRepository.accountsStorage.accounts
        .any((a) => a.address.workchain == workchainId);

    if (hasAny) return;

    for (final key in publicKeys) {
      try {
        await _nekotonRepository.addDefaultAccount(
          key,
          workchainId: workchainId,
        );
      } catch (e, s) {
        _log.severe('fetchAccountsForWorkchain', e, s);
      }
    }
  }

  /// Put [Connection] items to stream
  void _streamedConnections() => _connectionsSubject.add(
        [...readConnections()]..sort(
            (a, b) => (a.sortingOrder - b.sortingOrder).sign.toInt(),
          ),
      );

  /// Read current connection id from storage
  (String, int)? _readCurrentConnectionId() {
    final connectionId =
        _storage.read<dynamic>(_currentConnectionIdKey) as String?;

    final connection =
        connections.firstWhereOrNull((c) => c.id == connectionId);

    if (connection == null) {
      return (
        _presetsConnectionService.defaultConnection.id,
        _presetsConnectionService.defaultConnection.defaultWorkchainId
      );
    }

    _log.info('Current connection connection id: $connectionId');

    return (connection.id, connection.defaultWorkchainId);
  }

  /// Read connections ids from storage
  Map<String, ConnectionIdsData> _readConnectionsIds() {
    try {
      final encoded = _storage.read<Map<String, dynamic>>(_connectionsIdsKey);

      final map = <String, ConnectionIdsData>{};

      encoded?.forEach((connectionId, connectionDataJSON) {
        map[connectionId] = ConnectionIdsData(
          connectionId: connectionId,
          workchainId: castJsonMap(connectionDataJSON)['workchainId'] as int,
          networkId: castJsonMap(connectionDataJSON)['networkId'] as int,
        );
      });

      return map;
    } catch (_) {
      return {};
    }
  }
}
