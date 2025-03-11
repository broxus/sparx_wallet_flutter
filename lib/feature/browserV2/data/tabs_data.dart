import 'dart:collection';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';

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
