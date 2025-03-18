import 'package:app/generated/generated.dart';

enum TypeHistory { browsingHistory, cookie, cachedImages }

extension TypeHistoryExtension on TypeHistory {
  String get displayName {
    switch (this) {
      case TypeHistory.browsingHistory:
        return 'Browsing history';
      case TypeHistory.cookie:
        return 'Cookie, site data';
      case TypeHistory.cachedImages:
        return 'Cached images and files';
    }
  }

  String get description {
    switch (this) {
      case TypeHistory.browsingHistory:
        return 'Clears all browsing history ';
      case TypeHistory.cookie:
        return 'Most sites will log you out';
      case TypeHistory.cachedImages:
        return 'Less than 1 MB';
    }
  }

  String get icon {
    switch (this) {
      case TypeHistory.browsingHistory:
        return Assets.images.historyFill.path;
      case TypeHistory.cookie:
        return Assets.images.key.path;
      case TypeHistory.cachedImages:
        return Assets.images.camera.path;
    }
  }
}
