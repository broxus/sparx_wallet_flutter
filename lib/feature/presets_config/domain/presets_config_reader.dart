import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/resources_service.dart';
import 'package:app/app/service/storage_service/secure_storage_service.dart';
import 'package:app/core/sentry.dart';
import 'package:app/feature/presets_config/data/preset_config_type.dart';
import 'package:app/feature/presets_config/data/presets_config_exceptions.dart';
import 'package:app/http/api/presets/presets_api.dart';
import 'package:app/runner.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

/// Enum representing the different sources of configuration data
enum _ConfigSource {
  /// Remote source (API)
  remote,

  /// Cached source (secure storage)
  cache,

  /// Local source (bundled assets)
  local,
}

/// Class for loading different types of configuration
/// Supports loading from remote, cache, and local sources
@singleton
class PresetsConfigReader {
  PresetsConfigReader(
    this._presetsApi,
    this._secureStorage,
    this._resourcesService,
  );

  static final _logger = Logger('PresetsConfigReader');

  final PresetsApi _presetsApi;
  final SecureStorageService _secureStorage;
  final ResourcesService _resourcesService;
  final _sentry = SentryWorker.instance;

  final Map<PresetConfigType<dynamic>, Future<void>> _pendingCacheUpdates = {};

  /// Get configuration of specified type
  /// Attempts to load from remote, then cache, then local fallback
  Future<T?> getConfig<T>(PresetConfigType<T> configType) async {
    await awaitPendingUpdate(configType);

    return await _getConfigFromSource(configType, _ConfigSource.remote) ??
        await _getConfigFromSource(configType, _ConfigSource.cache) ??
        await _getConfigFromSource(configType, _ConfigSource.local);
  }

  Future<T?> _getConfigFromSource<T>(
    PresetConfigType<T> configType,
    _ConfigSource source,
  ) async {
    try {
      final rawData = await switch (source) {
        _ConfigSource.remote => _fetchRemoteData(configType),
        _ConfigSource.cache => _secureStorage.getConfigJson(configType),
        _ConfigSource.local => _fetchLocalData(configType),
      };

      if (rawData == null || rawData.isEmpty) {
        _logger.fine('No ${source.name} data for ${configType.name}');
        return null;
      }

      final decoded = jsonDecode(rawData);
      if (decoded is! Map<String, dynamic>) {
        throw Exception(
          'Invalid config format from ${source.name},'
          ' expected Map<String, dynamic>',
        );
      }

      if (source == _ConfigSource.remote) {
        _pendingCacheUpdates[configType] = _performCacheUpdate(
          configType,
          rawData,
        );
      }

      return configType.mapper(decoded);
    } catch (e, s) {
      _logger.severe(
        'Error parsing ${source.name} config for ${configType.name}',
        e,
        s,
      );

      if (source == _ConfigSource.cache) await _cleanUpCache(configType);

      final exception = _constructConfigException(e, source, configType);

      _sentry.captureException(exception, stackTrace: s);
      _logger.severe(
        'Error getting ${source.name} config for ${configType.name}',
        e,
        s,
      );

      return null;
    }
  }

  PresetsConfigException _constructConfigException(
    Object e,
    _ConfigSource source,
    PresetConfigType<dynamic> configType,
  ) {
    final errorMessage = switch (e) {
      DioException() => '$e; data: ${e.response?.data}',
      _ => e.toString(),
    };

    final exception = switch (source) {
      _ConfigSource.remote => FetchPresetsConfigException(
          errorMessage,
          configType.name,
        ),
      _ConfigSource.cache => CachePresetsConfigException(
          errorMessage,
          configType.name,
        ),
      _ConfigSource.local => LocalPresetsConfigException(
          errorMessage,
          configType.name,
        ),
    };
    return exception;
  }

  Future<String?> _fetchRemoteData<T>(PresetConfigType<T> configType) async {
    final fileName = configType.getFileName(currentAppBuildType);
    final response = await _presetsApi.getPresetConfig(fileName);
    return response.data;
  }

  Future<String?> _fetchLocalData<T>(PresetConfigType<T> configType) {
    return _resourcesService.loadString(configType.getLocalFileName());
  }

  Future<void> _performCacheUpdate<T>(
    PresetConfigType<T> configType,
    String data,
  ) async {
    try {
      final currentSha256 = sha256.convert(utf8.encode(data)).toString();
      final cachedSha256 = await _secureStorage.getConfigJsonHash(configType);

      if (currentSha256 == cachedSha256) {
        _logger.fine('Cache is up to date for ${configType.name}');
        return;
      }

      // Update the data first, then the hash
      await _secureStorage.setConfigJson(configType, data);
      await _secureStorage.setConfigJsonHash(configType, currentSha256);

      _logger.fine('Updated cache for ${configType.name}');
    } catch (e, s) {
      _logger.severe('Error updating cache for ${configType.name}', e, s);

      _sentry.captureException(
        CachePresetsConfigException(
          'Failed to update cache: $e.toString()',
          configType.name,
        ),
        stackTrace: s,
      );
    } finally {
      // Remove this operation from pending updates
      final _ = _pendingCacheUpdates.remove(configType);
    }
  }

  Future<void> _cleanUpCache<T>(
    PresetConfigType<T> configType,
  ) async {
    try {
      await _secureStorage.setConfigJson(configType, '');
      await _secureStorage.setConfigJsonHash(configType, '');
    } catch (e, s) {
      _logger.severe('Error cleanup cache for ${configType.name}', e, s);
    }
  }

  @visibleForTesting
  Future<void> awaitPendingUpdate<T>(PresetConfigType<T> configType) async {
    final pendingUpdate = _pendingCacheUpdates[configType];
    if (pendingUpdate != null) {
      await pendingUpdate;
    }
  }
}
