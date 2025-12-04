import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/manage_seeds_accounts/route.dart';
import 'package:app/feature/wallet/new_account/route.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_data.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_model.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class SelectAccountWidgetModel
    extends CustomWidgetModel<SelectAccountWidget, SelectAccountModel> {
  SelectAccountWidgetModel(super.model);

  late final searchController = createTextEditingController();
  late final _accountsState = createNotifierFromStream(model.seedWithAccounts);
  late final _currentAccountState = createNotifierFromStream(
    model.currentAccount,
  );
  late final _listState = createNotifier(_accountsState.value);
  final _balances = <Address, ListenableState<Money?>>{};

  ListenableState<List<SelectAccountData>> get listState => _listState;

  ListenableState<KeyAccount?> get currentAccountState => _currentAccountState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _accountsState.addListener(onSearch);
  }

  void onSearch() {
    final value = searchController.value.text.trim().toLowerCase();

    if (value.isEmpty) {
      _listState.accept(_accountsState.value);
    } else {
      _listState.accept(
        _accountsState.value
            ?.map((selectAccountData) {
              final matchSeedName = selectAccountData.name
                  .toLowerCase()
                  .contains(value);
              final filteredPrivateKeys = selectAccountData.privateKeys
                  .map((keyInfo) {
                    final matchKeyName = keyInfo.keyName.toLowerCase().contains(
                      value,
                    );
                    final filteredAccounts = keyInfo.accounts.where((account) {
                      return account.name.toLowerCase().contains(value) ||
                          account.address.address.toLowerCase().contains(value);
                    }).toList();

                    return SeedWithInfo(
                      keyName: keyInfo.keyName,
                      key: keyInfo.key,
                      accounts:
                          (filteredAccounts.isEmpty &&
                              (matchKeyName || matchSeedName))
                          ? keyInfo.accounts
                          : filteredAccounts,
                    );
                  })
                  .where((keyInfo) => keyInfo.accounts.isNotEmpty)
                  .toList();

              return SelectAccountData(
                name: selectAccountData.name,
                privateKeys: filteredPrivateKeys,
                isLedger: selectAccountData.isLedger,
              );
            })
            .where((item) => item.privateKeys.isNotEmpty)
            .toList(),
      );
    }
  }

  void onSelect(KeyAccount account) {
    model.changeCurrentAccount(account);
    Navigator.of(context).pop(account);
  }

  void onAddAccount() {
    if (contextSafe == null) {
      return;
    }

    Navigator.of(context).pop();
    contextSafe?.compassContinue(const AddAccountRouteData());
  }

  void onManageSeedsAndAccounts() {
    Navigator.of(context).pop();
    contextSafe?.compassPointNamed(const ManageSeedsAccountsRouteData());
  }

  ListenableState<Money?> getBalanceEntity(KeyAccount account) {
    var entity = _balances[account.address];

    return entity ??= _balances[account.address] = createNotifierFromStream(
      model.getBalance(account),
    );
  }
}
