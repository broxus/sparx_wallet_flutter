import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/bookmarks/bookmarks_list.dart';
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

  bool get isEmptyBookmarks => _browserService.bM.browserBookmarks.isEmpty;

  void requestUrl(Uri uri) {
    _browserService.tM.requestUrlActiveTab(uri);
  }
}
