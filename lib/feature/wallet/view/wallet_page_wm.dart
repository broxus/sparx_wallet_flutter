import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/wallet/view/wallet_page_model.dart';
import 'package:app/feature/wallet/view/wallet_page_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

WalletPageWidgetModel defaultWalletPageWidgetModelFactory(
  BuildContext context,
) =>
    WalletPageWidgetModel(
      WalletPageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
        inject(),
      ),
    );

class WalletPageWidgetModel
    extends CustomWidgetModel<WalletPageWidget, WalletPageModel> {
  WalletPageWidgetModel(super.model);

  late final scrollController = createScrollController();

  late final _currentAccount = createNotifierFromStream(model.currentAccount);
  late final _transportStrategy =
      createNotifierFromStream(model.transportStrategy);
  late final _isShowingNewTokensNotifier = createNotifier<bool>();
  late final _hasUnconfirmedTransactionsNotifier = createNotifier<bool>();

  StreamSubscription<PressBottomNavigationEvent>? _pressWalletSubscribtion;

  StreamSubscription<void>? _changeTransactions;

  StreamSubscription<KeyAccount>? _currentAccountSubscribtion;

  ListenableState<KeyAccount?> get currentAccount => _currentAccount;

  ListenableState<bool?> get hasUnconfirmedTransactions =>
      _hasUnconfirmedTransactionsNotifier;

  ListenableState<TransportStrategy> get transportStrategy =>
      _transportStrategy;

  ListenableState<bool> get isShowingNewTokens => _isShowingNewTokensNotifier;
  int? _numberUnconfirmedTransactions;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _pressWalletSubscribtion = primaryBus
        .on<PressBottomNavigationEvent>()
        .listen(_onPressWalletBottomNavigation);
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
    final account = currentAccount.value;
    _isShowingNewTokensNotifier.accept(false);
    if (account != null) {
      model.hideNewTokenLabels(account);
    }
  }

  void _onPressWalletBottomNavigation(PressBottomNavigationEvent event) {
    if (!event.isSameTab || !event.isWalletTab) {
      return;
    }

    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
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
