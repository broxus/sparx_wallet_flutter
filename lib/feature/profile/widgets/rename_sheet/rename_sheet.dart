import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/widgets/rename_sheet/rename_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';
// Cubit removed in favor of Elementary

/// Helper method to show the [RenameSheet] widget as a bottom sheet.
///
/// To rename seed phrase, put [isSeed] true, else key will be renamed.
///
/// Snackbar will contains 'seed' if [isSeed] is true and 'key' if false.
ModalRoute<void> showRenameSheet({
  required BuildContext context,
  required PublicKey publicKey,
  bool isSeed = false,
  bool isCustodian = false,
}) {
  return commonBottomSheetRoute(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.enterNewName.tr(),
    body: (_, __) => RenameSheet(
      publicKey: publicKey,
      isSeed: isSeed,
      isCustodian: isCustodian,
    ),
  );
}

/// Sheet that allows enter new name of the seed or public key.
/// This sheet automatically calls rename method for key/seed.
class RenameSheet
    extends
        InjectedElementaryParametrizedWidget<
          RenameSheetWidgetModel,
          RenameSheetParams
        > {
  RenameSheet({
    required PublicKey publicKey,
    required bool isSeed,
    required bool isCustodian,
    super.key,
  }) : super(
         wmFactoryParam: RenameSheetParams(
           publicKey: publicKey,
           isSeed: isSeed,
           isCustodian: isCustodian,
         ),
       );

  @override
  Widget build(RenameSheetWidgetModel wm) {
    return KeyboardPadding(
      bottom: DimensSizeV2.d24,
      child: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        spacing: DimensSize.d24,
        children: [
          PrimaryTextField(
            isAutofocus: true,
            maxLength: maxLengthForMainEntities,
            textEditingController: wm.nameController,
            hintText: LocaleKeys.nameWord.tr(),
            suffixes: [
              ValueListenableBuilder(
                valueListenable: wm.nameController,
                builder: (_, value, __) => value.text.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(right: DimensSizeV2.d8),
                        child: PrimaryButton(
                          icon: LucideIcons.x,
                          buttonShape: ButtonShape.square,
                          buttonSize: ButtonSize.small,
                          onPressed: wm.nameController.clear,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
            onSubmit: wm.rename,
          ),
          PrimaryButton(
            buttonShape: ButtonShape.pill,
            onPressed: wm.rename,
            title: LocaleKeys.renameWord.tr(),
          ),
        ],
      ),
    );
  }
}
