import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/widgets/tips_bar/tips_bar.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [TipsBar]
@injectable
class TipsBarModel extends ElementaryModel {
  TipsBarModel(ErrorHandler errorHandler, this._browserService)
    : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  List<BrowserBookmarkItem> get browserBookmarks =>
      _browserService.book.browserBookmarks;

  Future<List<BrowserHistoryItem>> getHistoryItems() =>
      _browserService.hist.getItems();

  void requestUri(Uri uri) => _browserService.tab.requestUrlActiveTab(uri);
}
