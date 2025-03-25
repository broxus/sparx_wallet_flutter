class PresetsConfigException implements Exception {
  PresetsConfigException(this.message, this.configType);

  final String message;
  final String configType;

  @override
  String toString() {
    return 'PresetsConfigException(configType: $configType, message: $message)';
  }
}

class FetchPresetsConfigException extends PresetsConfigException {
  FetchPresetsConfigException(super.message, super.configType);
}

class CachePresetsConfigException extends PresetsConfigException {
  CachePresetsConfigException(super.message, super.configType);
}

class LocalPresetsConfigException extends PresetsConfigException {
  LocalPresetsConfigException(super.message, super.configType);
}
