import 'package:app/app/service/service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

enum TonConnectStep { account, confirm }

class TCConnectWmParams {
  const TCConnectWmParams({required this.request, required this.manifest});

  final ConnectRequest request;
  final DappManifest manifest;
}

@injectable
class TCConnectWidgetModel
    extends
        CustomWidgetModelParametrized<
          TCConnectWidget,
          TCConnectModel,
          TCConnectWmParams
        > {
  TCConnectWidgetModel(super.model);

  late final searchController = createTextEditingController();
  late final _stepState = createValueNotifier(TonConnectStep.account);
  late final _selectedState = createNotifier(_initialSelectedAccount);
  late final _accountsState = createNotifier(model.accounts);
  late final _zeroBalance = Money.fromBigIntWithCurrency(
    BigInt.zero,
    Currencies()[model.symbol] ??
        Currency.create(model.symbol, 0, pattern: moneyPattern(0)),
  );
  final _balances = <Address, ListenableState<Money>>{};

  ValueListenable<TonConnectStep> get stepState => _stepState;

  ListenableState<List<KeyAccount>> get accountsState => _accountsState;

  ListenableState<KeyAccount?> get selectedState => _selectedState;

  KeyAccount? get _initialSelectedAccount =>
      model.currentAccount ?? model.accounts.firstOrNull;

  DappManifest get manifest => wmParams.value.manifest;

  void onNext() {
    if (selectedState.value == null) return;
    _stepState.value = TonConnectStep.confirm;
  }

  void onSearch() {
    final value = searchController.value.text.trim().toLowerCase();

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

  void onSelectedChanged(KeyAccount? account) {
    _selectedState.accept(account);
  }

  Future<void> onConfirm(SignInputAuth signInputAuth) async {
    if (selectedState.value == null) return;

    final account = selectedState.value!;
    final replyItems = await model.createReplyItems(
      signInputAuth: signInputAuth,
      account: account,
      request: wmParams.value.request,
      manifest: manifest,
    );

    if (contextSafe != null) {
      final result = TonConnectUiEventResult.data(data: (account, replyItems));
      Navigator.of(contextSafe!).pop(result);
    }
  }

  // TODO(komarov): generic account list / account loader / etc.
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

  Future<SignInputAuthLedger> getLedgerAuthInput() {
    final account = _selectedState.value;
    if (account == null) {
      throw StateError('No account selected for Ledger auth input');
    }

    return model.getLedgerAuthInput(account);
  }
}
