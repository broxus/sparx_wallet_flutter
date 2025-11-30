import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:app/feature/browser/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockGetStorage extends Mock implements GetStorage {}

void main() {
  late MockGetStorage storage;
  late BrowserTabsStorageService service;

  setUp(() {
    storage = MockGetStorage();
    service = BrowserTabsStorageService(storage);
  });

  group('getActiveTabId', () {
    test('null if empty', () {
      when(
        () => storage.read<String>(browserTabsActiveTabIdKey),
      ).thenReturn(null);

      final result = service.getActiveTabId();

      expect(result, isNull);
      verify(() => storage.read<String>(browserTabsActiveTabIdKey)).called(1);
      verifyNoMoreInteractions(storage);
    });

    test('Get saved id', () {
      when(
        () => storage.read<String>(browserTabsActiveTabIdKey),
      ).thenReturn('tab-1');

      final result = service.getActiveTabId();

      expect(result, 'tab-1');
      verify(() => storage.read<String>(browserTabsActiveTabIdKey)).called(1);
      verifyNoMoreInteractions(storage);
    });
  });

  group('getTabs', () {
    test('Empty list if null in storage', () {
      when(
        () => storage.read<List<dynamic>>(
          BrowserTabsStorageService.browserTabsKey,
        ),
      ).thenReturn(null);

      final result = service.getTabs();

      expect(result, isEmpty);
      verify(
        () => storage.read<List<dynamic>>(
          BrowserTabsStorageService.browserTabsKey,
        ),
      ).called(1);
      verifyNoMoreInteractions(storage);
    });

    test('Empty list if empty list in storage', () {
      when(
        () => storage.read<List<dynamic>>(
          BrowserTabsStorageService.browserTabsKey,
        ),
      ).thenReturn(<dynamic>[]);

      final result = service.getTabs();

      expect(result, isEmpty);
      verify(
        () => storage.read<List<dynamic>>(
          BrowserTabsStorageService.browserTabsKey,
        ),
      ).called(1);
      verifyNoMoreInteractions(storage);
    });

    test('json list map to BrowserTab list', () {
      when(
        () => storage.read<List<dynamic>>(
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
        () => storage.read<List<dynamic>>(
          BrowserTabsStorageService.browserTabsKey,
        ),
      ).called(1);
      verifyNoMoreInteractions(storage);
    });
  });

  group('saveBrowserActiveTabId', () {
    test('Save active tab id in storage', () {
      when(
        () => storage.write(browserTabsActiveTabIdKey, any<dynamic>()),
      ).thenAnswer((_) async {});

      service.saveBrowserActiveTabId('tab-42');

      verify(
        () => storage.write(browserTabsActiveTabIdKey, 'tab-42'),
      ).called(1);
      verifyNoMoreInteractions(storage);
    });

    test('Save null', () {
      when(
        () => storage.write(browserTabsActiveTabIdKey, any<dynamic>()),
      ).thenAnswer((_) async {});

      service.saveBrowserActiveTabId(null);

      verify(() => storage.write(browserTabsActiveTabIdKey, null)).called(1);
      verifyNoMoreInteractions(storage);
    });
  });

  group('saveBrowserTabs', () {
    test('Save empty list', () {
      when(
        () => storage.write(
          BrowserTabsStorageService.browserTabsKey,
          any<dynamic>(),
        ),
      ).thenAnswer((_) async {});

      final tabs = <BrowserTab>[];

      service.saveBrowserTabs(tabs);

      verify(
        () => storage.write(
          BrowserTabsStorageService.browserTabsKey,
          <dynamic>[],
        ),
      ).called(1);
      verifyNoMoreInteractions(storage);
    });

    test('Save json list', () {
      when(
        () => storage.write(
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
        () => storage.write(
          BrowserTabsStorageService.browserTabsKey,
          expectedList,
        ),
      ).called(1);
      verifyNoMoreInteractions(storage);
    });
  });
}
