import 'dart:collection';

import 'package:app/core/core.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';

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
    _notifier = _ImmutableStateNotifier(_cache);
  }

  final _cache = HashMap<String, String>();
  late final _ImmutableStateNotifier<Map<String, String>> _notifier;

  @override
  Map<String, String>? get value => _notifier.value;

  @override
  void addListener(VoidCallback listener) => _notifier.addListener(listener);

  @override
  void removeListener(VoidCallback listener) =>
      _notifier.removeListener(listener);

  void clear() {
    _cache.clear();
    _notifier.notifyListeners();
  }

  void add(String key, String value) {
    _cache[key] = value;
    _notifier.notifyListeners();
  }

  void addAll(Map<String, String> other) {
    _cache.addAll(other);
    _notifier.notifyListeners();
  }

  void remove(String key) {
    final removedValue = _cache.remove(key);
    if (removedValue != null) {
      _notifier.notifyListeners();
    }
  }

  String? get(String key) => _cache[key];

  void dispose() {
    _notifier.dispose();
  }
}

class _ImmutableStateNotifier<T> extends SafeStateNotifier<T> {
  _ImmutableStateNotifier(T initValue) : super(initValue: initValue);

  @override
  @protected
  void accept(T? newValue) => throw UnsupportedError(
        'This StateNotifier is immutable and cannot accept new values.',
      );
}
