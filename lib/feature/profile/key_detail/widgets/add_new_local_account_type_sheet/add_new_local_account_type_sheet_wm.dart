import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/profile/key_detail/widgets/add_new_local_account_type_sheet/add_new_local_account_type_sheet.dart';
import 'package:app/feature/profile/key_detail/widgets/add_new_local_account_type_sheet/add_new_local_account_type_sheet_model.dart';
import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_sheet.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class AddNewLocalAccountTypeSheetParams {
  const AddNewLocalAccountTypeSheetParams({
    required this.publicKey,
    required this.name,
  });

  final PublicKey publicKey;
  final String name;
}

@injectable
class AddNewLocalAccountTypeSheetWidgetModel
    extends
        CustomWidgetModelParametrized<
          AddNewLocalAccountTypeSheet,
          AddNewLocalAccountTypeSheetModel,
          AddNewLocalAccountTypeSheetParams
        > {
  AddNewLocalAccountTypeSheetWidgetModel(super.model);

  late final _currentSelectedState = createNotifier<WalletType>();

  late List<WalletType> availableWalletTypes = model.availableWalletTypes;
  List<WalletType> createdWalletTypes = [];
  SeedKey? keyCreateFor;

  ListenableState<WalletType> get currentSelectedState => _currentSelectedState;

  WalletType get defaultWalletType => model.defaultWalletType;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    final key = model.findSeedKey(wmParams.value.publicKey);
    if (key == null) {
      // Nothing to show
      return;
    }

    keyCreateFor = key;

    const multisig2 = WalletType.multisig(MultisigType.multisig2);
    if (availableWalletTypes.contains(multisig2)) {
      availableWalletTypes
        ..remove(multisig2)
        ..add(multisig2);
    }

    // remove default as it will be displayed separately
    availableWalletTypes.remove(defaultWalletType);

    createdWalletTypes = model.getCreatedAccountTypes(key);

    _currentSelectedState.accept(
      availableWalletTypes
          .where((av) => !createdWalletTypes.contains(av))
          .firstOrNull,
    );
  }

  String defaultAccountName(WalletType type) => model.defaultAccountName(type);

  void changeType(WalletType type) => _currentSelectedState.accept(type);

  Future<void> createAccount() async {
    final selected = _currentSelectedState.value;
    if (selected == null || keyCreateFor == null) return;

    final newName = wmParams.value.name.trim();
    try {
      final address = await model.addAccount(
        key: keyCreateFor!,
        walletType: selected,
        workchain: 0,
        name: newName.isEmpty ? null : newName,
      );

      contextSafe?.let((context) {
        Navigator.of(context).pop();
        showNewAccountResultSheet(context: context, address: address);
      });
    } on Exception catch (e) {
      model.showMessage(Message.error(message: e.toString()));
    }
  }
}
