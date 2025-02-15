import 'package:app/app/service/service.dart';
import 'package:app/feature/browserV2/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_favicon_url_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_history_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_permissions_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_tabs_storage_service.dart';
import 'package:injectable/injectable.dart';

/// Service that allows init or clear data of all storages from single point
@singleton
class StorageManagerService {
  StorageManagerService(
    SecureStorageService secure,
    GeneralStorageService general,
    BrowserTabsStorageService browserTabs,
    BrowserHistoryStorageService browserHistory,
    BrowserBookmarksStorageService browserBookmarks,
    BrowserPermissionsStorageService browserPermissions,
    BrowserFaviconURLStorageService browserFaviconURLs,
    NekotonStorageService accountSeed,
    NekotonRepositoryStorageService nekotonRepositoryStorageService,
    TonWalletStorageService tonWalletStorageService,
    TokenWalletStorageService tokenWalletStorageService,
    ConnectionsStorageService connectionStorageService,
    BalanceStorageService balanceStorageService,
    AppStorageService appStorageService,
  ) : _storages = [
          secure,
          general,
          browserTabs,
          browserHistory,
          browserBookmarks,
          browserPermissions,
          browserFaviconURLs,
          accountSeed,
          nekotonRepositoryStorageService,
          tonWalletStorageService,
          tokenWalletStorageService,
          connectionStorageService,
          balanceStorageService,
          appStorageService,
        ];

  final List<AbstractStorageService> _storages;

  /// Init all user-data.
  /// This let you call read methods to init stream data.
  Future<void> init() => Future.wait(_storages.map((e) => e.init()));

  /// Remove from storage all data that can be linked to user.
  Future<void> clearSensitiveData() =>
      Future.wait(_storages.map((e) => e.clearSensitiveData()));
}
