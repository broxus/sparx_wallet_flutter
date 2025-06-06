import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/bookmarks/bookmarks_list.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [BookmarksList]
class BookmarksListModel extends ElementaryModel {
  BookmarksListModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  Stream<List<BrowserBookmarkItem>> get browserBookmarksStream =>
      _browserService.bM.browserBookmarksStream;

  List<BrowserBookmarkItem> get browserBookmarks =>
      _browserService.bM.browserBookmarks;

  bool get isExistBookmarks => _browserService.bM.browserBookmarks.isNotEmpty;

  void requestUrl(Uri uri) {
    _browserService.tM.requestUrlActiveTab(uri);
  }

  void removeBookmark(String bookmarkId) {
    _browserService.bM.removeBrowserBookmarkItem(bookmarkId);
  }

  void reorder(int oldIndex, int newIndex) {
    _browserService.bM.reorder(oldIndex, newIndex);
  }
}
