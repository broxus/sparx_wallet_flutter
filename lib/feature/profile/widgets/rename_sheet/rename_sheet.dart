import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/widgets/rename_sheet/rename_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';
// Cubit removed in favor of Elementary

/// Helper method to show the [RenameSheet] widget as a bottom sheet.
///
/// To rename seed phrase, put [renameSeed] true, else key will be renamed.
///
/// Snackbar will contains 'seed' if [renameSeed] is true and 'key' if false.
ModalRoute<void> showRenameSheet(
  BuildContext context,
  PublicKey publicKey, {
  bool renameSeed = false,
  bool isCustodian = false,
}) {
  return commonBottomSheetRoute(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.enterNewName.tr(),
    body: (_, __) => RenameSheet(
      publicKey: publicKey,
      renameSeed: renameSeed,
      isCustodian: isCustodian,
    ),
  );
}

/// Sheet that allows enter new name of the seed or public key.
/// This sheet automatically calls rename method for key/seed.
class RenameSheet extends InjectedElementaryParametrizedWidget<
    RenameSheetWidgetModel, RenameSheetParams> {
  RenameSheet({
    required PublicKey publicKey,
    required bool renameSeed,
    required bool isCustodian,
    super.key,
  }) : super(
          wmFactoryParam: RenameSheetParams(
            publicKey: publicKey,
            renameSeed: renameSeed,
            isCustodian: isCustodian,
          ),
        );

  @override
  Widget build(RenameSheetWidgetModel wm) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      spacing: DimensSize.d24,
      children: [
        PrimaryTextField(
          maxLength: maxLengthForMainEntities,
          textEditingController: wm.nameController,
          hintText: LocaleKeys.nameWord.tr(),
          onSubmit: wm.rename,
        ),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          onPressed: wm.rename,
          title: LocaleKeys.renameWord.tr(),
        ),
      ],
    );
  }
}
