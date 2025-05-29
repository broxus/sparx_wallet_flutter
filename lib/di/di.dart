import 'package:app/app/service/service.dart';
import 'package:app/di/di.config.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_favicon_url_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_groups_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_history_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_permissions_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:app/feature/update_version/domain/storage/update_version_storage_service.dart';
import 'package:encrypted_storage/encrypted_storage.module.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.module.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
  generateForDir: ['lib'],
  externalPackageModulesBefore: [
    ExternalModule(EncryptedStoragePackageModule),
    ExternalModule(NekotonRepositoryPackageModule),
  ],
  ignoreUnregisteredTypes: [
    GetStorage,
  ],
)
Future<void> configureDi() async {
  getIt.enableRegisteringMultipleInstancesOfOneType();

  const containers = [
    AppStorageService.container,
    ...GeneralStorageService.containers,
    ...BalanceStorageService.containers,
    ConnectionsStorageService.container,
    BrowserBookmarksStorageService.container,
    BrowserFaviconURLStorageService.container,
    BrowserHistoryStorageService.container,
    BrowserPermissionsStorageService.container,
    BrowserGroupsStorageService.container,
    BrowserTabsStorageService.container,
    TonConnectStorageService.container,
    UpdateVersionStorageService.container,
  ];
  for (final container in containers) {
    getIt.registerSingleton(GetStorage(container), instanceName: container);
  }

  await getIt.init();
}

T inject<T extends Object>({
  dynamic param1,
  dynamic param2,
  String? instanceName,
  Type? type,
}) {
  return getIt.get<T>(
    param1: param1,
    param2: param2,
    instanceName: instanceName,
    type: type,
  );
}
