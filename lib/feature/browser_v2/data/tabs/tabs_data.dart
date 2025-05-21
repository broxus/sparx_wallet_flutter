import 'dart:collection';

import 'package:app/feature/browser_v2/data/browser_collection.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';

typedef ImageCache = HashMap<String, String>;

class BrowserTabsCollection extends BrowserCollection<BrowserTab> {
  BrowserTabsCollection.empty() : _prevCount = 0;

  BrowserTabsCollection.fromList(List<BrowserTab> super.list)
      : _prevCount = list.length;

  BrowserTabsCollection._([
    super.list,
    int? prevCount,
  ]) : _prevCount = prevCount ?? list?.length ?? 0;

  final int _prevCount;

  BrowserTab? get lastTab => list.lastOrNull;

  BrowserTabsCollection update(List<BrowserTab> list) {
    return BrowserTabsCollection._(list, count);
  }

  int getIndexById(String id) => list.indexWhere((item) => item.id == id);

  String? getIdByIndex(int index) {
    try {
      return list[index].id;
    } catch (_) {
      return null;
    }
  }

  bool get isCountIncreased => count > _prevCount;
}

extension ImageCacheHashMap on HashMap<String, String> {
  void add(String key, String value) {
    this[key] = value;
  }

  String? get(String key) => this[key];

  // ignore: use_to_and_as_if_applicable
  HashMap<String, String> copy() => HashMap<String, String>.of(this);
}
