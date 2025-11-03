import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_sheet.dart';
import 'package:app/feature/wallet/new_account/add_external_account/add_external_account.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show Address;
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class AddExternalAccountWidgetModel
    extends
        CustomWidgetModel<AddExternalAccountWidget, AddExternalAccountModel> {
  AddExternalAccountWidgetModel(super.model);

  late final nameController = createTextEditingController();
  late final addressController = createTextEditingController();
  late final focusNode = createFocusNode();

  late final _isLoadingState = createValueNotifier(false);

  ValueListenable<bool> get isLoadingState => _isLoadingState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  void onPaste(String text) {
    if (text.isEmpty) return;

    final address = Address(address: text);
    if (address.isValid) {
      addressController.text = text;
      focusNode.unfocus();
    } else {
      model.showMessage(Message.error(message: LocaleKeys.addressIsWrong.tr()));
    }
  }

  Future<void> onSubmit([String? _]) async {
    if (_isLoadingState.value) return;

    final name = nameController.value.text.trim();
    final address = Address(address: addressController.value.text);

    try {
      if (!address.isValid) {
        model.showMessage(
          Message.error(message: LocaleKeys.addressIsWrong.tr()),
        );
        return;
      }

      _isLoadingState.value = true;

      await model.addExternalAccount(
        address: address,
        name: name.isEmpty ? null : name,
      );

      contextSafe?.let((context) {
        Navigator.of(context).pop();
        showNewAccountResultSheet(context: context, address: address);
      });
    } catch (e) {
      model.showMessage(
        Message.error(message: LocaleKeys.keyIsNotCustodian.tr()),
      );
    } finally {
      _isLoadingState.value = false;
    }
  }
}
