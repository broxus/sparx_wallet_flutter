import 'package:app/app/service/storage_service/abstract_storage_service.dart';
import 'package:app/app/service/storage_service/account_seed_storage_service.dart';
import 'package:app/app/service/storage_service/app_storage_service.dart';
import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/nekoton_repository_service.dart';
import 'package:app/app/service/storage_service/secure_storage_service.dart';
import 'package:app/app/service/storage_service/storage_manager_service.dart';
import 'package:app/app/service/storage_service/token_wallet_storage_service/token_wallet_storage_service.dart';
import 'package:app/app/service/storage_service/ton_connect_storage_service.dart';
import 'package:app/app/service/storage_service/ton_wallet_storage_service/ton_wallet_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_favicon_url_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_groups_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_permissions_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:app/feature/ledger/domain/ledger_storage_service.dart';
import 'package:app/feature/nft/domain/nft_storage_service.dart';
import 'package:app/feature/update_version/domain/storage/update_version_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSecureStorageService extends Mock implements SecureStorageService {}

class _MockGeneralStorageService extends Mock
    implements GeneralStorageService {}

class _MockBrowserGroupsStorageService extends Mock
    implements BrowserGroupsStorageService {}

class _MockBrowserTabsStorageService extends Mock
    implements BrowserTabsStorageService {}

class _MockBrowserBookmarksStorageService extends Mock
    implements BrowserBookmarksStorageService {}

class _MockBrowserPermissionsStorageService extends Mock
    implements BrowserPermissionsStorageService {}

class _MockBrowserFaviconURLStorageService extends Mock
    implements BrowserFaviconURLStorageService {}

class _MockNekotonStorageService extends Mock
    implements NekotonStorageService {}

class _MockNekotonRepositoryStorageService extends Mock
    implements NekotonRepositoryStorageService {}

class _MockTonWalletStorageService extends Mock
    implements TonWalletStorageService {}

class _MockTokenWalletStorageService extends Mock
    implements TokenWalletStorageService {}

class _MockConnectionsStorageService extends Mock
    implements ConnectionsStorageService {}

class _MockBalanceStorageService extends Mock
    implements BalanceStorageService {}

class _MockAppStorageService extends Mock implements AppStorageService {}

class _MockTonConnectStorageService extends Mock
    implements TonConnectStorageService {}

class _MockUpdateVersionStorageService extends Mock
    implements UpdateVersionStorageService {}

class _MockNftStorageService extends Mock implements NftStorageService {}

class _MockLedgerStorageService extends Mock implements LedgerStorageService {}

void main() {
  group('StorageManagerService', () {
    late _MockSecureStorageService secureStorageService;
    late _MockGeneralStorageService generalStorageService;
    late _MockBrowserGroupsStorageService browserGroupsStorageService;
    late _MockBrowserTabsStorageService browserTabsStorageService;
    late _MockBrowserBookmarksStorageService browserBookmarksStorageService;
    late _MockBrowserPermissionsStorageService browserPermissionsStorageService;
    late _MockBrowserFaviconURLStorageService browserFaviconUrlStorageService;
    late _MockNekotonStorageService nekotonStorageService;
    late _MockNekotonRepositoryStorageService nekotonRepositoryStorageService;
    late _MockTonWalletStorageService tonWalletStorageService;
    late _MockTokenWalletStorageService tokenWalletStorageService;
    late _MockConnectionsStorageService connectionsStorageService;
    late _MockBalanceStorageService balanceStorageService;
    late _MockAppStorageService appStorageService;
    late _MockTonConnectStorageService tonConnectStorageService;
    late _MockUpdateVersionStorageService updateVersionStorageService;
    late _MockNftStorageService nftStorageService;
    late _MockLedgerStorageService ledgerStorageService;
    late List<AbstractStorageService> storages;
    late StorageManagerService service;

    setUp(() {
      secureStorageService = _MockSecureStorageService();
      generalStorageService = _MockGeneralStorageService();
      browserGroupsStorageService = _MockBrowserGroupsStorageService();
      browserTabsStorageService = _MockBrowserTabsStorageService();
      browserBookmarksStorageService = _MockBrowserBookmarksStorageService();
      browserPermissionsStorageService =
          _MockBrowserPermissionsStorageService();
      browserFaviconUrlStorageService = _MockBrowserFaviconURLStorageService();
      nekotonStorageService = _MockNekotonStorageService();
      nekotonRepositoryStorageService = _MockNekotonRepositoryStorageService();
      tonWalletStorageService = _MockTonWalletStorageService();
      tokenWalletStorageService = _MockTokenWalletStorageService();
      connectionsStorageService = _MockConnectionsStorageService();
      balanceStorageService = _MockBalanceStorageService();
      appStorageService = _MockAppStorageService();
      tonConnectStorageService = _MockTonConnectStorageService();
      updateVersionStorageService = _MockUpdateVersionStorageService();
      nftStorageService = _MockNftStorageService();
      ledgerStorageService = _MockLedgerStorageService();

      storages = [
        secureStorageService,
        generalStorageService,
        browserGroupsStorageService,
        browserTabsStorageService,
        browserBookmarksStorageService,
        browserPermissionsStorageService,
        browserFaviconUrlStorageService,
        nekotonStorageService,
        nekotonRepositoryStorageService,
        tonWalletStorageService,
        tokenWalletStorageService,
        connectionsStorageService,
        balanceStorageService,
        appStorageService,
        tonConnectStorageService,
        updateVersionStorageService,
        nftStorageService,
        ledgerStorageService,
      ];

      for (final storage in storages) {
        when(storage.init).thenAnswer((_) async {});
        when(storage.clear).thenAnswer((_) async {});
      }

      service = StorageManagerService(
        secureStorageService,
        generalStorageService,
        browserGroupsStorageService,
        browserTabsStorageService,
        browserBookmarksStorageService,
        browserPermissionsStorageService,
        browserFaviconUrlStorageService,
        nekotonStorageService,
        nekotonRepositoryStorageService,
        tonWalletStorageService,
        tokenWalletStorageService,
        connectionsStorageService,
        balanceStorageService,
        appStorageService,
        tonConnectStorageService,
        updateVersionStorageService,
        nftStorageService,
        ledgerStorageService,
      );
    });

    test('init calls init on all storages', () async {
      await service.init();

      for (final storage in storages) {
        verify(storage.init).called(1);
      }
    });

    test('clear calls clear on all storages', () async {
      await service.clear();

      for (final storage in storages) {
        verify(storage.clear).called(1);
      }
    });
  });
}
