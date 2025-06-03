import 'package:app/app/service/app_version_service.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoreUrlGenerator {
  StoreUrlGenerator(
    this._appVersionService,
  );

  final AppVersionService _appVersionService;

  Future<String> storeUrl() async {
    final packageName = await _appVersionService.packageName();

    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS =>
        'https://apps.apple.com/us/app/sparx-tvm-wallet/id6670219321',
      _ => 'https://play.google.com/store/apps/details?id=$packageName',
    };
  }
}
