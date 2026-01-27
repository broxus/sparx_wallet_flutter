import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browser/widgets/bottomsheets/rename_bookmark/browser_bookmark_rename_bottom_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [BrowserBookmarkRenameBottomSheet].
ModalRoute<void> showBrowserBookmarkRenameSheet({
  required BrowserBookmarkItem item,
  TextStyle? titleTextStyle,
}) {
  return commonBottomSheetRoute(
    title: LocaleKeys.browserBookmarkRenameEnterName.tr(),
    titleTextStyle: titleTextStyle,
    titleMargin: const EdgeInsets.only(
      top: DimensSize.d32,
      bottom: DimensSize.d24,
      left: DimensSize.d16,
      right: DimensSize.d16,
    ),
    body: (_, __) => BrowserBookmarkRenameBottomSheet(item: item),
  );
}

class BrowserBookmarkRenameBottomSheet
    extends
        InjectedElementaryParametrizedWidget<
          BrowserBookmarkRenameBottomSheetWidgetModel,
          BrowserBookmarkItem
        > {
  const BrowserBookmarkRenameBottomSheet({
    required BrowserBookmarkItem item,
    super.key,
  }) : super(wmFactoryParam: item);

  @override
  Widget build(BrowserBookmarkRenameBottomSheetWidgetModel wm) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      spacing: DimensSize.d24,
      children: [
        PrimaryTextField(
          textEditingController: wm.nameController,
          hintText: LocaleKeys.browserBookmarkRenameName.tr(),
          onSubmit: (_) => wm.onRename(),
        ),
        StateNotifierBuilder<bool>(
          listenableState: wm.isCanEditedState,
          builder: (_, bool? isCanEdited) {
            return PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.browserBookmarkRenameWord.tr(),
              onPressed: (isCanEdited ?? false) ? wm.onRename : null,
            );
          },
        ),
      ],
    );
  }
}
