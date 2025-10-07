import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/key_detail/widgets/account_rename_sheet/account_rename_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function to show [AccountRenameSheet].
ModalRoute<void> getRenameAccountSheet(BuildContext context, Address address) {
  return commonBottomSheetRoute(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.enterNewName.tr(),
    body: (_, __) => AccountRenameSheet(address: address),
  );
}

class AccountRenameSheet extends InjectedElementaryParametrizedWidget<
    AccountRenameSheetWidgetModel, Address> {
  const AccountRenameSheet({
    required Address address,
    super.key,
  }) : super(wmFactoryParam: address);

  @override
  Widget build(AccountRenameSheetWidgetModel wm) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      spacing: DimensSize.d16,
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
          onSubmit: wm.renameAccount,
        ),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.renameWord.tr(),
          onPressed: wm.renameAccount,
        ),
      ],
    );
  }
}
