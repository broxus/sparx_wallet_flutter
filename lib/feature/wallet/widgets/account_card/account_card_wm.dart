import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_card/account_card_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

const _withdrawUpdateDebounce = Duration(seconds: 3);

AccountCardWidgetModel defaultAccountCardWidgetModelFactory(
  BuildContext context,
) =>
    AccountCardWidgetModel(
      AccountCardModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
        inject(),
        inject(),
        inject(),
      ),
    );

class AccountCardWidgetModel
    extends CustomWidgetModel<AccountCard, AccountCardModel> {
  AccountCardWidgetModel(super.model);

  late final _error = createNotifier<Object>();
  late final _isLoading = createNotifier<bool>(false);
  late final _balance = createNotifierFromStream(
    model.getBalanceStream(widget.account.address),
  );

  StreamSubscription<TonWalletState?>? _walletSubscription;
  StreamSubscription<void>? _withdrawRequestSubscription;

  ListenableState<Money> get balance => _balance;
  ListenableState<Object> get error => _error;
  ListenableState<bool> get isLoading => _isLoading;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _walletSubscription = model
        .getWalletStateStream(widget.account.address)
        .listen(_onWalletState);
  }

  @override
  void dispose() {
    _walletSubscription?.cancel();
    _withdrawRequestSubscription?.cancel();
    super.dispose();
  }

  Future<void> retry() async {
    try {
      _isLoading.accept(true);
      await model.retrySubscriptions(widget.account.address);
    } finally {
      _isLoading.accept(false);
    }
  }

  void onCopy() {
    Clipboard.setData(
      ClipboardData(text: widget.account.address.address),
    );
    model.showMessage(
      Message.successful(
        context: context,
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [widget.account.address.toEllipseString()],
        ),
      ),
    );
  }

  void _onWalletState(TonWalletState? walletState) {
    _error.accept(walletState?.error);

    _withdrawRequestSubscription?.cancel();
    _withdrawRequestSubscription = walletState?.wallet?.fieldUpdatesStream
        .debounceTime(_withdrawUpdateDebounce)
        .listen((_) => model.tryUpdateWithdraws(widget.account.address));
  }
}
