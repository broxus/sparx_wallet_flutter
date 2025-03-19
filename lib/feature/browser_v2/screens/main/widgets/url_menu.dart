import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/components/common/container/primary_shaped_container_column.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

Future<BrowserUrlMenuValue?> showUrlMenu(BuildContext context) {
  return showPrimaryBottomSheet(
    context: context,
    padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d24),
    content: const UrlMenu(),
  );
}

class UrlMenu extends StatelessWidget {
  const UrlMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryShapedContainerColumn(
      children: [
        PrimaryShapedContainerItem(
          title: LocaleKeys.copyUrl.tr(),
          icon: LucideIcons.copy,
          onPressed: () =>
              Navigator.of(context).pop(BrowserUrlMenuValue.copyUrl),
        ),
        PrimaryShapedContainerItem(
          title: LocaleKeys.browserAddBookmark.tr(),
          icon: LucideIcons.bookmarkPlus,
          onPressed: () =>
              Navigator.of(context).pop(BrowserUrlMenuValue.addBookmark),
        ),
        PrimaryShapedContainerItem(
          title: LocaleKeys.clearFromHistory.tr(),
          icon: LucideIcons.trash2,
          onPressed: () =>
              Navigator.of(context).pop(BrowserUrlMenuValue.clearFromHistory),
          // TODO(knightforce): move to colors
          iconColor: const Color(0xFFFF2D55),
        ),
      ],
    );
  }
}

enum BrowserUrlMenuValue {
  copyUrl,
  addBookmark,
  clearFromHistory,
}
