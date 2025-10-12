import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browser_v2/data/history_type.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/browser_book.dart';
import 'package:app/feature/localization/domain/localization_service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [BrowserBook]
@injectable
class BrowserBookModel extends ElementaryModel {
  BrowserBookModel(
    ErrorHandler errorHandler,
    this._browserService,
    this._localizationService,
  ) : super(errorHandler: errorHandler);

  late final localeCode = _localizationService.localeCode.name;

  final BrowserService _browserService;
  final LocalizationService _localizationService;

  Stream<List<BrowserBookmarkItem>> get browserBookmarksStream =>
      _browserService.book.browserBookmarksStream;

  List<BrowserBookmarkItem> get browserBookmarks =>
      _browserService.book.browserBookmarks;

  bool get isExistBookmarks => _browserService.book.browserBookmarks.isNotEmpty;

  Stream<List<BrowserHistoryItem>> watchHistory([String? text]) =>
      _browserService.hist.watchHistory(text);

  Stream<int> watchHistoryCount() => _browserService.hist.watchHistoryCount();

  Future<BrowserHistoryItem?> getHistoryItemById(String id) =>
      _browserService.hist.getHistoryItemById(id);

  void requestUrl(Uri uri) {
    _browserService.tab.requestUrlActiveTab(uri);
  }

  void removeBookmark(String bookmarkId) {
    _browserService.book.removeBrowserBookmarkItem(bookmarkId);
  }

  void reorderBookmark(int oldIndex, int newIndex) {
    _browserService.book.reorder(oldIndex, newIndex);
  }

  void removeHistory(String id) => _browserService.hist.removeHistoryItem(id);

  void clearData(TimePeriod period, Set<TypeHistory> targets) {
    _browserService.clearData(period, targets);
  }
}
