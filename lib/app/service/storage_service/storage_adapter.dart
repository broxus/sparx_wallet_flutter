import 'dart:ui';

import 'package:app/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

/// Abstraction over the underlying key-value storage implementation.
///
/// Implementations should be lightweight and safe to use across the app.
abstract interface class StorageAdapter {
  /// Initializes storage for the optional [container].
  ///
  /// Call this before using [box].
  Future<void> init([String? container]);

  /// Returns a [StorageBox] instance for the given [container].
  ///
  /// [path] and [initialData] are passed to the underlying storage engine
  /// (if supported) for custom location and seed values.
  StorageBox box([
    String? container,
    String? path,
    Map<String, dynamic>? initialData,
  ]);
}

/// A typed facade for a key-value storage container.
abstract interface class StorageBox {
  /// Map of storage changes exposed by the underlying engine.
  ///
  /// The contents and format are implementation-specific.
  Map<String, dynamic> get changes;

  /// Returns all entries currently stored in this box.
  Map<String, dynamic> getEntries();

  /// Reads the value associated with [key] and casts it to [T].
  ///
  /// Returns `null` when the key is missing or value is not set.
  T? read<T>(String key);

  /// Writes [value] under [key].
  Future<void> write(String key, dynamic value);

  /// Removes the entry for [key], if present.
  Future<void> remove(String key);

  /// Clears all stored entries in this box.
  Future<void> erase();

  /// Returns `true` when [key] exists in storage.
  bool hasData(String key);

  /// Subscribes to storage changes and returns a disposer callback.
  VoidCallback listen(VoidCallback value);
}

@Singleton(as: StorageAdapter)
class GetStorageAdapter implements StorageAdapter {
  const GetStorageAdapter();

  @override
  Future<void> init([String? container]) =>
      container != null ? GetStorage.init(container) : GetStorage.init();

  @override
  StorageBox box([
    String? container,
    String? path,
    Map<String, dynamic>? initialData,
  ]) => container != null
      ? _GetStorageBox(GetStorage(container, path, initialData))
      : _GetStorageBox(GetStorage());
}

class _GetStorageBox implements StorageBox {
  _GetStorageBox(this._storage);

  final GetStorage _storage;

  @override
  Map<String, dynamic> get changes => _storage.changes;

  @override
  Map<String, dynamic> getEntries() => _storage.getEntries();

  @override
  T? read<T>(String key) => _storage.read<T>(key);

  @override
  Future<void> write(String key, dynamic value) => _storage.write(key, value);

  @override
  Future<void> remove(String key) => _storage.remove(key);

  @override
  Future<void> erase() => _storage.erase();

  @override
  bool hasData(String key) => _storage.hasData(key);

  @override
  VoidCallback listen(VoidCallback value) => _storage.listen(value);
}
