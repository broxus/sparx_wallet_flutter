import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browserV2/service/storages/browser_history_storage_service.dart';
import 'package:rxdart/rxdart.dart';

class HistoryManager {
  HistoryManager(this._browserHistoryStorageService);

  /// Limit of browser history items
  static const _historyItemCountLimit = 200;

  final BrowserHistoryStorageService _browserHistoryStorageService;

  /// Subject of browser history items
  final _browserHistorySubject = BehaviorSubject<List<BrowserHistoryItem>>();

  /// Stream of browser history items
  Stream<List<BrowserHistoryItem>> get browserHistoryStream =>
      _browserHistorySubject;

  /// Get last cached browser history items
  List<BrowserHistoryItem> get browserHistoryItems =>
      _browserHistorySubject.valueOrNull ?? [];

  void init() {
    _fetchHistoryFromStorage();
  }

  Future<void> clear() {
    return clearHistory();
  }

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

  void removeHistoryItem(String id) {
    _saveBrowserHistory(
      [...browserHistoryItems]..removeWhere((item) => item.id == id),
    );
  }

  Future<void> clearHistory() async {
    await _browserHistoryStorageService.clearBrowserHistory();
    _browserHistorySubject.add([]);
  }

  void _fetchHistoryFromStorage() => _browserHistorySubject.add(
        _browserHistoryStorageService.getBrowserHistory()
          ..sort(
            (a, b) => b.visitTime.compareTo(a.visitTime),
          ),
      );

  void _saveBrowserHistory(List<BrowserHistoryItem> history) {
    final sortedHistory = [...history]
      ..sort(
        (a, b) => b.visitTime.compareTo(a.visitTime),
      )
      ..take(_historyItemCountLimit);
    _browserHistoryStorageService.saveBrowserHistory(sortedHistory);

    _browserHistorySubject.add(sortedHistory);
  }
}
