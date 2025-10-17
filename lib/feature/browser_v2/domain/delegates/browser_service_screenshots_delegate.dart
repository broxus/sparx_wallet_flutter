import 'dart:collection';
import 'dart:io';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/data/tabs/tabs_data.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_base_delegate.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract interface class BrowserServiceScreenshots {}

@injectable
class BrowserServiceScreenshotsDelegate
    implements BrowserDelegate, BrowserServiceScreenshots {
  BrowserServiceScreenshotsDelegate(this._generalStorageService);

  static const _screenshotPrefix = 'screenshot-';

  final GeneralStorageService _generalStorageService;
  final _screenshotsCache = ImageCache();

  late final String? _defaultImagePath = _appDocsDir == null
      ? null
      : '$_appDocsDir/browser_default_tab_image.png';

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

  ListenableState<Map<String, String>> get screenshotsState =>
      _screenshotsCache;

  void init(List<BrowserTab> tabs) {
    _fetchScreenshots(tabs);
  }

  void dispose() {
    _screenshotsCache.dispose();
  }

  Future<void> createScreenshot({
    required String tabId,
    required Future<Uint8List?> Function() takePictureCallback,
  }) async {
    try {
      final imageDirectoryPath = _getTabDirectoryPath(tabId);

      if (imageDirectoryPath == null) {
        return;
      }

      final image = await takePictureCallback();
      if (image == null) {
        return;
      }
      try {
        await Directory(imageDirectoryPath).delete(recursive: true);
      } catch (_) {}

      try {
        await Directory(imageDirectoryPath).create(recursive: true);
      } catch (_) {}

      final imagePath = _getImagePath(tabId);

      if (imagePath == null) {
        return;
      }

      // write file before accepting new state to ensure consistency
      final file = File(imagePath);
      await file.writeAsBytes(image);

      _screenshotsCache.add(tabId, imagePath);
    } catch (_) {}
  }

  Future<void> clear() async {
    try {
      await Directory(_tabsDirectoryPath!).delete(recursive: true);
    } catch (_) {}
    try {
      await File(_defaultImagePath!).delete();
    } catch (_) {}

    _screenshotsCache.clear();
  }

  Future<void> removeScreenshot(String id) async {
    try {
      final dir = _getTabDirectoryPath(id);
      if (dir == null) {
        return;
      }
      await Directory(dir).delete(recursive: true);
    } catch (_) {}

    _screenshotsCache.remove(id);
  }

  String? getScreenShotById(String id) => _screenshotsCache.get(id);

  Future<void> _fetchScreenshots(List<BrowserTab> tabs) async {
    final result = HashMap<String, String>();

    for (final tab in tabs) {
      try {
        final imageDirectoryPath = _getTabDirectoryPath(tab.id);
        if (imageDirectoryPath == null) {
          continue;
        }

        final path = _getTabDirectoryPath(tab.id);

        if (path == null) {
          continue;
        }

        final files = await Directory(path).list().toList();

        final imagePath = files
            .firstWhereOrNull(
              (entity) => entity.path.contains('/$_screenshotPrefix'),
            )
            ?.path;

        if (imagePath == null) {
          continue;
        }

        result[tab.id] = imagePath;
      } catch (_) {}
    }

    _screenshotsCache.addAll(result);
  }

  String? _getImagePath(String tabId) {
    final path = _getTabDirectoryPath(tabId);
    return path == null ? null : '$path/$_screenshotPrefix${const Uuid().v4()}';
  }

  String? _getTabDirectoryPath(String tabId) =>
      _tabsDirectoryPath == null ? null : '$_tabsDirectoryPath/$tabId';
}
