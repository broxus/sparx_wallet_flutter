import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_card/account_card_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

const _withdrawUpdateDebounce = Duration(seconds: 3);

@injectable
class AccountCardWidgetModel extends CustomWidgetModelParametrized<AccountCard,
    AccountCardModel, KeyAccount> {
  AccountCardWidgetModel(
    super.model,
  );

  late final _error = createValueNotifier<Object?>(null);
  late final _isLoading = createValueNotifier<bool>(false);
  late final ValueListenable<KeyAccount> currentAccountState =
      createWmParamsNotifier((it) => it);

  late final _balance = createNotifierFromStream(
    wmParams.flatMap(
      (account) => model.getBalanceStream(account.address),
    ),
  );

  StreamSubscription<TonWalletState?>? _walletSubscription;
  StreamSubscription<void>? _withdrawRequestSubscription;
  ListenableState<Money> get balance => _balance;
  ValueListenable<Object?> get error => _error;
  ValueListenable<bool> get isLoading => _isLoading;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _walletSubscription = model
        .getWalletStateStream(currentAccountState.value.address)
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
      _isLoading.value = true;
      await model.retrySubscriptions(currentAccountState.value.address);
    } finally {
      _isLoading.value = false;
    }
  }

  void onCopy() {
    Clipboard.setData(
      ClipboardData(text: currentAccountState.value.address.address),
    );
    model.showMessage(
      Message.successful(
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [currentAccountState.value.address.toEllipseString()],
        ),
      ),
    );
  }

  void _onWalletState(TonWalletState? walletState) {
    _error.value = walletState?.error;

    _withdrawRequestSubscription?.cancel();
    _withdrawRequestSubscription = walletState?.wallet?.fieldUpdatesStream
        .skip(1) // Skip the initial value to run tryUpdateWithdraws immediately
        .debounceTime(_withdrawUpdateDebounce)
        .listen(
          (_) => model.tryUpdateWithdraws(currentAccountState.value.address),
        );

    model.tryUpdateWithdraws(currentAccountState.value.address);
  }
}
