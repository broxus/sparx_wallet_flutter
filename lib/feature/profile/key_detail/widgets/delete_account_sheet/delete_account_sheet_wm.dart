import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/key_detail/widgets/delete_account_sheet/delete_account_sheet.dart';
import 'package:app/feature/profile/key_detail/widgets/delete_account_sheet/delete_account_sheet_model.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class DeleteAccountSheetWidgetModel
    extends
        CustomWidgetModelParametrized<
          DeleteAccountSheet,
          DeleteAccountSheetModel,
          KeyAccount
        > {
  DeleteAccountSheetWidgetModel(super.model);

  late final _balanceState = createNotifierFromStream(
    model.accountOverallBalance(address),
  );

  StateNotifier<Money?> get balanceState => _balanceState;

  Address get address => wmParams.value.address;

  void onRemove() {
    Navigator.of(context).pop();
    wmParams.value.remove();
  }

  void onCancel() {
    Navigator.of(context).pop();
  }
}
