import 'package:app/app/service/service.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/subjects.dart';

const _eventIdKey = 'event_id';
const _lastEventIdKey = 'last_event_id';
const _connectionsKey = 'connections';

@singleton
class TonConnectStorageService extends AbstractStorageService {
  TonConnectStorageService(
    @Named(container) this._storage,
  );

  static const String container = 'ton_connect_storage_service';

  static final _logger = Logger('TonConnectStorageService');

  final GetStorage _storage;

  late var _eventId = _readEventId();

  final _connectionsSubject = BehaviorSubject<List<TonAppConnection>>();

  Stream<List<TonAppConnection>> get connectionsStream =>
      _connectionsSubject.stream;

  @override
  Future<void> init() => GetStorage.init(container);

  @override
  Future<void> clear() => _storage.erase();

  String getEventId() {
    _saveEventId(++_eventId);
    return _eventId.toString();
  }

  String? readLastEventId() => _storage.read(_lastEventIdKey);

  void saveLastEventId(String lastEventId) => _storage.write(
        _lastEventIdKey,
        lastEventId,
      );

  List<TonAppConnection> readConnections() {
    try {
      final json = _storage.read<List<dynamic>>(_connectionsKey);
      final connections = json
              ?.map((e) => TonAppConnection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];

      _connectionsSubject.add(connections);
      return connections;
    } catch (e, s) {
      _logger.warning('Failed to read connections', e, s);
      clearConnections();
      return [];
    }
  }

  void addConnection(TonAppConnection connection) {
    final connections = readConnections()..add(connection);

    _connectionsSubject.add(connections);
    _storage.write(
      _connectionsKey,
      connections.map((e) => e.toJson()).toList(),
    );
  }

  void removeConnection(TonAppConnection connection) {
    final connections =
        readConnections().where((e) => e != connection).toList();

    _connectionsSubject.add(connections);
    _storage.write(
      _connectionsKey,
      connections.map((e) => e.toJson()).toList(),
    );
  }

  void clearConnections() => _storage.remove(_connectionsKey);

  num _readEventId() => _storage.read(_eventIdKey) ?? 1;

  void _saveEventId(num eventId) => _storage.write(_eventIdKey, eventId);
}
