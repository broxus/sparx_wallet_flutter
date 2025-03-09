import 'dart:io';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class BrowserManagerScreenshotHelper {
  BrowserManagerScreenshotHelper(
    this._generalStorageService,
  );

  /// Subject of browser tabs
  final _screenshotsState = StateNotifier<ImageCache>(initValue: ImageCache());

  ListenableState<ImageCache?> get screenshotsState => _screenshotsState;

  ImageCache get _screenshotsCache => _screenshotsState.value ?? ImageCache();

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

  void dispose() {
    _screenshotsState.dispose();
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

      final imagePath = _getImagePath(
        tabId: tabId,
        imageId: const Uuid().v4(),
      );

      if (imagePath == null) {
        return;
      }

      _screenshotsCache.add(tabId, imagePath);
      _screenshotsState.accept(_screenshotsCache.copy());

      final file = File(imagePath);
      await file.writeAsBytes(image);
    } catch (_) {}
  }

  Future<void> clear() async {
    try {
      await Directory(_tabsDirectoryPath!).delete(recursive: true);
    } catch (_) {}
    try {
      await File(_defaultImagePath!).delete();
    } catch (_) {}
  }

  Future<void> removeScreenshot(String id) async {
    try {
      final dir = _getTabDirectoryPath(id);
      if (dir == null) {
        return;
      }
      await Directory(dir).delete(recursive: true);
    } catch (_) {}
  }

  String? _getImagePath({
    required String tabId,
    String? imageId,
  }) {
    final path = _getTabDirectoryPath(tabId);
    return path == null || imageId == null ? null : '$path/$imageId';
  }

  String? _getTabDirectoryPath(String tabId) =>
      _tabsDirectoryPath == null ? null : '$_tabsDirectoryPath/$tabId';
}
