import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_card/account_card_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

const _withdrawUpdateDebounce = Duration(seconds: 3);

class AccountCardWmParams {
  const AccountCardWmParams({
    required this.account,
  });

  final KeyAccount account;
}

@injectable
class AccountCardWidgetModel
    extends CustomWidgetModel<AccountCard, AccountCardModel> {
  AccountCardWidgetModel(
    super.model,
    @factoryParam this.account,
  );

  final KeyAccount account;

  late final _error = createNotifier<Object>();
  late final _isLoading = createNotifier<bool>(false);
  late final _balance = createNotifierFromStream(
    model.getBalanceStream(account.address),
  );

  StreamSubscription<TonWalletState?>? _walletSubscription;
  StreamSubscription<void>? _withdrawRequestSubscription;
  ListenableState<Money> get balance => _balance;
  ListenableState<Object> get error => _error;
  ListenableState<bool> get isLoading => _isLoading;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _walletSubscription =
        model.getWalletStateStream(account.address).listen(_onWalletState);
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
      await model.retrySubscriptions(account.address);
    } finally {
      _isLoading.accept(false);
    }
  }

  void onCopy() {
    Clipboard.setData(
      ClipboardData(text: account.address.address),
    );
    model.showMessage(
      Message.successful(
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [account.address.toEllipseString()],
        ),
      ),
    );
  }

  void _onWalletState(TonWalletState? walletState) {
    _error.accept(walletState?.error);

    _withdrawRequestSubscription?.cancel();
    _withdrawRequestSubscription = walletState?.wallet?.fieldUpdatesStream
        .debounceTime(_withdrawUpdateDebounce)
        .listen((_) => model.tryUpdateWithdraws(account.address));
  }
}
