import 'dart:collection';

import 'package:app/feature/browser_v2/data/browser_tab.dart';

typedef ImageCache = HashMap<String, String>;

class BrowserTabsCollection {
  BrowserTabsCollection([List<BrowserTab>? list]) : list = list ?? [];

  final List<BrowserTab> list;

  int get count => list.length;

  String get countText => count.toString();

  bool get isNotEmpty => list.isNotEmpty;

  BrowserTab? get lastTab => list.lastOrNull;

  int getIndexById(String id) => list.indexWhere((item) => item.id == id);

  String? getIdByIndex(int index) {
    try {
      return list[index].id;
    } catch (_) {
      return null;
    }
  }
}

extension ImageCacheHashMap on HashMap<String, String> {
  void add(String key, String value) {
    this[key] = value;
  }

  String? get(String key) => this[key];

  // ignore: use_to_and_as_if_applicable
  HashMap<String, String> copy() => HashMap<String, String>.of(this);
}
