import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_bookmarks_delegate.dart';
import 'package:app/feature/browser/domain/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBookmarksStorageService extends Mock
    implements BrowserBookmarksStorageService {}

class MockMessengerService extends Mock implements MessengerService {}

void main() {
  late MockBookmarksStorageService storage;
  late MockMessengerService messenger;
  late BrowserServiceBookmarksDelegate delegate;

  BrowserBookmarkItem bookmark({
    required Uri url,
    required String title,
    String? id,
    int sortingOrder = 0,
  }) {
    // Подгони ключи под реальную модель, если у тебя другие названия
    return BrowserBookmarkItem.fromJson(<String, dynamic>{
      'id': id ?? 'id-${url.host}-$title',
      'url': url.toString(),
      'title': title,
      'sortingOrder': sortingOrder,
      // если в модели есть ещё поля (createdAt и т.п.) — добавь сюда
    });
  }

  setUpAll(() {
    registerFallbackValue(<BrowserBookmarkItem>[]);
    registerFallbackValue(Message.info(message: 'fallback', actionText: null));
    EasyLocalization.logger.enableBuildModes = [];
    EasyLocalization.logger.enableLevels = [];
  });

  setUp(() {
    storage = MockBookmarksStorageService();
    messenger = MockMessengerService();
    delegate = BrowserServiceBookmarksDelegate(storage, messenger);
  });

  group('fetchBookmarksFromStorage from init ', () {
    test('Read bookmarks', () {
      final uri1 = Uri.parse('https://example.com');
      final uri2 = Uri.parse('https://google.com');

      final bookmark1 = bookmark(url: uri1, title: 'One');
      final duplicateOf1 = bookmark1;
      final bookmark2 = bookmark(url: uri2, title: 'Two');

      when(
        () => storage.getBrowserBookmarks(),
      ).thenReturn([bookmark1, duplicateOf1, bookmark2]);

      delegate.init();

      verify(() => storage.getBrowserBookmarks()).called(1);

      final bookmarks = delegate.browserBookmarks;

      expect(bookmarks.length, 2);
      expect(bookmarks, contains(bookmark1));
      expect(bookmarks, contains(bookmark2));
    });
  });

  group('saveBrowserBookmarks', () {
    test('Save a unique bookmark', () {
      final uri = Uri.parse('https://example.com');
      final b1 = bookmark(url: uri, title: 'A');
      final b2 = b1;

      delegate.saveBrowserBookmarks([b1, b2]);

      final savedArg =
          verify(
                () => storage.saveBrowserBookmarks(captureAny()),
              ).captured.single
              as List<BrowserBookmarkItem>;

      expect(savedArg.length, 1);
      expect(savedArg.single, same(b1));

      final bookmarks = delegate.browserBookmarks;
      expect(bookmarks.length, 1);
      expect(bookmarks.single, same(b1));
    });
  });

  group('createBrowserBookmark / setBrowserBookmarkItem', () {
    test('Empty host', () {
      final uri = Uri.parse('https:///');

      delegate.setBrowserBookmarkItem(bookmark(url: uri, title: 'Empty host'));

      verifyNever(() => storage.saveBrowserBookmarks(any()));
      verifyNever(() => messenger.show(any()));
      expect(delegate.browserBookmarks, isEmpty);
    });

    test('Create bookmark via setBrowserBookmarkItem (логика делегата)', () {
      final uri = Uri.parse('https://example.com');

      delegate.setBrowserBookmarkItem(bookmark(url: uri, title: 'Title'));

      final savedArg =
          verify(
                () => storage.saveBrowserBookmarks(captureAny()),
              ).captured.single
              as List<BrowserBookmarkItem>;

      expect(savedArg.length, 1);
      expect(savedArg.first.url, uri);
      expect(savedArg.first.title, 'Title');

      final bookmarks = delegate.browserBookmarks;
      expect(bookmarks.length, 1);
      expect(bookmarks.first.url, uri);
      expect(bookmarks.first.title, 'Title');

      verify(() => messenger.show(any())).called(1);
    });

    test('Update url by setBrowserBookmarkItem', () {
      final uri = Uri.parse('https://example.com');

      final initial = bookmark(url: uri, title: 'Old');
      when(() => storage.getBrowserBookmarks()).thenReturn([initial]);
      delegate.init();

      final updated = initial.copyWith(title: 'New');

      delegate.setBrowserBookmarkItem(updated, needUndo: false);

      final savedArg =
          verify(() => storage.saveBrowserBookmarks(captureAny())).captured.last
              as List<BrowserBookmarkItem>;

      expect(savedArg.length, 1);
      expect(savedArg.single.title, 'New');

      final bookmarks = delegate.browserBookmarks;
      expect(bookmarks.length, 1);
      expect(bookmarks.single.title, 'New');

      verifyNever(() => messenger.show(any()));
    });
  });

  group('reorder', () {
    test('Reorder bookmarks', () {
      final uri1 = Uri.parse('https://one.com');
      final uri2 = Uri.parse('https://two.com');
      final uri3 = Uri.parse('https://three.com');

      final b1 = bookmark(url: uri1, title: '1');
      final b2 = bookmark(url: uri2, title: '2');
      final b3 = bookmark(url: uri3, title: '3');

      when(() => storage.getBrowserBookmarks()).thenReturn([b1, b2, b3]);
      delegate
        ..init()
        ..reorder(0, 2);

      final savedArg =
          verify(() => storage.saveBrowserBookmarks(captureAny())).captured.last
              as List<BrowserBookmarkItem>;

      expect(savedArg, [b2, b1, b3]);
      expect(delegate.browserBookmarks, [b2, b1, b3]);
    });
  });

  group('removeBrowserBookmarkItem', () {
    test('Do not remove if not exist id', () {
      when(() => storage.getBrowserBookmarks()).thenReturn([]);
      delegate
        ..init()
        ..removeBrowserBookmarkItem('unknown');

      verifyNever(() => storage.saveBrowserBookmarks(any()));
      verifyNever(() => messenger.show(any()));
    });

    test('Remove bookmark', () {
      final uri = Uri.parse('https://example.com');
      final item = bookmark(url: uri, title: 'Title');

      when(() => storage.getBrowserBookmarks()).thenReturn([item]);
      delegate
        ..init()
        ..removeBrowserBookmarkItem(item.id);

      final savedArg =
          verify(() => storage.saveBrowserBookmarks(captureAny())).captured.last
              as List<BrowserBookmarkItem>;

      expect(savedArg, isEmpty);
      expect(delegate.browserBookmarks, isEmpty);
    });
  });

  group('clearBookmarks', () {
    test('Clear bookmarks', () async {
      final uri = Uri.parse('https://example.com');
      final item = bookmark(url: uri, title: 'Title');

      when(() => storage.getBrowserBookmarks()).thenReturn([item]);
      when(() => storage.clear()).thenAnswer((_) async {});

      delegate.init();
      expect(delegate.browserBookmarks, isNotEmpty);

      await delegate.clearBookmarks(needUndo: false);

      verify(() => storage.clear()).called(1);
      expect(delegate.browserBookmarks, isEmpty);
    });
  });

  group('checkExistBookmarkByUri', () {
    test('Url or host is empty', () {
      expect(delegate.checkExistBookmarkByUri(null), isFalse);
      expect(delegate.checkExistBookmarkByUri(Uri.parse('https:///')), isFalse);
    });

    test('Exist host, but not bookmark with this host', () {
      final uri = Uri.parse('https://example.com');
      expect(delegate.checkExistBookmarkByUri(uri), isTrue);
    });

    test('Exist bookmark with this url', () {
      final uri = Uri.parse('https://example.com');
      final item = bookmark(url: uri, title: 'Title');

      when(() => storage.getBrowserBookmarks()).thenReturn([item]);
      delegate.init();

      expect(delegate.checkExistBookmarkByUri(uri), isFalse);
    });
  });

  group('renameBookmark', () {
    test('Not exist bookmark with this id', () {
      when(() => storage.getBrowserBookmarks()).thenReturn([]);
      delegate
        ..init()
        ..renameBookmark('unknown', 'New Name');

      verifyNever(() => storage.saveBrowserBookmarks(any()));
    });

    test('Rename bookmark', () {
      final uri = Uri.parse('https://example.com');
      final item = bookmark(url: uri, title: 'Old');

      when(() => storage.getBrowserBookmarks()).thenReturn([item]);
      delegate
        ..init()
        ..renameBookmark(item.id, 'New');

      final savedArg =
          verify(() => storage.saveBrowserBookmarks(captureAny())).captured.last
              as List<BrowserBookmarkItem>;

      expect(savedArg.length, 1);
      expect(savedArg.single.id, item.id);
      expect(savedArg.single.title, 'New');

      final bookmarks = delegate.browserBookmarks;
      expect(bookmarks.single.title, 'New');
    });
  });
}
