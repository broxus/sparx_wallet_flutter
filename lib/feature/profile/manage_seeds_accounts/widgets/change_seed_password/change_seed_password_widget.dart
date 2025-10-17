import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/change_seed_password/change_seed_password.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

/// Sheet that allows user to change password of seed phrase
class ChangeSeedPasswordSheet
    extends
        InjectedElementaryParametrizedWidget<
          ChangeSeedPasswordWidgetModel,
          PublicKey
        > {
  const ChangeSeedPasswordSheet({required PublicKey publicKey, super.key})
    : super(wmFactoryParam: publicKey);

  @override
  Widget build(ChangeSeedPasswordWidgetModel wm) {
    return Form(
      key: wm.formKey,
      child: SingleChildScrollView(
        child: SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          spacing: DimensSize.d24,
          children: [
            SecureTextField(
              textEditingController: wm.oldPasswordController,
              validator: wm.inputValidator,
              onSubmit: (_) => wm.newPasswordFocusNode.requestFocus(),
              hintText: LocaleKeys.oldPassword.tr(),
            ),
            SecureTextField(
              textEditingController: wm.newPasswordController,
              focusNode: wm.newPasswordFocusNode,
              validator: wm.inputValidator,
              hintText: LocaleKeys.newPassword.tr(),
              onSubmit: wm.onSubmitChange,
            ),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.changeWord.tr(),
              onPressed: wm.onSubmitChange,
            ),
          ],
        ),
      ),
    );
  }
}
