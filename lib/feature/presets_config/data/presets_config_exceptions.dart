/// Base exception for presets configuration errors.
/// 
/// Provides context about which configuration type encountered an issue.
class PresetsConfigException implements Exception {
  PresetsConfigException(this.message, this.configType);

  /// Detailed error message describing what went wrong.
  final String message;

  /// Identifier for which configuration type encountered the error.
  final String configType;

  @override
  String toString() {
    return 'PresetsConfigException(configType: $configType, message: $message)';
  }
}

/// Exception thrown when fetching configuration from remote source fails.
class FetchPresetsConfigException extends PresetsConfigException {
  FetchPresetsConfigException(super.message, super.configType);
}

/// Exception thrown when retrieving or storing configuration in cache fails.
class CachePresetsConfigException extends PresetsConfigException {
  CachePresetsConfigException(super.message, super.configType);
}

/// Exception thrown when loading configuration from local bundled assets fails.
class LocalPresetsConfigException extends PresetsConfigException {
  LocalPresetsConfigException(super.message, super.configType);
}
