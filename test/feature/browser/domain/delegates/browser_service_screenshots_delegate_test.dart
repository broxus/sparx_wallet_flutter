import 'dart:io';
import 'dart:typed_data';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_screenshots_delegate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGeneralStorageService extends Mock implements GeneralStorageService {}

void main() {
  late Directory tempDir;
  late MockGeneralStorageService storage;
  late BrowserServiceScreenshotsDelegate delegate;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('screenshots_test_');
    storage = MockGeneralStorageService();
    when(() => storage.applicationDocumentsDirectory).thenReturn(tempDir.path);

    delegate = BrowserServiceScreenshotsDelegate(storage);
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('init', () {
    test('Read tabs', () async {
      const tabId1 = 'tab-1';
      const tabId2 = 'tab-2';

      final tab1 = BrowserTab(
        id: tabId1,
        url: Uri.parse('https://one.com'),
        title: 'One',
        sortingOrder: 0,
      );
      final tab2 = BrowserTab(
        id: tabId2,
        url: Uri.parse('https://two.com'),
        title: 'Two',
        sortingOrder: 1,
      );

      final tab1Dir = Directory('${tempDir.path}/tabs/$tabId1');
      await tab1Dir.create(recursive: true);
      final screenshot1 = File('${tab1Dir.path}/screenshot-abc.png');
      await screenshot1.writeAsBytes([1, 2, 3]);

      final tab2Dir = Directory('${tempDir.path}/tabs/$tabId2');
      await tab2Dir.create(recursive: true);

      final otherFile = File('${tab2Dir.path}/image.png');
      await otherFile.writeAsBytes([4, 5, 6]);

      delegate.init([tab1, tab2]);

      await Future<void>.delayed(const Duration(milliseconds: 20));

      expect(delegate.getScreenShotById(tabId1), screenshot1.path);
      expect(delegate.getScreenShotById(tabId2), isNull);
    });
  });

  group('screenshot', () {
    test('create screenshot', () async {
      const tabId = 'tab-1';
      final bytes = Uint8List.fromList([1, 2, 3, 4]);

      await delegate.createScreenshot(
        tabId: tabId,
        takePictureCallback: () async => bytes,
      );

      final path = delegate.getScreenShotById(tabId);
      expect(path, isNotNull);

      final file = File(path!);
      expect(file.existsSync(), isTrue);
      expect(file.readAsBytesSync(), bytes);
    });

    test('Update screenshot', () async {
      const tabId = 'tab-1';
      final firstBytes = Uint8List.fromList([1, 2, 3]);
      final secondBytes = Uint8List.fromList([4, 5, 6, 7]);

      await delegate.createScreenshot(
        tabId: tabId,
        takePictureCallback: () async => firstBytes,
      );
      final firstPath = delegate.getScreenShotById(tabId)!;
      final firstFile = File(firstPath);
      expect(firstFile.existsSync(), isTrue);

      await delegate.createScreenshot(
        tabId: tabId,
        takePictureCallback: () async => secondBytes,
      );
      final secondPath = delegate.getScreenShotById(tabId)!;
      final secondFile = File(secondPath);

      expect(secondPath, isNot(firstPath));
      expect(firstFile.existsSync(), isFalse);
      expect(secondFile.existsSync(), isTrue);
      expect(secondFile.readAsBytesSync(), secondBytes);
    });

    test('applicationDocumentsDirectory is null', () async {
      final storageNull = MockGeneralStorageService();
      when(() => storageNull.applicationDocumentsDirectory).thenReturn(null);

      final delegateNull = BrowserServiceScreenshotsDelegate(storageNull);

      var callbackCalled = false;

      await delegateNull.createScreenshot(
        tabId: 'tab-1',
        takePictureCallback: () async {
          callbackCalled = true;
          return Uint8List.fromList([1]);
        },
      );

      expect(callbackCalled, isFalse);
      expect(delegateNull.getScreenShotById('tab-1'), isNull);
    });

    test('takePictureCallback return null', () async {
      const tabId = 'tab-1';

      await delegate.createScreenshot(
        tabId: tabId,
        takePictureCallback: () async => null,
      );

      expect(delegate.getScreenShotById(tabId), isNull);
    });
  });

  group('Remove', () {
    test('removeScreenshot', () async {
      const tabId = 'tab-remove';
      final bytes = Uint8List.fromList([1, 2, 3]);

      await delegate.createScreenshot(
        tabId: tabId,
        takePictureCallback: () async => bytes,
      );

      final path = delegate.getScreenShotById(tabId)!;
      final dirPath = '${tempDir.path}/tabs/$tabId';

      expect(Directory(dirPath).existsSync(), isTrue);
      expect(File(path).existsSync(), isTrue);

      await delegate.removeScreenshot(tabId);

      expect(delegate.getScreenShotById(tabId), isNull);
      expect(Directory(dirPath).existsSync(), isFalse);
    });

    test('clear', () async {
      const tabId = 'tab-1';
      final bytes = Uint8List.fromList([1, 2, 3]);

      await delegate.createScreenshot(
        tabId: tabId,
        takePictureCallback: () async => bytes,
      );
      final tabsDir = Directory('${tempDir.path}/tabs');
      expect(tabsDir.existsSync(), isTrue);

      final defaultImageFile = File(
        '${tempDir.path}/browser_default_tab_image.png',
      );
      await defaultImageFile.writeAsBytes([9, 9, 9]);
      expect(defaultImageFile.existsSync(), isTrue);

      await delegate.clear();

      expect(delegate.getScreenShotById(tabId), isNull);

      expect(tabsDir.existsSync(), isFalse);

      expect(defaultImageFile.existsSync(), isFalse);
    });
  });

  group('getScreenShotById', () {
    test('getScreenShotById if not exist', () {
      expect(delegate.getScreenShotById('unknown'), isNull);
    });

    test('getScreenShotById if exist', () async {
      const tabId = 'tab-1';
      final bytes = Uint8List.fromList([1, 2, 3]);

      await delegate.createScreenshot(
        tabId: tabId,
        takePictureCallback: () async => bytes,
      );

      final path = delegate.getScreenShotById(tabId);
      expect(path, isNotNull);
      expect(File(path!).existsSync(), isTrue);
    });
  });
}
