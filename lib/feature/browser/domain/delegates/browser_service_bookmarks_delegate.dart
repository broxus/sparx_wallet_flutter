import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browser/domain/delegates/browser_base_delegate.dart';
import 'package:app/feature/browser/domain/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/generated/generated.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

abstract interface class BrowserServiceBookmarks {
  Stream<List<BrowserBookmarkItem>> get browserBookmarksStream;

  List<BrowserBookmarkItem> get browserBookmarks;

  void removeBrowserBookmarkItem(String id, {bool needUndo = true});

  void reorder(int oldIndex, int newIndex);

  void renameBookmark(String id, String name);
}

@injectable
class BrowserServiceBookmarksDelegate
    implements BrowserDelegate, BrowserServiceBookmarks {
  BrowserServiceBookmarksDelegate(
    this._bookmarksStorageService,
    this._messengerService,
  );

  final BrowserBookmarksStorageService _bookmarksStorageService;
  final MessengerService _messengerService;

  static final _log = Logger('BrowserBookmarksStorageService');

  /// Subject of browser bookmarks items
  final _browserBookmarksSubject =
      BehaviorSubject<List<BrowserBookmarkItem>>.seeded([]);

  /// Stream of browser bookmarks items
  @override
  Stream<List<BrowserBookmarkItem>> get browserBookmarksStream =>
      _browserBookmarksSubject;

  /// Get last cached browser bookmarks items
  @override
  List<BrowserBookmarkItem> get browserBookmarks =>
      _browserBookmarksSubject.valueOrNull ?? [];

  void init() {
    _fetchBookmarksFromStorage();
  }

  Future<void> clear() async {
    await clearBookmarks(needUndo: false);
  }

  void saveBrowserBookmarks(List<BrowserBookmarkItem> bookmarks) {
    final result = bookmarks.toSet().toList();

    _bookmarksStorageService.saveBrowserBookmarks(result);
    _browserBookmarksSubject.add(result);
  }

  void createBrowserBookmark(Uri uri, String? title) {
    setBrowserBookmarkItem(
      BrowserBookmarkItem.create(url: uri, title: title ?? ''),
    );
  }

  void setBrowserBookmarkItem(
    BrowserBookmarkItem item, {
    bool needUndo = true,
  }) {
    if (item.url.host.isEmpty) {
      return;
    }

    final bookmarks = [...browserBookmarks];

    final index = bookmarks.indexWhere((i) => i.url == item.url);

    if (index == -1) {
      bookmarks.add(item);
    } else {
      bookmarks[index] = item;
    }

    saveBrowserBookmarks(bookmarks);

    if (needUndo) {
      _messengerService.show(
        Message.info(
          message: LocaleKeys.browserBookmarkAdded.tr(),
          actionText: LocaleKeys.undo.tr(),
          onAction: () => removeBrowserBookmarkItem(item.id, needUndo: false),
          topMargin: DimensSize.d72,
        ),
      );
    }
  }

  @override
  void reorder(int oldIndex, int newIndex) {
    final bookmarks = [...browserBookmarks];

    final item = bookmarks.removeAt(oldIndex);

    var index = newIndex;

    if (index > bookmarks.length) {
      index = bookmarks.length;
    }
    // Hack for:
    // https://github.com/flutter/flutter/issues/24786
    // Due to backward compatibility issues,
    // the development team decided not to fix this issue.
    if (oldIndex < index) {
      index--;
    }

    bookmarks.insert(index, item);

    saveBrowserBookmarks(bookmarks);
  }

  @override
  void removeBrowserBookmarkItem(String id, {bool needUndo = true}) {
    final index = browserBookmarks.indexWhere((item) => item.id == id);

    if (index == -1) {
      _log.warning('Browser bookmark item with id $id not found');

      return;
    }

    final bookmarks = [...browserBookmarks];

    final item = bookmarks.removeAt(index);

    if (needUndo) {
      _messengerService.show(
        Message.info(
          message: LocaleKeys.browserBookmarkDeleted.tr(),
          actionText: LocaleKeys.undo.tr(),
          onAction: () {
            bookmarks.insert(index, item);
            saveBrowserBookmarks(bookmarks);
          },
          topMargin: DimensSize.d72,
        ),
      );
    }

    saveBrowserBookmarks(bookmarks);
  }

  /// Clear browser bookmarks
  Future<void> clearBookmarks({bool needUndo = true}) async {
    await _bookmarksStorageService.clear();

    final savedBrowserBookmarks = needUndo
        ? [...browserBookmarks]
        : <BrowserBookmarkItem>[];

    _browserBookmarksSubject.add([]);

    if (needUndo) {
      _messengerService.show(
        Message.info(
          message: LocaleKeys.browserBookmarksDeleted.tr(),
          actionText: LocaleKeys.undo.tr(),
          onAction: () => saveBrowserBookmarks(savedBrowserBookmarks),
          topMargin: DimensSize.d72,
        ),
      );
    }
  }

  bool checkExistBookmarkByUri(Uri? url) {
    return (url?.host.isNotEmpty ?? false) &&
        browserBookmarks.indexWhere((item) => item.url == url) < 0;
  }

  @override
  void renameBookmark(String id, String name) {
    final index = browserBookmarks.indexWhere((item) => item.id == id);

    if (index < 0) {
      return;
    }

    final bookmarks = [...browserBookmarks];

    bookmarks[index] = bookmarks[index].copyWith(title: name);

    saveBrowserBookmarks(bookmarks);
  }

  void _fetchBookmarksFromStorage() {
    final result = _bookmarksStorageService
        .getBrowserBookmarks()
        .toSet()
        .toList();

    _browserBookmarksSubject.add(result);
  }
}
