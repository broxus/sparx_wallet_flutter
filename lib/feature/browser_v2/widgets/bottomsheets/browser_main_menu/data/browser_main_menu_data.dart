import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum BrowserMainMenuData {
  clearHistory(
    LucideIcons.trash2,
  ),
  newTab(
    LucideIcons.squarePlus,
  ),
  reload(
    LucideIcons.refreshCw,
  ),
  translatePage(
    LucideIcons.sparkles,
  ),
  addBookmark(
    LucideIcons.bookmarkPlus,
  );

  const BrowserMainMenuData(this.icon);

  final IconData icon;
}

extension BrowserMainMenuDataExtension on BrowserMainMenuData {
  String get title {
    return switch (this) {
      BrowserMainMenuData.clearHistory => LocaleKeys.browserHistoryClear.tr(),
      BrowserMainMenuData.newTab => LocaleKeys.newTab.tr(),
      BrowserMainMenuData.reload => LocaleKeys.browserRefresh.tr(),
      BrowserMainMenuData.translatePage => LocaleKeys.browserTranslatePage.tr(),
      BrowserMainMenuData.addBookmark => LocaleKeys.browserAddBookmark.tr(),
    };
  }
}
