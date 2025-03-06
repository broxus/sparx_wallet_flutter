import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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

  IconData get icon {
    switch (this) {
      case TypeHistory.browsingHistory:
        return LucideIcons.clock;
      case TypeHistory.cookie:
        return LucideIcons.key;
      case TypeHistory.cachedImages:
        return LucideIcons.camera;
    }
  }
}
