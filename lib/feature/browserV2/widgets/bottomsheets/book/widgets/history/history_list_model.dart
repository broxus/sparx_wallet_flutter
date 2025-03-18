import 'package:app/app/service/localization/service/localization_service.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browserV2/data/history_type.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/history/history_list.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [HistoryList]
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
      _browserService.hM.browserHistoryStream;

  List<BrowserHistoryItem> get originalBrowserHistoryItems =>
      _browserService.hM.browserHistoryItems;

  bool get isExistHistory => originalBrowserHistoryItems.isNotEmpty;

  void requestUrl(Uri uri) {
    _browserService.tM.requestUrlActiveTab(uri);
  }

  void removeHistory(String id) => _browserService.hM.removeHistoryItem(id);

  void clearData(TimePeriod period, Set<TypeHistory> targets) {
    _browserService.clearData(period, targets);
  }
}
