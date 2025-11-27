import 'package:app/app/service/database/database_service.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browser/data/history_type.dart';
import 'package:app/feature/browser/domain/delegates/browser_base_delegate.dart';
import 'package:injectable/injectable.dart';

abstract interface class BrowserServiceHistory {
  Stream<List<BrowserHistoryItem>> watchHistory([String? searchText]);

  Stream<int> watchHistoryCount();

  Future<BrowserHistoryItem?> getHistoryItemById(String id);

  Future<List<BrowserHistoryItem>> getItems([String? searchText]);

  void createHistoryItem(Uri url);

  void removeHistoryItemByUri(Uri uri);

  void removeHistoryItem(String id);
}

@injectable
class BrowserServiceHistoryDelegate
    implements BrowserDelegate, BrowserServiceHistory {
  BrowserServiceHistoryDelegate(this._databaseService);

  late final DatabaseService _databaseService;

  /// Get last cached browser history items
  @override
  Stream<List<BrowserHistoryItem>> watchHistory([String? searchText]) =>
      _databaseService.history.watchHistory(searchText);

  /// Get last cached browser history items
  @override
  Stream<int> watchHistoryCount() =>
      _databaseService.history.watchHistoryCount();

  @override
  Future<BrowserHistoryItem?> getHistoryItemById(String id) =>
      _databaseService.history.getHistoryItemById(id);

  @override
  Future<List<BrowserHistoryItem>> getItems([String? searchText]) =>
      _databaseService.history.getItems(searchText);

  Future<void> clear() {
    return clearHistory();
  }

  @override
  Future<void> createHistoryItem(Uri url) {
    return _databaseService.history.saveHistoryItem(
      BrowserHistoryItem.create(url: url),
    );
  }

  @override
  Future<void> removeHistoryItem(String id) {
    return _databaseService.history.deleteHistoryItem(id);
  }

  @override
  Future<void> removeHistoryItemByUri(Uri uri) {
    return _databaseService.history.deleteHistoryItemByUri(uri);
  }

  Future<void> clearHistory([TimePeriod period = TimePeriod.allHistory]) async {
    if (period == TimePeriod.allHistory) {
      await _databaseService.history.clearHistory();
      return;
    }
    final higher = DateTime.now();
    final lower = switch (period) {
      TimePeriod.lastHour => higher.subtract(const Duration(hours: 1)),
      TimePeriod.today => DateTime(higher.year, higher.month, higher.day),
      TimePeriod.todayYesterday => DateTime(
        higher.year,
        higher.month,
        higher.day - 1,
      ),
      TimePeriod.allHistory => DateTime.fromMillisecondsSinceEpoch(0),
    };

    return _databaseService.history.clearHistoryByDates(lower, higher);
  }
}
