import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/resources_service.dart';
import 'package:app/app/service/storage_service/secure_storage_service.dart';
import 'package:app/bootstrap/sentry.dart';
import 'package:app/feature/presets_config/data/model/preset_config_type.dart';
import 'package:app/feature/presets_config/data/presets_config_exceptions.dart';
import 'package:app/http/api/presets/presets_api.dart';
import 'package:app/runner.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

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

  /// Get configuration of specified type
  /// Attempts to load from remote, then cache, then local fallback
  Future<T?> getConfig<T>(PresetConfigType<T> configType) async {
    return await _getRemoteConfig(configType) ??
        await _getCacheConfig(configType) ??
        await _getLocalConfig(configType);
  }

  Future<T?> _getCacheConfig<T>(PresetConfigType<T> configType) async {
    try {
      final cache = await _secureStorage.getConfigJson(configType);
      if (cache == null) return null;

      return configType.mapper(
        await jsonDecode(cache) as Map<String, dynamic>,
      );
    } catch (e, s) {
      _sentry.captureException(
        e is CachePresetsConfigException
            ? e
            : CachePresetsConfigException(e.toString(), configType.name),
        stackTrace: s,
      );
      _logger.severe('Error get ${configType.name} from cache', e, s);

      return null;
    }
  }

  Future<T?> _getLocalConfig<T>(PresetConfigType<T> configType) async {
    try {
      final cache = await _resourcesService.loadString(
        'assets/configs/${configType.name}.json',
      );

      if (cache.isEmpty) {
        throw LocalPresetsConfigException(
          'Error read local file',
          configType.name,
        );
      }

      return configType.mapper(
        await jsonDecode(cache) as Map<String, dynamic>,
      );
    } catch (e, s) {
      _sentry.captureException(
        e is LocalPresetsConfigException
            ? e
            : LocalPresetsConfigException(e.toString(), configType.name),
        stackTrace: s,
      );
      _logger.severe('Error get local config file', e, s);

      return null;
    }
  }

  Future<T?> _getRemoteConfig<T>(PresetConfigType<T> configType) async {
    try {
      final fileName = configType.getFileName(currentAppBuildType);
      final response = await _presetsApi.getPresetConfig(fileName);
      final str = response.data;

      unawaited(_updateCacheIfNeed(configType, str));

      return configType.mapper(jsonDecode(str) as Map<String, dynamic>);
    } catch (e, s) {
      _sentry.captureException(
        FetchPresetsConfigException(
          switch (e) {
            DioException() => '$e; data: ${e.response?.data}',
            _ => e.toString(),
          },
          configType.name,
        ),
        stackTrace: s,
      );
      _logger.severe('Error fetch ${configType.name}', e, s);
      return null;
    }
  }

  Future<void> _updateCacheIfNeed<T>(
    PresetConfigType<T> configType,
    String data,
  ) async {
    final currentSha256 = sha256.convert(utf8.encode(data)).toString();

    String? cachedSha256;

    try {
      cachedSha256 = await _secureStorage.getConfigJsonHash(configType);
    } catch (e, s) {
      _logger.severe('Error get hash', e, s);
    }

    if (currentSha256 == cachedSha256) {
      return;
    }

    try {
      await _secureStorage.setConfigJsonHash(configType, currentSha256);
    } catch (e, s) {
      _logger.severe('Error save hash', e, s);
    }

    try {
      await _secureStorage.setConfigJson(configType, data);
    } catch (e, s) {
      _logger.severe('Error save data', e, s);
    }
  }
}
