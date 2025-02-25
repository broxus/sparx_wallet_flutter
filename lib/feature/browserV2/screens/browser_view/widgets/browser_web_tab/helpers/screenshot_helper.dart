import 'dart:io';

import 'package:app/feature/browserV2/managers/tabs/tabs_manager.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ScreenshotHelper {
  ScreenshotHelper(this._tabsM);

  final BrowserTabsManager _tabsM;

  final ScreenshotConfiguration _screenshotConfiguration =
      ScreenshotConfiguration(
    compressFormat: CompressFormat.JPEG,
    quality: 70,
    snapshotWidth: 160,
  );

  Future<void> createScreenshot({
    required InAppWebViewController webViewController,
    required String tabId,
    bool force = false,
  }) async {
    try {

      final imageDirectoryPath = _tabsM.getTabDirectoryPath(tabId);

      if (imageDirectoryPath == null) {
        return;
      }

      final image = await webViewController.takeScreenshot(
        screenshotConfiguration: _screenshotConfiguration,
      );
      if (image == null) {
        return;
      }

      try {
        await Directory(imageDirectoryPath).delete(recursive: true);
      } catch (_) {}

      try {
        await Directory(imageDirectoryPath).create(recursive: true);
      } catch (_) {}

      final imagePath = _tabsM.getImagePath(
        tabId: tabId,
        imageId: _tabsM.createImageId(),
      );

      if (imagePath == null) {
        return;
      }

      final file = File(imagePath);
      await file.writeAsBytes(image);
    } catch (_) {}
  }
}
