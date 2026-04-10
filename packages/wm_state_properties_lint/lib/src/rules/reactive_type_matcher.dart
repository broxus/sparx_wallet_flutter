class ReactiveTypeMatcher {
  const ReactiveTypeMatcher._();

  static bool isNotifierOrListenableType(String type) {
    return type.contains('ValueNotifier') ||
        type.contains('ValueListenable') ||
        type.contains('StateNotifier') ||
        type.contains('ListenableState') ||
        type.contains('EntityStateNotifier');
  }

  static bool isStreamType(String type) {
    return type.contains('Stream') ||
        type.contains('StreamController') ||
        type.contains('BehaviorSubject');
  }

  static bool isReactiveType(String type) {
    return isNotifierOrListenableType(type) || isStreamType(type);
  }

  static bool hasValidNotifierSuffix(String name) {
    return name.endsWith('State') ||
        name.endsWith('Notifier') ||
        name.endsWith('Stream');
  }

  static String suggestNotifierName(String name) {
    if (hasValidNotifierSuffix(name)) {
      return name;
    }

    return '${name}State';
  }

  static bool hasValidStreamSuffix(String name) {
    return name.endsWith('Stream');
  }

  static String suggestStreamName(String name) {
    if (hasValidStreamSuffix(name)) {
      return name;
    }

    return '${name}Stream';
  }

  static bool isWmFilePath(String path) => path.endsWith('_wm.dart');
}
