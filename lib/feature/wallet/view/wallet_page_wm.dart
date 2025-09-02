import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:app/feature/wallet/view/wallet_page_model.dart';
import 'package:app/feature/wallet/view/wallet_page_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class WalletPageWidgetModel
    extends CustomWidgetModel<WalletPageWidget, WalletPageModel> {
  WalletPageWidgetModel(super.model);

  late final scrollController = createScrollController();

  late final _currentAccountState =
      createNotifierFromStream(model.currentAccount);
  late final _transportStrategyState =
      createNotifierFromStream(model.transportStrategy);
  late final _isShowingNewTokensNotifier = createNotifier<bool>();
  late final _hasUnconfirmedTransactionsNotifier = createNotifier<bool>();

  StreamSubscription<RootTab>? _pressWalletSubscribtion;

  StreamSubscription<void>? _changeTransactions;

  StreamSubscription<KeyAccount>? _currentAccountSubscribtion;

  ListenableState<KeyAccount?> get currentAccountState => _currentAccountState;

  ListenableState<bool?> get hasUnconfirmedTransactionsState =>
      _hasUnconfirmedTransactionsNotifier;

  ListenableState<TransportStrategy> get transportStrategyState =>
      _transportStrategyState;

  ListenableState<bool> get isShowingNewTokensState =>
      _isShowingNewTokensNotifier;
  int? _numberUnconfirmedTransactions;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _pressWalletSubscribtion = model.shouldScrollTopStream.listen(
      (_) {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.linear,
        );
      },
    );
    _currentAccountSubscribtion =
        model.currentAccount.whereNotNull().listen(_onAccountChanged);
  }

  @override
  void dispose() {
    _pressWalletSubscribtion?.cancel();
    _changeTransactions?.cancel();
    _currentAccountSubscribtion?.cancel();
    super.dispose();
  }

  void hideNewTokensLabel() {
    final account = currentAccountState.value;
    _isShowingNewTokensNotifier.accept(false);
    if (account != null) {
      model.hideNewTokenLabels(account);
    }
  }

  void _onAccountChanged(KeyAccount account) {
    _checkBadge(account);
    _checkUnconfirmedTransactions(account);
  }

  void _checkBadge(KeyAccount account) {
    // TODO(komarov): move to service layer
    final isNewUser = model.isNewUser();

    if (isNewUser == null) {
      _isShowingNewTokensNotifier.accept(
        model.isShowingNewTokens(account) ?? true,
      );
      return;
    }

    _isShowingNewTokensNotifier.accept(true);

    if (!isNewUser) {
      model.hideShowingBadge(account);
    }

    model.resetValueNewUser();
  }

  Future<void> _checkUnconfirmedTransactions(KeyAccount account) async {
    final walletTonState = await model.getTonWalletState(account.address);
    _numberUnconfirmedTransactions =
        walletTonState.wallet?.unconfirmedTransactions.length ?? 0;
    _hasUnconfirmedTransactionsNotifier.accept(
      (_numberUnconfirmedTransactions ?? 0) > 0,
    );
    _changeTransactions = walletTonState.wallet?.fieldUpdatesStream.listen((_) {
      final newNumber = walletTonState.wallet?.unconfirmedTransactions.length;
      if (_numberUnconfirmedTransactions != newNumber) {
        _numberUnconfirmedTransactions = newNumber;
        _hasUnconfirmedTransactionsNotifier.accept(
          (_numberUnconfirmedTransactions ?? 0) > 0,
        );
      }
    });
  }
}
