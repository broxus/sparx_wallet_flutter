// ignore_for_file: avoid_redundant_argument_values

import 'package:app/core/app_build_type.dart';
import 'package:app/di/di.config.dart';
import 'package:encrypted_storage/encrypted_storage.module.dart';
import 'package:get_it/get_it.dart';
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
  ignoreUnregisteredTypes: [AppBuildType],
)
Future<void> configureDi({required AppBuildType appBuildType}) async {
  getIt
    ..enableRegisteringMultipleInstancesOfOneType()
    ..registerSingleton(appBuildType);

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
