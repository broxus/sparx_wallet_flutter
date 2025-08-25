import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browser_v2/data/history_type.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/history_list.dart';
import 'package:app/feature/localization/localization.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [HistoryList]
@injectable
class HistoryListModel extends ElementaryModel {
  HistoryListModel(
    ErrorHandler errorHandler,
    this._browserService,
    this._localizationService,
  ) : super(errorHandler: errorHandler);

  late final localeCode = _localizationService.localeCode.name;

  final BrowserService _browserService;
  final LocalizationService _localizationService;

  Stream<List<BrowserHistoryItem>> get originalBrowserHistoryStream =>
      _browserService.hist.browserHistoryStream;

  List<BrowserHistoryItem> get originalBrowserHistoryItems =>
      _browserService.hist.browserHistoryItems;

  bool get isExistHistory => originalBrowserHistoryItems.isNotEmpty;

  void requestUrl(Uri uri) {
    _browserService.tab.requestUrlActiveTab(uri);
  }

  void removeHistory(String id) => _browserService.hist.removeHistoryItem(id);

  void clearData(TimePeriod period, Set<TypeHistory> targets) {
    _browserService.clearData(period, targets);
  }
}
