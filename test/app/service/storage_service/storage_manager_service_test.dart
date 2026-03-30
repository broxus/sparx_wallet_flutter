import 'package:app/app/service/storage_service/account_seed_storage_service.dart';
import 'package:app/app/service/storage_service/app_storage_service.dart';
import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/nekoton_repository_service.dart';
import 'package:app/app/service/storage_service/secure_storage_service.dart';
import 'package:app/app/service/storage_service/storage_manager_service.dart';
import 'package:app/app/service/storage_service/ton_connect_storage_service.dart';
import 'package:app/app/service/storage_service/token_wallet_storage_service/token_wallet_storage_service.dart';
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
    late List<dynamic> storages;
    late StorageManagerService service;

    setUp(() {
      storages = [
        _MockSecureStorageService(),
        _MockGeneralStorageService(),
        _MockBrowserGroupsStorageService(),
        _MockBrowserTabsStorageService(),
        _MockBrowserBookmarksStorageService(),
        _MockBrowserPermissionsStorageService(),
        _MockBrowserFaviconURLStorageService(),
        _MockNekotonStorageService(),
        _MockNekotonRepositoryStorageService(),
        _MockTonWalletStorageService(),
        _MockTokenWalletStorageService(),
        _MockConnectionsStorageService(),
        _MockBalanceStorageService(),
        _MockAppStorageService(),
        _MockTonConnectStorageService(),
        _MockUpdateVersionStorageService(),
        _MockNftStorageService(),
        _MockLedgerStorageService(),
      ];

      for (final storage in storages) {
        when(() => storage.init()).thenAnswer((_) async {});
        when(() => storage.clear()).thenAnswer((_) async {});
      }

      service = StorageManagerService(
        storages[0] as SecureStorageService,
        storages[1] as GeneralStorageService,
        storages[2] as BrowserGroupsStorageService,
        storages[3] as BrowserTabsStorageService,
        storages[4] as BrowserBookmarksStorageService,
        storages[5] as BrowserPermissionsStorageService,
        storages[6] as BrowserFaviconURLStorageService,
        storages[7] as NekotonStorageService,
        storages[8] as NekotonRepositoryStorageService,
        storages[9] as TonWalletStorageService,
        storages[10] as TokenWalletStorageService,
        storages[11] as ConnectionsStorageService,
        storages[12] as BalanceStorageService,
        storages[13] as AppStorageService,
        storages[14] as TonConnectStorageService,
        storages[15] as UpdateVersionStorageService,
        storages[16] as NftStorageService,
        storages[17] as LedgerStorageService,
      );
    });

    test('init calls init on all storages', () async {
      await service.init();

      for (final storage in storages) {
        verify(() => storage.init()).called(1);
      }
    });

    test('clear calls clear on all storages', () async {
      await service.clear();

      for (final storage in storages) {
        verify(() => storage.clear()).called(1);
      }
    });
  });
}
