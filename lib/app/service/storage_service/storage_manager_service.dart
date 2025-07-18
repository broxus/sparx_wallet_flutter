import 'package:app/app/service/service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_favicon_url_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_groups_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_history_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_permissions_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/update_version/domain/storage/update_version_storage_service.dart';
import 'package:injectable/injectable.dart';

/// Service that allows init or clear data of all storages from single point
@singleton
class StorageManagerService {
  StorageManagerService(
    SecureStorageService secure,
    GeneralStorageService general,
    BrowserGroupsStorageService browserGroups,
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
    TonConnectStorageService tonConnectStorageService,
    UpdateVersionStorageService updateVersionStorageService,
    NftStorageService nftStorageService,
  ) : _storages = [
          secure,
          general,
          browserGroups,
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
          tonConnectStorageService,
          updateVersionStorageService,
          nftStorageService,
        ];

  final List<AbstractStorageService> _storages;

  /// Init all user-data.
  /// This let you call read methods to init stream data.
  Future<void> init() => Future.wait(_storages.map((e) => e.init()));

  /// Remove from storage all data that can be linked to user.
  Future<void> clear() => Future.wait(_storages.map((e) => e.clear()));
}
