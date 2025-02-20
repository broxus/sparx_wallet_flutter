import 'dart:io';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:uuid/uuid.dart';

class BrowserManagerScreenshotHelper {
  BrowserManagerScreenshotHelper(
    this._generalStorageService,
  );

  final GeneralStorageService _generalStorageService;

  late final String? _defaultImagePath =
      _appDocsDir == null ? null : '$_appDocsDir/browser_default_tab_image.png';

  late final _appDocsDir = _generalStorageService.applicationDocumentsDirectory;

  late final _tabsDirectoryPath = () {
    try {
      final appDocsDir = _generalStorageService.applicationDocumentsDirectory;

      if (appDocsDir == null) {
        return null;
      }

      return '$appDocsDir/tabs';
    } catch (_) {
      return null;
    }
  }();

  String createImageId() => const Uuid().v4();

  String? getImagePath({
    required String tabId,
    String? imageId,
  }) {
    final path = getTabDirectoryPath(tabId);
    return path == null || imageId == null ? null : '$path/$imageId';
  }

  Future<void> clear() async {
    try {
      await Directory(_tabsDirectoryPath!).delete(recursive: true);
    } catch (_) {}
    try {
      await File(_defaultImagePath!).delete();
    } catch (_) {}
  }

  String? getTabDirectoryPath(String tabId) =>
      _tabsDirectoryPath == null ? null : '$_tabsDirectoryPath/$tabId';

  Future<void> removeScreenshot(String id) async {
    try {
      final dir = getTabDirectoryPath(id);
      if (dir == null) {
        return;
      }
      await Directory(dir).delete(recursive: true);
    } catch (_) {}
  }
}
