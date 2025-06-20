import 'dart:collection';

import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';

typedef ImageCache = HashMap<String, String>;

extension BrowserTabsCollectionExtension on List<BrowserTab> {
  BrowserTab? get lastTab => lastOrNull;

  String get countText => length.toString();

  int getIndexById(String id) => indexWhere((item) => item.id == id);

  String? getIdByIndex(int index) {
    try {
      return this[index].id;
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
