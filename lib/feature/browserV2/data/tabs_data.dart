import 'dart:collection';

import 'package:app/feature/browserV2/models/tab/browser_tab.dart';

class BrowserTabsCollection {
  BrowserTabsCollection([List<BrowserTab>? list]) : list = list ?? [];

  final List<BrowserTab> list;

  late final sortedList = [...list]..sort(
      (a, b) => a.sortingOrder.compareTo(b.sortingOrder),
    );

  int get count => list.length;

  String get countText => count.toString();
}

class ImageCache {
  ImageCache([
    HashMap<String, String>? cache,
  ]) : _cache = cache ?? HashMap<String, String>();
  final HashMap<String, String> _cache;

  void add(String key, String value) {
    _cache[key] = value;
  }

  String? get(String key) => _cache[key];

  ImageCache copy() => ImageCache(_cache);
}
