import 'package:app/core/wm/custom_wm.dart';
import 'package:app/widgets/account_list/account_list_item.dart';
import 'package:app/widgets/account_list/account_list_wm.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class AccountListWidget
    extends
        InjectedElementaryParametrizedWidget<
          AccountListWidgetModel,
          AccountListWmParams
        > {
  AccountListWidget({
    required this.selectedAccountState,
    required this.onSelectedChanged,
    TextEditingController? searchController,
    ScrollController? scrollController,
    super.key,
  }) : super(
         wmFactoryParam: AccountListWmParams(
           searchController: searchController,
           scrollController: scrollController,
         ),
       );

  final ListenableState<KeyAccount?> selectedAccountState;
  final ValueChanged<KeyAccount?> onSelectedChanged;

  @override
  Widget build(AccountListWidgetModel wm) {
    return DoubleSourceBuilder(
      firstSource: wm.accountsState,
      secondSource: selectedAccountState,
      builder: (_, accounts, selected) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToActiveAccount(accounts, selected, wm.scrollController);
        });

        return ListView.separated(
          controller: wm.scrollController,
          physics: const ClampingScrollPhysics(),
          itemCount: accounts?.length ?? 0,
          itemBuilder: (_, index) {
            final account = accounts?[index];
            return account == null
                ? const SizedBox.shrink()
                : AccountListItem(
                    key: ValueKey(account.address),
                    account: account,
                    balance: wm.getBalanceEntity(account),
                    active: account.address == selected?.address,
                    onTap: () => onSelectedChanged(account),
                  );
          },
          separatorBuilder: (_, __) =>
              CommonDivider(color: wm.theme.colors.border0),
        );
      },
    );
  }

  void _scrollToActiveAccount(
    List<KeyAccount>? accounts,
    KeyAccount? selected,
    ScrollController scrollController,
  ) {
    if (accounts != null && selected != null) {
      final index = accounts.indexWhere(
        (account) => account.address == selected.address,
      );

      if (index != -1 && scrollController.hasClients) {
        scrollController.animateTo(
          index * DimensSize.d72,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}
