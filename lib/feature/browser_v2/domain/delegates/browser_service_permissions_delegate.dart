import 'package:app/data/models/permissions.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_base_delegate.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_permissions_storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class BrowserServicePermissions {
  ValueStream<Map<String, Permissions>> get permissionsStream;

  void setPermissions({
    required String origin,
    required Permissions permissions,
  });

  void setPagePermissions({
    required String origin,
    required List<String> resources,
  });

  void deletePermissionsForOrigin(String origin);

  void deletePermissionsForAccount(Address address);
}

@injectable
class BrowserServicePermissionsDelegate
    implements BrowserDelegate, BrowserServicePermissions {
  BrowserServicePermissionsDelegate(
    this._browserPermissionsStorageService,
  );

  final BrowserPermissionsStorageService _browserPermissionsStorageService;

  /// Subject for permissions of browser tabs
  final _permissionsSubject =
      BehaviorSubject<Map<String, Permissions>>.seeded({});

  /// Stream that allows tracking permissions changing
  @override
  ValueStream<Map<String, Permissions>> get permissionsStream =>
      _permissionsSubject;

  void init() {
    _fetchPermissions();
  }

  Future<void> clear() {
    return clearPermissions();
  }

  /// Set permission for specified url
  @override
  void setPermissions({
    required String origin,
    required Permissions permissions,
  }) {
    _browserPermissionsStorageService.setPermissions(
      origin: origin,
      permissions: permissions,
    );

    _fetchPermissions();
  }

  @override
  void setPagePermissions({
    required String origin,
    required List<String> resources,
  }) {
    _browserPermissionsStorageService.setPagePermission(
      origin: origin,
      resources: resources,
    );
  }

  @override
  void deletePermissionsForOrigin(String origin) {
    _browserPermissionsStorageService.deletePermissionsForOrigin(origin);
    _fetchPermissions();
  }

  /// Delete permissions for specified account
  @override
  void deletePermissionsForAccount(Address address) {
    final perms = permissionsStream.value;
    final origins = perms.entries
        .where((e) => e.value.accountInteraction?.address == address)
        .map((e) => e.key);

    for (final origin in origins) {
      final permissions = perms[origin]!.copyWith(accountInteraction: null);

      _browserPermissionsStorageService.setPermissions(
        origin: origin,
        permissions: permissions,
      );
    }

    _fetchPermissions();
  }

  /// Clear information about permissions
  Future<void> clearPermissions() async {
    await _browserPermissionsStorageService.clearPermissions();
    _permissionsSubject.add({});
  }

  void _fetchPermissions() => _permissionsSubject.add(
        _browserPermissionsStorageService.getPermissions(),
      );
}
