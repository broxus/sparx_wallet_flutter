import 'package:app/app/service/database/main_database.dart';
import 'package:drift/drift.dart';
import 'package:logging/logging.dart';

class PermissionsDelegate {
  PermissionsDelegate(this._db);

  final MainDatabase _db;

  late final _log = Logger('Database PermissionsDelegate');

  Future<void> savePermissions(String host, List<String> permissions) async {
    final set = permissions
        .map(_normalizePerm)
        .where((p) => p.isNotEmpty)
        .toSet();
    if (set.isEmpty) return;

    final rows = set
        .map((p) => PermissionsTableCompanion.insert(host: host, permission: p))
        .toList();

    await _db.batch((b) {
      b.insertAll(_db.permissionsTable, rows, mode: InsertMode.insertOrIgnore);
    });
  }

  Future<bool> checkPermissions(String host, List<String> permissions) async {
    final set = permissions
        .map(_normalizePerm)
        .where((p) => p.isNotEmpty)
        .toSet();

    if (set.isEmpty) return true;

    final t = _db.permissionsTable;
    final count = t.permission.count();

    try {
      final row =
          await (_db.selectOnly(t)
                ..addColumns([count])
                ..where(t.host.equals(host) & t.permission.isIn(set.toList())))
              .getSingleOrNull();

      return (row?.read(count) ?? 0) == set.length;
    } catch (e, s) {
      _log.severe('checkPermissions', e, s);
    }

    return false;
  }

  Future<int> clearAllPermissions() async {
    return _db.delete(_db.permissionsTable).go();
  }

  String _normalizePerm(String p) => p.trim().toLowerCase();
}
