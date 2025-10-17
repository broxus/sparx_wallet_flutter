import 'package:app/generated/generated.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum BrowserBookTabBarValue {
  bookMarks(LucideIcons.bookmark),
  history(LucideIcons.history);

  const BrowserBookTabBarValue(this.icon);

  final IconData icon;
}

extension BrowserBookTabBarValueExtension on BrowserBookTabBarValue {
  String get title => switch (this) {
    BrowserBookTabBarValue.bookMarks => LocaleKeys.browserBookmarks.tr(),
    BrowserBookTabBarValue.history => LocaleKeys.browserHistory.tr(),
  };
}
