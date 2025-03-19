import 'package:app/feature/browserV2/data/history_type.dart';
import 'package:app/generated/generated.dart';

extension TypeHistoryExtension on TypeHistory {
  String get displayName {
    switch (this) {
      case TypeHistory.browsingHistory:
        return LocaleKeys.browsingHistory.tr();
      case TypeHistory.cookie:
        return LocaleKeys.browserClearCookies.tr();
      case TypeHistory.cachedImages:
        return LocaleKeys.browserClearCache.tr();
    }
  }

  String get description {
    switch (this) {
      case TypeHistory.browsingHistory:
        return LocaleKeys.clearAllBrowsingHistory.tr();
      case TypeHistory.cookie:
        return LocaleKeys.browserClearCookiesDescription.tr();
      case TypeHistory.cachedImages:
        return '';
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
