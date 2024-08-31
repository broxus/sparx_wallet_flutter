import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/key_detail/widgets/add_new_local_account_sheet.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_model.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_widget.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

SelectAccountWidgetModel defaultSelectAccountWidgetModelFactory(
  BuildContext context,
) =>
    SelectAccountWidgetModel(
      SelectAccountModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class SelectAccountWidgetModel
    extends CustomWidgetModel<SelectAccountWidget, SelectAccountModel> {
  SelectAccountWidgetModel(super.model);

  late final searchController = createTextEditingController();
  late final _accounts = createNotifierFromStream(model.accounts);
  late final _currentAccount = createNotifierFromStream(model.currentAccount);
  late final _list = createNotifier(_accounts.value);

  ListenableState<List<KeyAccount>> get list => _list;

  ListenableState<KeyAccount?> get currentAccount => _currentAccount;

  @override
  void initWidgetModel() {
    _accounts.addListener(onSearch);

    super.initWidgetModel();
  }

  void onSearch() {
    final value = searchController.value.text.trim().toLowerCase();

    if (value.isEmpty) {
      _list.accept(_accounts.value);
    } else {
      _list.accept(
        _accounts.value
            ?.where(
              (account) =>
                  account.name.toLowerCase().contains(value) ||
                  account.address.address.toLowerCase().contains(value),
            )
            .toList(),
      );
    }
  }

  Future<void> onSelect(KeyAccount account) async {
    await model.changeCurrentAccount(account);
    contextSafe?.let((context) => Navigator.of(context).pop(account));
  }

  void onAddAccount() {
    final publicKey = _currentAccount.value?.publicKey;

    if (publicKey != null) {
      showAddNewLocalAccountSheet(
        context: context,
        publicKey: publicKey,
      );
    }
  }

  void onManageSeedsAndAccounts() {
    Navigator.of(context).pop();
    context
      ..goNamed(AppRoute.profile.name)
      ..goFurther(AppRoute.manageSeedsAccounts.path);
  }
}
