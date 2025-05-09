import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

enum BrowserTabMenuItemData {
  copyLink(
    icon: LucideIcons.copy,
  ),
  pinTab(
    icon: LucideIcons.pin,
  ),
  bookmark(
    icon: LucideIcons.bookmark,
  ),
  newTabGroup(
    icon: LucideIcons.plus,
  );

  const BrowserTabMenuItemData({
    required this.icon,
  });

  final IconData icon;
}

extension BrowserTabMenuItemDataExtension on BrowserTabMenuItemData {
  String get title => switch (this) {
        BrowserTabMenuItemData.copyLink => LocaleKeys.copyLink.tr(),
        BrowserTabMenuItemData.pinTab => LocaleKeys.pinTab.tr(),
        BrowserTabMenuItemData.bookmark => LocaleKeys.bookmark.tr(),
        BrowserTabMenuItemData.newTabGroup => LocaleKeys.newTabGroup.tr(),
      };
}
