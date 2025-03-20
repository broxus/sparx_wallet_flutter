import 'package:app/app/service/service.dart';
import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

const _eventIdKey = 'event_id';
const _lastEventIdKey = 'last_event_id';
const _connectionsKey = 'connections';

@singleton
class TonConnectStorageService extends AbstractStorageService {
  TonConnectStorageService(
    @Named(container) this._storage,
  );

  static const String container = 'ton_connect_storage_service';

  final GetStorage _storage;

  @override
  Future<void> init() => GetStorage.init(container);

  @override
  Future<void> clear() => _storage.erase();

  num readEventId() => _storage.read(_eventIdKey) ?? 1;

  void saveEventId(num eventId) => _storage.write(_eventIdKey, eventId);

  String? readLastEventId() => _storage.read(_lastEventIdKey);

  void saveLastEventId(String lastEventId) => _storage.write(
        _lastEventIdKey,
        lastEventId,
      );

  List<TonAppConnection> readConnections() {
    final connections = _storage.read<List<dynamic>>(_connectionsKey);
    return connections
            ?.map((e) => TonAppConnection.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  void addConnection(TonAppConnection connection) {
    final connections = readConnections()..add(connection);
    _storage.write(
      _connectionsKey,
      connections.map((e) => e.toJson()).toList(),
    );
  }

  void removeConnection(TonAppConnection connection) {
    final connections = readConnections().where((e) => e != connection);

    _storage.write(
      _connectionsKey,
      connections.map((e) => e.toJson()).toList(),
    );
  }

  void clearConnections() => _storage.remove(_connectionsKey);
}
