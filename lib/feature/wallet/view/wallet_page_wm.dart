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
  late final _isShowingNewTokensState = createNotifier<bool>();
  late final _hasUnconfirmedTransactionsState = createNotifier<bool>();

  StreamSubscription<RootTab>? _pressWalletSubscribtion;

  StreamSubscription<void>? _changeTransactions;

  StreamSubscription<KeyAccount>? _currentAccountSubscribtion;

  StreamSubscription<TonWalletState?>? _walletSubscribtion;

  ListenableState<KeyAccount?> get currentAccountState => _currentAccountState;

  ListenableState<bool?> get hasUnconfirmedTransactionsState =>
      _hasUnconfirmedTransactionsState;

  ListenableState<TransportStrategy> get transportStrategyState =>
      _transportStrategyState;

  ListenableState<bool> get isShowingNewTokensState =>
      _isShowingNewTokensState;

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
    _walletSubscribtion?.cancel();
    super.dispose();
  }

  void hideNewTokensLabel() {
    final account = currentAccountState.value;
    _isShowingNewTokensState.accept(false);
    if (account != null) {
      model.hideNewTokenLabels(account);
    }
  }

  void _onAccountChanged(KeyAccount account) {
    _checkBadge(account);
    _subscribeWallet(account);
  }

  void _checkBadge(KeyAccount account) {
    // TODO(komarov): move to service layer
    final isNewUser = model.isNewUser();

    if (isNewUser == null) {
      _isShowingNewTokensState.accept(
        model.isShowingNewTokens(account) ?? true,
      );
      return;
    }

    _isShowingNewTokensState.accept(true);

    if (!isNewUser) {
      model.hideShowingBadge(account);
    }

    model.resetValueNewUser();
  }

  Future<void> _subscribeWallet(KeyAccount account) async {
    await _walletSubscribtion?.cancel();
    await _changeTransactions?.cancel();

    _walletSubscribtion =
        model.getWalletStream(account.address).listen((walletState) async {
      final wallet = walletState?.wallet;

      if (wallet != null) {
        await _changeTransactions?.cancel();
        _changeTransactions = wallet.fieldUpdatesStream.listen((_) {
          _checkUnconfirmedTransactions(wallet);
        });
      }

      _checkUnconfirmedTransactions(wallet);
    });
  }

  void _checkUnconfirmedTransactions(TonWallet? wallet) {
    final unconfirmedTransactionsCount =
        wallet?.unconfirmedTransactions.length ?? 0;
    _hasUnconfirmedTransactionsState.accept(
      unconfirmedTransactionsCount > 0,
    );
  }
}
