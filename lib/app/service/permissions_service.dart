import 'package:app/data/models/models.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Service that allows listening for browser permissions and update it.
@singleton
class PermissionsService {
  PermissionsService(this._browserService, this._nekotonRepository);

  final BrowserService _browserService;

  final NekotonRepository _nekotonRepository;

  void init() {
    _listenAccountsDeletion();
  }

  /// Stream that allows tracking permissions changing
  Stream<Map<Uri, Permissions>> get permissionsStream =>
      _browserService.perm.permissionsStream.map(
        (event) => event.map((key, value) => MapEntry(Uri.parse(key), value)),
      );

  /// Get last existed permissions for browser.
  /// key - origin of url, value - permissions
  ///
  /// If you are not sure, that your key is true origin, use [getPermissions].
  Map<Uri, Permissions> get permissions => _browserService
      .perm
      .permissionsStream
      .value
      .map((key, value) => MapEntry(Uri.parse(key), value));

  /// Get permission, specified by [url].
  /// It's better to use this getter except of [permissions] to avoid errors,
  /// related to taking only origin from url.
  Permissions? getPermissions(Uri? url) =>
      url == null ? null : permissions[Uri.parse(url.origin)];

  /// Set permissions for browser tab with [url]
  void setPermissions({required Uri url, required Permissions permissions}) =>
      _browserService.perm.setPermissions(
        origin: url.origin,
        permissions: permissions,
      );

  /// Delete permissions for browser tab with [url]
  void deletePermissionsForOrigin(Uri url) =>
      _browserService.perm.deletePermissionsForOrigin(url.origin);

  /// Delete permissions for specified account
  void deletePermissionsForAccount(Address address) =>
      _browserService.perm.deletePermissionsForAccount(address);

  // we do not save stream sub, because it must stay all app life-time
  void _listenAccountsDeletion() {
    _nekotonRepository.seedChangesStream.listen((changes) {
      for (final account in changes.deletedAccounts) {
        deletePermissionsForAccount(account.address);
      }
    });
  }
}
