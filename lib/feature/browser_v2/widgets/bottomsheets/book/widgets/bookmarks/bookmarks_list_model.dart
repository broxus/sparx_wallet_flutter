import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/bookmarks/bookmarks_list.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [BookmarksList]
@injectable
class BookmarksListModel extends ElementaryModel {
  BookmarksListModel(ErrorHandler errorHandler, this._browserService)
    : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  Stream<List<BrowserBookmarkItem>> get browserBookmarksStream =>
      _browserService.book.browserBookmarksStream;

  List<BrowserBookmarkItem> get browserBookmarks =>
      _browserService.book.browserBookmarks;

  bool get isExistBookmarks => _browserService.book.browserBookmarks.isNotEmpty;

  void requestUrl(Uri uri) {
    _browserService.tab.requestUrlActiveTab(uri);
  }

  void removeBookmark(String bookmarkId) {
    _browserService.book.removeBrowserBookmarkItem(bookmarkId);
  }

  void reorder(int oldIndex, int newIndex) {
    _browserService.book.reorder(oldIndex, newIndex);
  }
}
