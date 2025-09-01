import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browser_v2/data/history_type.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_base_delegate.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_history_storage_service.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/ui_models/time_period_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class BrowserServiceHistory {
  Stream<List<BrowserHistoryItem>> get browserHistoryStream;

  List<BrowserHistoryItem> get browserHistoryItems;

  void createHistoryItem(Uri url);

  void removeHistoryItemByUri(Uri uri);

  void removeHistoryItem(String id);
}

@injectable
class BrowserServiceHistoryDelegate
    implements BrowserDelegate, BrowserServiceHistory {
  BrowserServiceHistoryDelegate(this._browserHistoryStorageService);

  /// Limit of browser history items
  static const _historyItemCountLimit = 100;

  final BrowserHistoryStorageService _browserHistoryStorageService;

  /// Subject of browser history items
  final _browserHistorySubject = BehaviorSubject<List<BrowserHistoryItem>>();

  /// Stream of browser history items
  @override
  Stream<List<BrowserHistoryItem>> get browserHistoryStream =>
      _browserHistorySubject;

  /// Get last cached browser history items
  @override
  List<BrowserHistoryItem> get browserHistoryItems =>
      _browserHistorySubject.valueOrNull ?? [];

  void init() {
    _fetchHistoryFromStorage();
  }

  Future<void> clear() {
    return clearHistory();
  }

  @override
  void createHistoryItem(Uri url) {
    if (url.host.isEmpty || browserHistoryItems.firstOrNull?.url == url) {
      return;
    }
    _saveBrowserHistory(
      [
        BrowserHistoryItem.create(url: url),
        ...browserHistoryItems,
      ],
    );
  }

  @override
  void removeHistoryItem(String id) {
    _saveBrowserHistory(
      [...browserHistoryItems]..removeWhere((item) => item.id == id),
    );
  }

  @override
  void removeHistoryItemByUri(Uri uri) {
    _saveBrowserHistory(
      [...browserHistoryItems]..removeWhere((item) => item.url == uri),
    );
  }

  Future<void> clearHistory([
    TimePeriod period = TimePeriod.allHistory,
  ]) async {
    if (period == TimePeriod.allHistory) {
      await _browserHistoryStorageService.clear();
      _browserHistorySubject.add([]);
      return;
    }

    final items = [...browserHistoryItems];

    final result = <BrowserHistoryItem>[];

    final date = period.date;

    for (final item in items) {
      if (item.visitTime.isAfter(date)) {
        continue;
      }

      result.add(item);
    }

    _saveBrowserHistory(result);
  }

  void _fetchHistoryFromStorage() => _browserHistorySubject.add(
        _browserHistoryStorageService.getBrowserHistory(),
      );

  void _saveBrowserHistory(List<BrowserHistoryItem> history) {
    final sortedHistory = [...history]..take(_historyItemCountLimit);
    _browserHistoryStorageService.saveBrowserHistory(sortedHistory);

    _browserHistorySubject.add(sortedHistory);
  }
}
