import 'package:app/app/service/service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/utils/utils.dart';

const _connectedLedgersKey = 'connected_ledgers';

@singleton
class LedgerStorageService extends AbstractStorageService {
  LedgerStorageService(
    @Named(container) this._storage,
  );

  static const String container = 'ledger_storage_service';

  final GetStorage _storage;

  final _connectedSubject = BehaviorSubject<Map<PublicKey, ConnectedLedger>>();

  Stream<Map<PublicKey, ConnectedLedger>> get connectedStream =>
      _connectedSubject.stream;

  Map<PublicKey, ConnectedLedger> get connected =>
      _connectedSubject.valueOrNull ?? {};

  @override
  Future<void> init() async {
    await GetStorage.init(container);
    _streamedConnectedLedgers();
  }

  @override
  Future<void> clear() async {
    try {
      await _storage.erase();
    } catch (_) {}
  }

  List<ConnectedLedger> readConnectedLedgers() {
    final encoded = _storage.read<List<dynamic>>(_connectedLedgersKey) ?? [];
    return encoded
        .map((e) => ConnectedLedger.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  void addConnectedLedger(ConnectedLedger connected) {
    final current = _connectedSubject.valueOrNull ?? {};
    final updated = {
      ...current,
      connected.masterKey: connected,
    };

    _storage.write(
      _connectedLedgersKey,
      updated.values.map((e) => e.toJson()).toList(),
    );
    _connectedSubject.add(updated);
  }

  void removeConnectedLedger(PublicKey masterKey) {
    final current = _connectedSubject.valueOrNull ?? {};
    final updated = Map<PublicKey, ConnectedLedger>.from(current)
      ..remove(masterKey);

    _storage.write(
      _connectedLedgersKey,
      updated.values.map((e) => e.toJson()).toList(),
    );
    _connectedSubject.add(updated);
  }

  void _streamedConnectedLedgers() => _connectedSubject.add(
        readConnectedLedgers().toMap((e) => e.masterKey),
      );
}
