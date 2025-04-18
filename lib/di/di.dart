import 'package:app/app/service/service.dart';
import 'package:app/di/di.config.dart';
import 'package:app/feature/update_version/domain/storage/update_version_storage_service.dart';
import 'package:app/http/http.dart';
import 'package:encrypted_storage/encrypted_storage.module.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
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
    http.Client,
  ],
)
Future<void> configureDi() async {
  const containers = [
    AppStorageService.container,
    ...GeneralStorageService.containers,
    ...BalanceStorageService.containers,
    ConnectionsStorageService.container,
    BrowserBookmarksStorageService.container,
    BrowserFaviconURLStorageService.container,
    BrowserHistoryStorageService.container,
    BrowserPermissionsStorageService.container,
    BrowserTabsStorageService.container,
    TonConnectStorageService.container,
    UpdateVersionStorageService.container,
  ];
  for (final container in containers) {
    getIt.registerSingleton(GetStorage(container), instanceName: container);
  }

  getIt.registerLazySingleton<http.Client>(
    ClientFactory.create,
    dispose: (client) => client.close(),
  );

  await getIt.init();
}

T inject<T extends Object>({
  String? instanceName,
}) =>
    getIt.get<T>(
      instanceName: instanceName,
    );
