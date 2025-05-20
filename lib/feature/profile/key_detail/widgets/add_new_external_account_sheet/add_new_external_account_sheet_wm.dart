import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/profile/key_detail/widgets/add_new_external_account_sheet/add_new_external_account_sheet.dart';
import 'package:app/feature/profile/key_detail/widgets/add_new_external_account_sheet/add_new_external_account_sheet_model.dart';
import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_sheet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show Address;

AddNewExternalAccountSheetWidgetModel
    defaultAddNewExternalAccountSheetWidgetModelFactory(
  BuildContext context,
) {
  return AddNewExternalAccountSheetWidgetModel(
    AddNewExternalAccountSheetModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
    ),
  );
}

class AddNewExternalAccountSheetWidgetModel extends CustomWidgetModel<
    AddNewExternalAccountSheet, AddNewExternalAccountSheetModel> {
  AddNewExternalAccountSheetWidgetModel(super.model);

  late final nameController = createTextEditingController();
  late final addressController = createTextEditingController();
  late final focusNode = createFocusNode();

  late final _isLoading = createValueNotifier(false);

  ValueListenable<bool> get isLoading => _isLoading;

  Future<void> onSubmit([String? _]) async {
    if (_isLoading.value) return;

    final name = nameController.value.text.trim();
    final address = Address(address: addressController.value.text);

    try {
      if (!address.isValid) {
        model.showMessage(
          Message.error(message: LocaleKeys.addressIsWrong.tr()),
        );
        return;
      }

      _isLoading.value = true;

      await model.addExternalAccount(
        address: address,
        publicKey: widget.publicKey,
        name: name.isEmpty ? null : name,
      );

      contextSafe?.let((context) {
        Navigator.of(context).pop();
        showNewAccountResultSheet(
          context: context,
          address: address,
          isExternal: true,
        );
      });
    } catch (e) {
      model.showMessage(
        Message.error(message: LocaleKeys.keyIsNotCustodian.tr()),
      );
    } finally {
      _isLoading.value = false;
    }
  }
}
