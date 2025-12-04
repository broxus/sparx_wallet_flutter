import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:app/feature/browser/domain/delegates/browser_anti_phishing_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_auth_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_bookmarks_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_favicon_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_history_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_permissions_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_tabs_delegate.dart';
import 'package:app/feature/browser/domain/service/browser_service.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class MockTonConnectService extends Mock implements TonConnectService {}

class MockNekotonRepository extends Mock implements NekotonRepository {}

class MockAuthDelegate extends Mock implements BrowserServiceAuthDelegate {}

class MockBookmarksDelegate extends Mock
    implements BrowserServiceBookmarksDelegate {}

class MockFaviconDelegate extends Mock
    implements BrowserServiceFaviconDelegate {}

class MockHistoryDelegate extends Mock
    implements BrowserServiceHistoryDelegate {}

class MockPermissionsDelegate extends Mock
    implements BrowserServicePermissionsDelegate {}

class MockTabsDelegate extends Mock implements BrowserServiceTabsDelegate {}

class MockAntiPhishingDelegate extends Mock
    implements BrowserAntiPhishingDelegate {}

void main() {
  late MockBookmarksDelegate bookmarksDelegate;
  late MockHistoryDelegate historyDelegate;
  late MockTabsDelegate tabsDelegate;
  late MockAntiPhishingDelegate antiPhishingDelegate;

  late BrowserService browserService;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://fallback.test'));
  });

  setUp(() {
    bookmarksDelegate = MockBookmarksDelegate();
    historyDelegate = MockHistoryDelegate();
    tabsDelegate = MockTabsDelegate();
    antiPhishingDelegate = MockAntiPhishingDelegate();

    browserService = BrowserService(
      MockTonConnectService(),
      MockNekotonRepository(),
      MockAuthDelegate(),
      bookmarksDelegate,
      MockFaviconDelegate(),
      historyDelegate,
      MockPermissionsDelegate(),
      tabsDelegate,
      antiPhishingDelegate,
    );
  });

  group('createTabBookMark', () {
    test('ничего не делает, если вкладка не найдена', () {
      when(() => tabsDelegate.getTabById('tab-1')).thenReturn(null);

      browserService.createTabBookMark('tab-1');

      verify(() => tabsDelegate.getTabById('tab-1')).called(1);
      verifyNever(
        () => bookmarksDelegate.createBrowserBookmark(any<Uri>(), any()),
      );
    });

    test('Empty host', () {
      final tab = BrowserTab(
        id: '0',
        url: Uri.parse('https:///'),
        title: 'Title',
        sortingOrder: 1,
      );
      when(() => tabsDelegate.getTabById('tab-1')).thenReturn(tab);

      browserService.createTabBookMark('tab-1');

      verify(() => tabsDelegate.getTabById('tab-1')).called(1);
      verifyNever(
        () => bookmarksDelegate.createBrowserBookmark(any<Uri>(), any()),
      );
    });

    test('Crete tab if valid data', () {
      final uri = Uri.parse('https://example.com');
      const title = 'My tab';

      final tab = BrowserTab(id: '0', url: uri, title: title, sortingOrder: 1);
      when(() => tabsDelegate.getTabById('tab-1')).thenReturn(tab);

      browserService.createTabBookMark('tab-1');

      verify(() => tabsDelegate.getTabById('tab-1')).called(1);
      verify(
        () => bookmarksDelegate.createBrowserBookmark(uri, title),
      ).called(1);
    });
  });

  group('loadPhishingGuard', () {
    test('Load html with antiPhishingDelegate', () async {
      final uri = Uri.parse('https://phishing.test');
      const html = '<html>guard</html>';

      when(
        () => antiPhishingDelegate.getPhishingGuardHtml(uri),
      ).thenAnswer((_) async => html);
      when(() => tabsDelegate.loadData('tab-1', html)).thenAnswer((_) async {});

      await browserService.loadPhishingGuard('tab-1', uri);

      verify(() => antiPhishingDelegate.getPhishingGuardHtml(uri)).called(1);
      verify(() => tabsDelegate.loadData('tab-1', html)).called(1);
    });
  });

  group('requestUrlSafe', () {
    test('Tib id null', () async {
      await browserService.requestUrlSafe(null, 'https://example.com');

      verifyNever(() => tabsDelegate.requestUrl(any(), any<Uri>()));
      verifyNever(() => antiPhishingDelegate.checkIsPhishingUri(any<Uri>()));
    });

    test('Empty text', () async {
      await browserService.requestUrlSafe('tab-1', '   ');

      verifyNever(() => tabsDelegate.requestUrl(any(), any<Uri>()));
      verifyNever(() => antiPhishingDelegate.checkIsPhishingUri(any<Uri>()));
    });

    test('No phishing url', () async {
      const urlString = 'https://example.com';
      final uri = Uri.parse(urlString);

      when(
        () => antiPhishingDelegate.checkIsPhishingUri(uri),
      ).thenReturn(false);
      when(
        () => tabsDelegate.requestUrl('tab-1', uri),
      ).thenAnswer((_) async {});

      await browserService.requestUrlSafe('tab-1', urlString);

      verify(() => antiPhishingDelegate.checkIsPhishingUri(uri)).called(1);
      verify(() => tabsDelegate.requestUrl('tab-1', uri)).called(1);
    });

    test('Phishing url', () async {
      const urlString = 'https://evil.com';
      final uri = Uri.parse(urlString);
      const html = '<html>phishing</html>';

      when(() => antiPhishingDelegate.checkIsPhishingUri(uri)).thenReturn(true);
      when(
        () => antiPhishingDelegate.getPhishingGuardHtml(uri),
      ).thenAnswer((_) async => html);
      when(() => tabsDelegate.loadData('tab-1', html)).thenAnswer((_) async {});

      await browserService.requestUrlSafe('tab-1', urlString);

      verify(() => antiPhishingDelegate.checkIsPhishingUri(uri)).called(1);
      verify(() => antiPhishingDelegate.getPhishingGuardHtml(uri)).called(1);
      verify(() => tabsDelegate.loadData('tab-1', html)).called(1);
      verifyNever(() => tabsDelegate.requestUrl(any(), any<Uri>()));
    });

    test('Text is not a url', () async {
      const text = 'hello';
      final expectedUri = Uri.parse('${BrowserService.searchUrl}$text');

      when(
        () => tabsDelegate.requestUrl('tab-1', expectedUri),
      ).thenAnswer((_) async {});

      await browserService.requestUrlSafe('tab-1', text);

      verifyNever(() => antiPhishingDelegate.checkIsPhishingUri(any<Uri>()));
      verify(() => tabsDelegate.requestUrl('tab-1', expectedUri)).called(1);
    });
  });

  group('requestUrlActiveTabSafe', () {
    test('activeTabId null', () async {
      when(() => tabsDelegate.activeTabId).thenReturn(null);

      await browserService.requestUrlActiveTabSafe('https://example.com');

      verifyNever(() => tabsDelegate.requestUrl(any(), any<Uri>()));
      verifyNever(() => antiPhishingDelegate.checkIsPhishingUri(any<Uri>()));
    });

    test('requestUrlSafe', () async {
      when(() => tabsDelegate.activeTabId).thenReturn('tab-1');

      const urlString = 'https://example.com';
      final uri = Uri.parse(urlString);

      when(
        () => antiPhishingDelegate.checkIsPhishingUri(uri),
      ).thenReturn(false);
      when(
        () => tabsDelegate.requestUrl('tab-1', uri),
      ).thenAnswer((_) async {});

      await browserService.requestUrlActiveTabSafe(urlString);

      verify(() => tabsDelegate.activeTabId).called(1);
      verify(() => antiPhishingDelegate.checkIsPhishingUri(uri)).called(1);
      verify(() => tabsDelegate.requestUrl('tab-1', uri)).called(1);
    });
  });
}
