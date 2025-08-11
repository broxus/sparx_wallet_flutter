import 'dart:collection';
import 'dart:ui';

import 'package:app/core/core.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:elementary_helper/elementary_helper.dart';

// typedef ImageCache = HashMap<String, String>;

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

/// Simple reactive in‑memory image cache (String -> String).
/// Mutate via add / addAll / remove / clear; listeners are notified on change.
class ImageCache implements ListenableState<Map<String, String>> {
  ImageCache() {
    _cache = HashMap<String, String>();
    _state = SafeStateNotifier(initValue: _cache);
  }

  late final Map<String, String> _cache;
  late final SafeStateNotifier<Map<String, String>> _state;

  @override
  Map<String, String>? get value => _state.value;

  @override
  void addListener(VoidCallback listener) => _state.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _state.removeListener(listener);

  void clear() {
    _cache.clear();
    _state.notifyListeners();
  }

  void add(String key, String value) {
    _cache[key] = value;
    _state.notifyListeners();
  }

  void addAll(Map<String, String> other) {
    _cache.addAll(other);
    _state.notifyListeners();
  }

  void remove(String key) {
    final removedValue = _cache.remove(key);
    if (removedValue != null) {
      _state.notifyListeners();
    }
  }

  String? get(String key) => _cache[key];

  void dispose() {
    _state.dispose();
  }
}
