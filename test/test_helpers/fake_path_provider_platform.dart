import 'dart:io';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class FakePathProviderPlatform extends PathProviderPlatform {
  FakePathProviderPlatform(this._appDocsDir);

  final Directory _appDocsDir;

  @override
  Future<String?> getApplicationDocumentsPath() async => _appDocsDir.path;
}
