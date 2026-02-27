import 'dart:ui';

import 'package:app/app/service/storage_service/storage_adapter.dart';

class InMemoryStorageAdapter implements StorageAdapter {
  final Map<String, InMemoryStorageBox> _boxes = {};

  @override
  Future<void> init([String? container]) async {
    // No initialization needed for in-memory storage
  }

  @override
  StorageBox box([
    String? container,
    String? path,
    Map<String, dynamic>? initialData,
  ]) => _boxes.putIfAbsent(
    container ?? 'InMemoryStorage',
    () => InMemoryStorageBox(initialData: initialData),
  );
}

class InMemoryStorageBox implements StorageBox {
  InMemoryStorageBox({Map<String, dynamic>? initialData})
    : _data = Map<String, dynamic>.from(initialData ?? <String, dynamic>{});

  final Map<String, dynamic> _data;
  final Map<String, dynamic> _changes = {};
  final List<VoidCallback> _listeners = [];

  @override
  Map<String, dynamic> get changes => Map<String, dynamic>.from(_changes);

  @override
  Map<String, dynamic> getEntries() => Map<String, dynamic>.from(_data);

  @override
  T? read<T>(String key) => _data[key] as T?;

  @override
  Future<void> write(String key, dynamic value) async {
    _data[key] = value;
    _changes[key] = value;
    _notifyListeners();
  }

  @override
  Future<void> remove(String key) async {
    _data.remove(key);
    _changes[key] = null;
    _notifyListeners();
  }

  @override
  Future<void> erase() async {
    for (final key in _data.keys.toList()) {
      _changes[key] = null;
    }
    _data.clear();
    _notifyListeners();
  }

  @override
  bool hasData(String key) {
    return _data.containsKey(key);
  }

  @override
  VoidCallback listen(VoidCallback value) {
    _listeners.add(value);
    return () {
      _listeners.remove(value);
    };
  }

  void _notifyListeners() {
    for (final listener in List<VoidCallback>.from(_listeners)) {
      listener();
    }
  }
}
