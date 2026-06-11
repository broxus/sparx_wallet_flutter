import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

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
  late final _selectedState = createNotifier(
    model.currentAccount ?? model.accounts.firstOrNull,
  );

  final _log = Logger('TCConnectWidgetModel');

  ValueListenable<TonConnectStep> get stepState => _stepState;

  ListenableState<KeyAccount?> get selectedState => _selectedState;

  DappManifest get manifest => wmParams.value.manifest;

  void onNext() {
    final account = selectedState.value;
    final request = wmParams.value.request;

    if (account == null) return;
    if (request.hasTonProofItem && !_isTonWalletType(account)) {
      model.showError(LocaleKeys.unsupportedWalletTypeError.tr());
      return;
    }

    _stepState.value = TonConnectStep.confirm;
  }

  void onSelectedChanged(KeyAccount? account) {
    _selectedState.accept(account);
  }

  Future<void> onConfirm(SignInputAuth signInputAuth) async {
    final account = selectedState.value;
    if (account == null) return;

    try {
      final replyItems = await model.createReplyItems(
        signInputAuth: signInputAuth,
        account: account,
        request: wmParams.value.request,
        manifest: manifest,
      );

      final context = contextSafe;
      if (context == null || !context.mounted) {
        return;
      }

      await Navigator.of(
        context,
      ).maybePop(TonConnectUiEventResult.data(data: (account, replyItems)));
    } catch (e, s) {
      model.showError(e);
      _log.severe('TCConnect confirm error:', '$e', s);
    }
  }

  Future<SignInputAuthLedger> getLedgerAuthInput() {
    final account = _selectedState.value;
    if (account == null) {
      throw StateError('No account selected for Ledger auth input');
    }

    return model.getLedgerAuthInput(account);
  }

  bool _isTonWalletType(KeyAccount keyAccount) {
    final walletType = keyAccount.account.tonWallet.contract;
    return switch (walletType) {
      WalletTypeWalletV3R1() => true,
      WalletTypeWalletV3R2() => true,
      WalletTypeWalletV4R1() => true,
      WalletTypeWalletV4R2() => true,
      WalletTypeWalletV5R1() => true,
      _ => false,
    };
  }
}
