import 'package:app/app/service/app_notifications/domain/service/app_notifications_service.dart';
import 'package:app/feature/browser/data/groups/browser_group.dart';
import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_pages_controllers_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_screenshots_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_tabs_delegate.dart';
import 'package:app/feature/browser/domain/service/storages/browser_groups_storage_service.dart';
import 'package:app/feature/browser/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockBrowserTabsStorageService extends Mock
    implements BrowserTabsStorageService {}

class _MockBrowserGroupsStorageService extends Mock
    implements BrowserGroupsStorageService {}

class _MockControllersDelegate extends Mock
    implements BrowserServicePagesControllersDelegate {}

class _MockScreenshotsDelegate extends Mock
    implements BrowserServiceScreenshotsDelegate {}

class _MockAppNotificationService extends Mock
    implements AppNotificationService {}

void main() {
  late _MockBrowserTabsStorageService tabsStorage;
  late _MockBrowserGroupsStorageService groupsStorage;
  late _MockControllersDelegate controllersDelegate;
  late _MockScreenshotsDelegate screenshotsDelegate;
  late _MockAppNotificationService appNotificationService;
  late BrowserServiceTabsDelegate browserServiceTabsDelegate;

  setUpAll(() {
    registerFallbackValue(<String>[]);
    registerFallbackValue(<BrowserTab>[]);
    registerFallbackValue(<BrowserGroup>[]);
  });

  setUp(() {
    tabsStorage = _MockBrowserTabsStorageService();
    groupsStorage = _MockBrowserGroupsStorageService();
    controllersDelegate = _MockControllersDelegate();
    screenshotsDelegate = _MockScreenshotsDelegate();
    appNotificationService = _MockAppNotificationService();
    browserServiceTabsDelegate = BrowserServiceTabsDelegate(
      tabsStorage,
      groupsStorage,
      controllersDelegate,
      screenshotsDelegate,
      appNotificationService,
    );

    when(
      () => controllersDelegate.checkCanGoBack(any()),
    ).thenAnswer((_) async => false);
    when(
      () => controllersDelegate.checkCanGoForward(any()),
    ).thenAnswer((_) async => false);
    when(() => screenshotsDelegate.init(any())).thenReturn(null);
  });

  group('init', () {
    test('Init fetch data', () async {
      final tab1 = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://a.com'),
        sortingOrder: 1,
      );
      final tab2 = BrowserTab(
        id: 't2',
        title: 't2',
        url: Uri.parse('https://a.com'),
        sortingOrder: 2,
      );
      final group = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab1.id, tab2.id],
        sortingOrder: 1,
        isEditable: false,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab2, tab1]);
      when(() => groupsStorage.getGroups()).thenReturn([group]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab2.id);

      browserServiceTabsDelegate.init();

      expect(browserServiceTabsDelegate.allTabsIdsState.value, [
        tab1.id,
        tab2.id,
      ]);
      expect(browserServiceTabsDelegate.activeTabIdState.value, tab2.id);
      expect(browserServiceTabsDelegate.activeGroupIdState.value, group.id);
      expect(browserServiceTabsDelegate.activeTabUriState.value, tab2.url);

      verifyNever(() => groupsStorage.initGroups(any()));
      verify(() => screenshotsDelegate.init(any())).called(1);
    });
  });

  group('updateCachedUrl', () {
    test('updateCachedUrl active tab', () async {
      final tab = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://old.com'),
        sortingOrder: 1,
      );
      final group = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab.id],
        sortingOrder: 1,
        isEditable: false,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab]);
      when(() => groupsStorage.getGroups()).thenReturn([group]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab.id);
      when(() => tabsStorage.saveBrowserTabs(any())).thenReturn(null);

      browserServiceTabsDelegate.init();

      final newUri = Uri.parse('https://new.com');

      browserServiceTabsDelegate.updateCachedUrl(tab.id, newUri);

      expect(browserServiceTabsDelegate.activeTabUriState.value, newUri);
      expect(browserServiceTabsDelegate.getTabUriId(tab.id), newUri);

      verify(() => tabsStorage.saveBrowserTabs(any())).called(1);
    });

    test('updateCachedUrl inactive tab', () async {
      final tab1 = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://active.com'),
        sortingOrder: 1,
      );
      final tab2 = BrowserTab(
        id: 't2',
        title: 't2',
        url: Uri.parse('https://other.com'),
        sortingOrder: 2,
      );
      final group = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab1.id, tab2.id],
        sortingOrder: 1,
        isEditable: false,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab1, tab2]);
      when(() => groupsStorage.getGroups()).thenReturn([group]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab1.id);
      when(() => tabsStorage.saveBrowserTabs(any())).thenReturn(null);

      browserServiceTabsDelegate.init();

      final oldActiveUri = browserServiceTabsDelegate.activeTabUriState.value;
      final newUriForInactive = Uri.parse('https://new-inactive.com');

      browserServiceTabsDelegate.updateCachedUrl(tab2.id, newUriForInactive);

      expect(browserServiceTabsDelegate.activeTabUriState.value, oldActiveUri);
      expect(
        browserServiceTabsDelegate.getTabUriId(tab2.id),
        newUriForInactive,
      );
    });
  });

  group('Set new active', () {
    test('setActiveTab', () async {
      final tab1 = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://a.com'),
        sortingOrder: 1,
      );
      final tab2 = BrowserTab(
        id: 't2',
        title: 't2',
        url: Uri.parse('https://b.com'),
        sortingOrder: 2,
      );
      final group = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab1.id, tab2.id],
        sortingOrder: 1,
        isEditable: false,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab1, tab2]);
      when(() => groupsStorage.getGroups()).thenReturn([group]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab1.id);
      when(() => tabsStorage.saveBrowserActiveTabId(any())).thenReturn(null);

      browserServiceTabsDelegate
        ..init()
        ..setActiveTab(tab2.id);

      expect(browserServiceTabsDelegate.activeTabIdState.value, tab2.id);
      verify(() => tabsStorage.saveBrowserActiveTabId(tab2.id)).called(1);
    });

    test('setActiveGroup', () async {
      final tab = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://a.com'),
        sortingOrder: 1,
      );
      final g1 = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab.id],
        sortingOrder: 1,
        isEditable: false,
      );
      final g2 = BrowserGroup(
        id: 'g2',
        title: 'Second',
        tabsIds: [],
        sortingOrder: 2,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab]);
      when(() => groupsStorage.getGroups()).thenReturn([g1, g2]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab.id);

      browserServiceTabsDelegate
        ..init()
        ..setActiveGroup(g2.id);

      expect(browserServiceTabsDelegate.activeGroupIdState.value, g2.id);
    });
  });

  group('Clear', () {
    test('Clear all tabs', () async {
      when(() => tabsStorage.clear()).thenAnswer((_) async {});
      when(() => screenshotsDelegate.clear()).thenAnswer((_) async {});

      await browserServiceTabsDelegate.clearTabs();

      verify(() => tabsStorage.clear()).called(1);
      verify(() => screenshotsDelegate.clear()).called(1);
      expect(browserServiceTabsDelegate.allTabsIdsState.value, isEmpty);
    });

    test('Clear tabs for group', () async {
      final tab1 = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://a.com'),
        sortingOrder: 1,
      );
      final tab2 = BrowserTab(
        id: 't2',
        title: 't2',
        url: Uri.parse('https://b.com'),
        sortingOrder: 2,
      );
      final group = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab1.id, tab2.id],
        sortingOrder: 1,
        isEditable: false,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab1, tab2]);
      when(() => groupsStorage.getGroups()).thenReturn([group]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab1.id);
      when(() => groupsStorage.saveGroups(any())).thenReturn(null);
      when(() => tabsStorage.saveBrowserTabs(any())).thenReturn(null);
      when(() => tabsStorage.saveBrowserActiveTabId(any())).thenReturn(null);

      browserServiceTabsDelegate.init();

      await browserServiceTabsDelegate.clearTabs(group.id);

      expect(browserServiceTabsDelegate.getTabIds(group.id), isEmpty);
      expect(browserServiceTabsDelegate.activeTabIdState.value, isNull);

      verify(() => groupsStorage.saveGroups(any())).called(1);
      verify(() => tabsStorage.saveBrowserTabs(any())).called(1);
      verify(() => tabsStorage.saveBrowserActiveTabId(null)).called(1);
    });
  });

  test('updateGroupName', () async {
    final tab = BrowserTab(
      id: 't1',
      title: 't1',
      url: Uri.parse('https://a.com'),
      sortingOrder: 1,
    );
    final group = BrowserGroup(
      id: tabsGroupId,
      title: 'Old',
      tabsIds: [tab.id],
      sortingOrder: 1,
      isEditable: false,
    );

    when(() => tabsStorage.getTabs()).thenReturn([tab]);
    when(() => groupsStorage.getGroups()).thenReturn([group]);
    when(() => tabsStorage.getActiveTabId()).thenReturn(tab.id);
    when(() => groupsStorage.saveGroups(any())).thenReturn(null);

    browserServiceTabsDelegate
      ..init()
      ..updateGroupName(groupId: group.id, name: 'New Name');

    expect(
      browserServiceTabsDelegate.getGroupListenableById(group.id)!.value.title,
      'New Name',
    );
    verify(() => groupsStorage.saveGroups(any())).called(1);
  });

  group('Remove', () {
    test('removeBrowserGroup', () async {
      final tab1 = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://a.com'),
        sortingOrder: 1,
      );
      final tab2 = BrowserTab(
        id: 't2',
        title: 't2',
        url: Uri.parse('https://b.com'),
        sortingOrder: 2,
      );

      final group1 = BrowserGroup(
        id: tabsGroupId,
        title: 'G1',
        tabsIds: [tab1.id],
        sortingOrder: 1,
        isEditable: false,
      );
      final group2 = BrowserGroup(
        id: 'g2',
        title: 'G2',
        tabsIds: [tab2.id],
        sortingOrder: 2,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab1, tab2]);
      when(() => groupsStorage.getGroups()).thenReturn([group1, group2]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab1.id);
      when(() => groupsStorage.saveGroups(any())).thenReturn(null);
      when(() => tabsStorage.saveBrowserTabs(any())).thenReturn(null);
      when(() => tabsStorage.saveBrowserActiveTabId(any())).thenReturn(null);

      browserServiceTabsDelegate
        ..init()
        ..removeBrowserGroup(group1.id);

      expect(browserServiceTabsDelegate.allGroupsIdsState.value, [group2.id]);
      expect(browserServiceTabsDelegate.allTabsIdsState.value, [tab2.id]);
      expect(browserServiceTabsDelegate.activeGroupIdState.value, group2.id);
      expect(browserServiceTabsDelegate.activeTabIdState.value, isNull);

      verify(() => groupsStorage.saveGroups(any())).called(1);
      verify(() => tabsStorage.saveBrowserTabs(any())).called(1);
      verify(() => tabsStorage.saveBrowserActiveTabId(null)).called(1);
    });

    test('removeBrowserTab when this single tab', () async {
      final tab = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://a.com'),
        sortingOrder: 1,
      );
      final group = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab.id],
        sortingOrder: 1,
        isEditable: false,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab]);
      when(() => groupsStorage.getGroups()).thenReturn([group]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab.id);
      when(() => groupsStorage.saveGroups(any())).thenReturn(null);
      when(() => tabsStorage.saveBrowserTabs(any())).thenReturn(null);
      when(() => tabsStorage.saveBrowserActiveTabId(any())).thenReturn(null);
      when(
        () => screenshotsDelegate.removeScreenshot(any()),
      ).thenAnswer((_) async {});

      browserServiceTabsDelegate.init();

      await browserServiceTabsDelegate.removeBrowserTab(
        groupId: group.id,
        tabId: tab.id,
      );

      expect(browserServiceTabsDelegate.getTabIds(group.id), isEmpty);
      expect(browserServiceTabsDelegate.activeTabIdState.value, isNull);
      expect(browserServiceTabsDelegate.allTabsIdsState.value, isEmpty);

      verify(() => groupsStorage.saveGroups(any())).called(1);
      verify(() => tabsStorage.saveBrowserTabs(any())).called(1);
      verify(() => tabsStorage.saveBrowserActiveTabId(null)).called(1);
      verify(() => screenshotsDelegate.removeScreenshot(tab.id)).called(1);
    });

    test('removeBrowserTab when many tabs', () async {
      final tab1 = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://a.com'),
        sortingOrder: 1,
      );
      final tab2 = BrowserTab(
        id: 't2',
        title: 't2',
        url: Uri.parse('https://b.com'),
        sortingOrder: 2,
      );
      final group = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab1.id, tab2.id],
        sortingOrder: 1,
        isEditable: false,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab1, tab2]);
      when(() => groupsStorage.getGroups()).thenReturn([group]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab1.id);
      when(() => groupsStorage.saveGroups(any())).thenReturn(null);
      when(() => tabsStorage.saveBrowserTabs(any())).thenReturn(null);
      when(() => tabsStorage.saveBrowserActiveTabId(any())).thenReturn(null);
      when(
        () => screenshotsDelegate.removeScreenshot(any()),
      ).thenAnswer((_) async {});

      browserServiceTabsDelegate.init();

      await browserServiceTabsDelegate.removeBrowserTab(
        groupId: group.id,
        tabId: tab1.id,
      );

      expect(browserServiceTabsDelegate.getTabIds(group.id), [tab2.id]);
      expect(browserServiceTabsDelegate.activeTabIdState.value, tab2.id);

      verify(() => tabsStorage.saveBrowserActiveTabId(tab2.id)).called(1);
    });
  });

  group('Go', () {
    test('backWeb when activeTabId == null', () async {
      final tab = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://a.com'),
        sortingOrder: 1,
      );
      final group = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab.id],
        sortingOrder: 1,
        isEditable: false,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab]);
      when(() => groupsStorage.getGroups()).thenReturn([group]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab.id);

      browserServiceTabsDelegate
        ..init()
        ..setActiveTab(null);

      await browserServiceTabsDelegate.backWeb();

      verifyNever(() => controllersDelegate.goBack(any()));
    });

    test('backWeb for active tab', () async {
      final tab = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://a.com'),
        sortingOrder: 1,
      );
      final group = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab.id],
        sortingOrder: 1,
        isEditable: false,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab]);
      when(() => groupsStorage.getGroups()).thenReturn([group]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab.id);
      when(() => controllersDelegate.goBack(any())).thenAnswer((_) async {});
      when(
        () => controllersDelegate.checkCanGoBack(any()),
      ).thenAnswer((_) async => false);
      when(
        () => controllersDelegate.checkCanGoForward(any()),
      ).thenAnswer((_) async => false);

      browserServiceTabsDelegate.init();

      await browserServiceTabsDelegate.backWeb();

      verify(() => controllersDelegate.goBack(tab.id)).called(1);
    });

    test('forwardWeb for active tab', () async {
      final tab = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://a.com'),
        sortingOrder: 1,
      );
      final group = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab.id],
        sortingOrder: 1,
        isEditable: false,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab]);
      when(() => groupsStorage.getGroups()).thenReturn([group]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab.id);
      when(() => controllersDelegate.goForward(any())).thenAnswer((_) async {});
      when(
        () => controllersDelegate.checkCanGoBack(any()),
      ).thenAnswer((_) async => false);
      when(
        () => controllersDelegate.checkCanGoForward(any()),
      ).thenAnswer((_) async => false);

      browserServiceTabsDelegate.init();

      await browserServiceTabsDelegate.forwardWeb();

      verify(() => controllersDelegate.goForward(tab.id)).called(1);
    });
  });

  test(
    'getTabIndex, getTabIdByIndex, getTabIds, getGroupTabsListenable',
    () async {
      final tab1 = BrowserTab(
        id: 't1',
        title: 't1',
        url: Uri.parse('https://a.com'),
        sortingOrder: 1,
      );
      final tab2 = BrowserTab(
        id: 't2',
        title: 't2',
        url: Uri.parse('https://b.com'),
        sortingOrder: 2,
      );
      final group = BrowserGroup(
        id: tabsGroupId,
        title: 'Tabs',
        tabsIds: [tab1.id, tab2.id],
        sortingOrder: 1,
        isEditable: false,
      );

      when(() => tabsStorage.getTabs()).thenReturn([tab1, tab2]);
      when(() => groupsStorage.getGroups()).thenReturn([group]);
      when(() => tabsStorage.getActiveTabId()).thenReturn(tab1.id);

      browserServiceTabsDelegate.init();

      expect(browserServiceTabsDelegate.getTabIds(group.id), [
        tab1.id,
        tab2.id,
      ]);
      expect(
        browserServiceTabsDelegate.getTabIndex(
          groupId: group.id,
          tabId: tab2.id,
        ),
        1,
      );
      expect(
        browserServiceTabsDelegate.getTabIdByIndex(groupId: group.id, index: 0),
        tab1.id,
      );

      final listenables = browserServiceTabsDelegate.getGroupTabsListenable(
        group.id,
      );
      expect(listenables.length, 2);
      expect(listenables[0].value.id, tab1.id);
      expect(listenables[1].value.id, tab2.id);
    },
  );
}
