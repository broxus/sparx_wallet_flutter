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
const _balanceThrottleTime = Duration(seconds: 1);

@injectable
class AccountCardWidgetModel extends CustomWidgetModelParametrized<AccountCard,
    AccountCardModel, KeyAccount> {
  AccountCardWidgetModel(
    super.model,
  );

  late final _errorState = createValueNotifier<Object?>(null);
  late final _isLoadingState = createValueNotifier<bool>(false);
  late final ValueListenable<KeyAccount> currentAccountState =
      createWmParamsNotifier((it) => it);

  late final _balanceState = createNotifierFromStream(
    wmParams
        .switchMap((account) => model.getBalanceStream(account.address))
        .throttleTime(_balanceThrottleTime, trailing: true),
  );

  StreamSubscription<TonWalletState?>? _walletSubscription;
  StreamSubscription<void>? _withdrawRequestSubscription;
  ListenableState<Money> get balanceState => _balanceState;
  ValueListenable<Object?> get errorState => _errorState;
  ValueListenable<bool> get isLoadingState => _isLoadingState;

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
      _isLoadingState.value = true;
      await model.retrySubscriptions(currentAccountState.value.address);
    } finally {
      _isLoadingState.value = false;
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
    _errorState.value = walletState?.error;

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
