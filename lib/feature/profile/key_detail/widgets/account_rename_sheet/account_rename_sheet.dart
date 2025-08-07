import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/key_detail/widgets/account_rename_sheet/account_rename_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';
import 'package:ui_components_lib/v2/widgets/buttons/primary_button.dart';
import 'package:ui_components_lib/v2/widgets/text_fields/primary_text_field.dart';

/// Helper function to show [AccountRenameSheet].
ModalRoute<void> getRenameAccountSheet(BuildContext context, Address address) {
  return commonBottomSheetRoute(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.enterNewName.tr(),
    body: (_, __) => AccountRenameSheet(address: address),
  );
}

class AccountRenameSheet extends InjectedElementaryParametrizedWidget<
    AccountRenameSheetWidgetModel, AccountRenameSheetParams> {
  AccountRenameSheet({
    required Address address,
    super.key,
  }) : super(
          wmFactoryParam: AccountRenameSheetParams(address),
        );

  @override
  Widget build(AccountRenameSheetWidgetModel wm) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      spacing: DimensSize.d16,
      children: [
        PrimaryTextField(
          maxLength: maxLengthForMainEntities,
          textEditingController: wm.nameController,
          hintText: LocaleKeys.nameWord.tr(),
          onSubmit: (_) => wm.renameAccount,
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
