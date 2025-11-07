import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/change_seed_password/change_seed_password.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class ChangeSeedPasswordWidgetModel
    extends
        CustomWidgetModelParametrized<
          ChangeSeedPasswordSheet,
          ChangeSeedPasswordModel,
          PublicKey
        > {
  ChangeSeedPasswordWidgetModel(super.model);

  late final _lockState = model.getLockState(wmParams.value);
  late final _isPasswordLockedState = createNotifierFromStream(
    _lockState.isLockedStream,
  );

  late final oldPasswordController = createTextEditingController();
  late final newPasswordController = createTextEditingController();
  late final newPasswordFocusNode = createFocusNode();
  final formKey = GlobalKey<FormState>();

  ListenableState<bool> get isPasswordLockedState => _isPasswordLockedState;

  String? inputValidator(String? password) {
    if (password == null || password.length < minPasswordLength) {
      return LocaleKeys.passwordLength.tr();
    }
    return null;
  }

  Future<void> onSubmitChange([String? _]) async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final oldPassword = oldPasswordController.text;
    final newPassword = newPasswordController.text;
    final publicKey = wmParams.value;
    final languageCode = context.locale.languageCode;

    if (_lockState.isLocked) {
      _lockState.getErrorMessage(languageCode)?.let((message) {
        model.showMessage(Message.error(message: message));
      });
      return;
    }

    try {
      final correct = await model.checkKeyPassword(
        publicKey: publicKey,
        password: oldPassword,
      );

      if (!correct) {
        final errorMessage = _lockState.getErrorMessage(languageCode);
        if (errorMessage != null) {
          model.showMessage(Message.error(message: errorMessage));
          return;
        }

        model.showMessage(
          Message.error(message: LocaleKeys.passwordIsWrong.tr()),
        );
        return;
      }

      await model.changePassword(
        publicKey: publicKey,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      model.showMessage(
        Message.successful(message: LocaleKeys.passwordChanged.tr()),
      );

      if (contextSafe != null) {
        Navigator.of(contextSafe!).pop();
      }
    } catch (_) {
      model.showMessage(
        Message.error(message: LocaleKeys.passwordIsWrong.tr()),
      );
    }
  }
}
