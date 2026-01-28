import 'package:app/app/service/storage_service/storage_adapter.dart';
import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:app/feature/browser/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageAdapter extends Mock implements StorageAdapter {}

class MockStorageBox extends Mock implements StorageBox {}

void main() {
  late MockStorageAdapter storageAdapter;
  late MockStorageBox storageBox;
  late BrowserTabsStorageService service;

  setUp(() {
    storageAdapter = MockStorageAdapter();
    storageBox = MockStorageBox();
    when(
      () => storageAdapter.box(BrowserTabsStorageService.container),
    ).thenReturn(storageBox);
    service = BrowserTabsStorageService(storageAdapter);
  });

  group('getActiveTabId', () {
    test('null if empty', () {
      when(
        () => storageBox.read<String>(browserTabsActiveTabIdKey),
      ).thenReturn(null);

      final result = service.getActiveTabId();

      expect(result, isNull);
      verify(
        () => storageBox.read<String>(browserTabsActiveTabIdKey),
      ).called(1);
      verifyNoMoreInteractions(storageBox);
    });

    test('Get saved id', () {
      when(
        () => storageBox.read<String>(browserTabsActiveTabIdKey),
      ).thenReturn('tab-1');

      final result = service.getActiveTabId();

      expect(result, 'tab-1');
      verify(
        () => storageBox.read<String>(browserTabsActiveTabIdKey),
      ).called(1);
      verifyNoMoreInteractions(storageBox);
    });
  });

  group('getTabs', () {
    test('Empty list if null in storage', () {
      when(
        () => storageBox.read<List<dynamic>>(
          BrowserTabsStorageService.browserTabsKey,
        ),
      ).thenReturn(null);

      final result = service.getTabs();

      expect(result, isEmpty);
      verify(
        () => storageBox.read<List<dynamic>>(
          BrowserTabsStorageService.browserTabsKey,
        ),
      ).called(1);
      verifyNoMoreInteractions(storageBox);
    });

    test('Empty list if empty list in storage', () {
      when(
        () => storageBox.read<List<dynamic>>(
          BrowserTabsStorageService.browserTabsKey,
        ),
      ).thenReturn(<dynamic>[]);

      final result = service.getTabs();

      expect(result, isEmpty);
      verify(
        () => storageBox.read<List<dynamic>>(
          BrowserTabsStorageService.browserTabsKey,
        ),
      ).called(1);
      verifyNoMoreInteractions(storageBox);
    });

    test('json list map to BrowserTab list', () {
      when(
        () => storageBox.read<List<dynamic>>(
          BrowserTabsStorageService.browserTabsKey,
        ),
      ).thenReturn(<dynamic>[
        {
          'id': 'tab-1',
          'title': 'Tab 1',
          'url': 'https://example.com',
          'sortingOrder': 1,
        },
        {
          'id': 'tab-2',
          'title': 'Tab 2',
          'url': 'https://example.org',
          'sortingOrder': 2,
        },
      ]);

      final result = service.getTabs();

      expect(result, hasLength(2));
      expect(result[0], isA<BrowserTab>());
      expect(result[1], isA<BrowserTab>());
      verify(
        () => storageBox.read<List<dynamic>>(
          BrowserTabsStorageService.browserTabsKey,
        ),
      ).called(1);
      verifyNoMoreInteractions(storageBox);
    });
  });

  group('saveBrowserActiveTabId', () {
    test('Save active tab id in storage', () {
      when(
        () => storageBox.write(browserTabsActiveTabIdKey, any<dynamic>()),
      ).thenAnswer((_) async {});

      service.saveBrowserActiveTabId('tab-42');

      verify(
        () => storageBox.write(browserTabsActiveTabIdKey, 'tab-42'),
      ).called(1);
      verifyNoMoreInteractions(storageBox);
    });

    test('Save null', () {
      when(
        () => storageBox.write(browserTabsActiveTabIdKey, any<dynamic>()),
      ).thenAnswer((_) async {});

      service.saveBrowserActiveTabId(null);

      verify(() => storageBox.write(browserTabsActiveTabIdKey, null)).called(1);
      verifyNoMoreInteractions(storageBox);
    });
  });

  group('saveBrowserTabs', () {
    test('Save empty list', () {
      when(
        () => storageBox.write(
          BrowserTabsStorageService.browserTabsKey,
          any<dynamic>(),
        ),
      ).thenAnswer((_) async {});

      final tabs = <BrowserTab>[];

      service.saveBrowserTabs(tabs);

      verify(
        () => storageBox.write(
          BrowserTabsStorageService.browserTabsKey,
          <dynamic>[],
        ),
      ).called(1);
      verifyNoMoreInteractions(storageBox);
    });

    test('Save json list', () {
      when(
        () => storageBox.write(
          BrowserTabsStorageService.browserTabsKey,
          any<dynamic>(),
        ),
      ).thenAnswer((_) async {});

      final tab1 = BrowserTab(
        id: 'tab-1',
        title: 'Tab 1',
        url: Uri.parse('https://example.com'),
        sortingOrder: 1,
      );
      final tab2 = BrowserTab(
        id: 'tab-2',
        title: 'Tab 2',
        url: Uri.parse('https://example.org'),
        sortingOrder: 2,
      );

      service.saveBrowserTabs([tab1, tab2]);

      final expectedList = [tab1.toJson(), tab2.toJson()];

      verify(
        () => storageBox.write(
          BrowserTabsStorageService.browserTabsKey,
          expectedList,
        ),
      ).called(1);
      verifyNoMoreInteractions(storageBox);
    });
  });
}
