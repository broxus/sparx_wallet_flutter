import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/key_detail/widgets/account_rename_sheet/account_rename_sheet.dart';
import 'package:app/feature/profile/key_detail/widgets/account_rename_sheet/account_rename_sheet_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [WidgetModel] for [AccountRenameSheet]
@injectable
class AccountRenameSheetWidgetModel
    extends
        CustomWidgetModelParametrized<
          AccountRenameSheet,
          AccountRenameSheetModel,
          Address
        > {
  AccountRenameSheetWidgetModel(super.model);

  late final nameController = createTextEditingController(
    model.getAccountName(wmParams.value),
  );

  void renameAccount([String? _]) {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      return;
    }
    model.rename(wmParams.value, name);
    Navigator.of(context).pop();
  }
}
