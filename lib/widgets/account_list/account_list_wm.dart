import 'package:app/app/service/service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/widgets/account_list/account_list_model.dart';
import 'package:app/widgets/account_list/account_list_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

class AccountListWmParams {
  const AccountListWmParams({this.searchController, this.scrollController});

  final TextEditingController? searchController;
  final ScrollController? scrollController;
}

@injectable
class AccountListWidgetModel
    extends
        CustomWidgetModelParametrized<
          AccountListWidget,
          AccountListModel,
          AccountListWmParams
        > {
  AccountListWidgetModel(super.model);

  late final scrollController =
      wmParams.value.scrollController ?? createScrollController();

  late final _accountsState = createNotifier(model.accounts);
  late final _zeroBalance = Money.fromBigIntWithCurrency(
    BigInt.zero,
    Currencies()[model.symbol] ??
        Currency.create(model.symbol, 0, pattern: moneyPattern(0)),
  );
  final _balances = <Address, ListenableState<Money>>{};

  ListenableState<List<KeyAccount>> get accountsState => _accountsState;

  ThemeStyle get theme => context.themeStyle;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    wmParams.value.searchController?.addListener(_onSearch);
  }

  @override
  void dispose() {
    wmParams.value.searchController?.removeListener(_onSearch);
    super.dispose();
  }

  void _onSearch() {
    final value =
        wmParams.value.searchController?.text.trim().toLowerCase() ?? '';

    if (value.isEmpty) {
      _accountsState.accept(model.accounts);
    } else {
      _accountsState.accept(
        model.accounts
            .where(
              (account) =>
                  account.name.toLowerCase().contains(value) ||
                  account.address.address.toLowerCase().contains(value),
            )
            .toList(),
      );
    }
  }

  ListenableState<Money> getBalanceEntity(KeyAccount account) {
    var entity = _balances[account.address];

    if (entity == null) {
      final notifier = createNotifier<Money>();
      entity = _balances[account.address] = notifier;

      model
          .getBalance(account)
          .then((value) => notifier.accept(value ?? _zeroBalance));
    }

    return entity;
  }
}
