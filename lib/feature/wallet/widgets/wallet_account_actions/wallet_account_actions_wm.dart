import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:app/feature/add_seed/enter_seed_name/route.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/staking/view/staking_page/route.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_type_selection/wallet_type_selection_sheet.dart';
import 'package:app/feature/wallet/wallet_deploy/widgets/deploy_wallet_min_ever_modal.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/route.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings.dart';
import 'package:app/feature/wallet/widgets/wallet_account_actions/wallet_account_actions_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

/// Action that describes behavior for account.
enum WalletAccountActionBehavior {
  deploy, // deploy wallet needed
  send, // send without any restrictions
  sendLocalCustodiansNeeded, // send button but with showing snackbar
}

class WalletAccountActionsWmParams {
  WalletAccountActionsWmParams({
    required this.account,
    required this.allowStake,
    required this.sendSpecified,
    required this.disableSensetiveActions,
  });

  final KeyAccount account;
  final bool allowStake;
  final bool sendSpecified;
  final bool disableSensetiveActions;
}

/// Widget model for wallet account actions, handles state management
@injectable
class WalletAccountActionsWidgetModel extends CustomWidgetModelParametrized<
    WalletAccountActions,
    WalletAccountActionsModel,
    WalletAccountActionsWmParams> {
  WalletAccountActionsWidgetModel(
    super.model,
  );

  static final _logger = Logger('WalletAccountActionsWidgetModel');

  late final _actionState = createNotifier<WalletAccountActionBehavior>(
    WalletAccountActionBehavior.send,
  );
  late final _hasStakeState = createWmParamsNotifier<bool>(
    (it) => model.hasStake && it.allowStake,
  );
  late final _hasStakeActionsState = createValueNotifier(false);

  int _numberUnconfirmedTransactions = 0;
  BigInt _balance = BigInt.zero;
  BigInt _minBalance = BigInt.zero;
  List<PublicKey>? _custodians;
  TonWallet? _wallet;
  StreamSubscription<TonWallet>? _walletSubscription;
  StreamSubscription<List<StEverWithdrawRequest>>? _withdrawsSubscription;

  late final _sendSpecifiedState =
      createWmParamsNotifier((it) => wmParams.value.sendSpecified);
  late final _disableSensetiveActionsState =
      createWmParamsNotifier((it) => wmParams.value.disableSensetiveActions);

  ValueListenable<bool> get sendSpecifiedState => _sendSpecifiedState;
  ValueListenable<bool> get disableSensetiveActionsState =>
      _disableSensetiveActionsState;

  ListenableState<WalletAccountActionBehavior> get actionState => _actionState;

  ValueListenable<bool> get hasStakeState => _hasStakeState;

  ValueListenable<bool> get hasStakeActionsState => _hasStakeActionsState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _walletSubscription = wmParams
        .switchMap(
          (params) => model.getWalletStateStream(params.account.address),
        )
        .listen(_onWallet);
  }

  @override
  void dispose() {
    _walletSubscription?.cancel();
    _withdrawsSubscription?.cancel();
    super.dispose();
  }

  void _onWallet(TonWallet wallet) {
    if (_wallet?.transport.connectionParamsHash ==
        wallet.transport.connectionParamsHash) {
      return;
    }

    _wallet = wallet;

    _withdrawsSubscription?.cancel();
    _withdrawsSubscription = Rx.combineLatest2(
      wallet.fieldUpdatesStream,
      model.getWithdrawRequestsStream(wmParams.value.account.address),
      (_, withdraws) => withdraws,
    ).listen((withdraws) {
      _updateWalletData(
        wallet: wallet,
        withdraws: withdraws,
      );
    });
  }

  Future<void> _updateWalletData({
    required TonWallet wallet,
    required List<StEverWithdrawRequest> withdraws,
  }) async {
    try {
      final details = wallet.details;
      final contract = wallet.contractState;

      WalletAccountActionBehavior action;

      if (!details.requiresSeparateDeploy) {
        action = WalletAccountActionBehavior.send;
      } else if (contract.isDeployed) {
        final localCustodians = await model.getLocalCustodians(
          wmParams.value.account.address,
        );
        action = localCustodians != null && localCustodians.isNotEmpty
            ? WalletAccountActionBehavior.send
            : WalletAccountActionBehavior.sendLocalCustodiansNeeded;
      } else {
        action = WalletAccountActionBehavior.deploy;
      }

      final hasStakeValue = action != WalletAccountActionBehavior.deploy &&
          model.hasStake &&
          wmParams.value.allowStake;

      _actionState.accept(action);
      _hasStakeState.value = hasStakeValue;
      _hasStakeActionsState.value = hasStakeValue && withdraws.isNotEmpty;

      _balance = contract.balance;
      _custodians = wallet.custodians;
      _numberUnconfirmedTransactions = (wallet.unconfirmedTransactions.length) +
          (wallet.pendingTransactions.length);

      if (action == WalletAccountActionBehavior.deploy) {
        unawaited(_estimateFees());
      }
    } catch (e, s) {
      _logger.warning('Error while updating wallet data', e, s);
    }
  }

  Future<void> _estimateFees() async {
    try {
      final message = await model.prepareDeploy(wmParams.value.account.address);
      final fees = await model.estimateDeploymentFees(
        address: wmParams.value.account.address,
        message: message,
      );

      _minBalance = fees;
    } catch (e, s) {
      _logger.severe('estimateFees', e, s);
    }
  }

  void onReceive() {
    if (wmParams.value.disableSensetiveActions) return;

    showReceiveFundsSheet(context, wmParams.value.account.address);
  }

  void onMainAction() {
    final action = _actionState.value;

    if (wmParams.value.disableSensetiveActions || action == null) {
      return;
    }

    switch (action) {
      case WalletAccountActionBehavior.send:
        _handleSendAction();
      case WalletAccountActionBehavior.deploy:
        _handleDeployAction();
      case WalletAccountActionBehavior.sendLocalCustodiansNeeded:
        _handleSendLocalCustodiansNeededAction();
    }
  }

  void onStake() {
    if (wmParams.value.disableSensetiveActions ||
        _hasStakeState.value != true) {
      return;
    }

    if (_numberUnconfirmedTransactions >= 5) {
      model.showMessage(
        Message.error(
          message: LocaleKeys.errorMessageMaxUnconfirmedTransactions.tr(),
        ),
      );
    } else {
      contextSafe?.compassContinue(
        StakingRouteData(accountAddress: wmParams.value.account.address),
      );
    }
  }

  void onInfo() {
    showAccountSettingsModal(
      context: context,
      account: wmParams.value.account,
      custodians: _custodians,
    );
  }

  void _handleSendAction() {
    if (_numberUnconfirmedTransactions >= 5) {
      model.showMessage(
        Message.error(
          message: LocaleKeys.errorMessageMaxUnconfirmedTransactions.tr(),
        ),
      );
      return;
    }

    final params = wmParams.value;
    if (params.sendSpecified) {
      contextSafe?.compassContinue(
        WalletPrepareSpecifiedTransferRouteData(
          address: params.account.address,
          rootTokenContract: model.nativeTokenAddress,
          tokenSymbol: model.nativeTokenTicker,
        ),
      );
    } else {
      contextSafe?.compassContinue(
        WalletPrepareTransferRouteData(
          address: params.account.address,
        ),
      );
    }
  }

  void _handleDeployAction() {
    if (contextSafe == null) return;

    if (_balance >= _minBalance) {
      // Show wallet type selection bottom sheet
      showWalletTypeSelectionSheet(
        context: contextSafe!,
        address: wmParams.value.account.address,
        publicKey: wmParams.value.account.publicKey,
      );
    } else {
      showDeployMinEverModal(
        context: contextSafe!,
        account: wmParams.value.account,
        minAmount: _minBalance,
        symbol: model.nativeTokenTicker,
      );
    }
  }

  void _handleSendLocalCustodiansNeededAction() {
    model.showMessage(
      Message.error(
        message: LocaleKeys.toSendMultisigAddCustodian.tr(),
        actionText: LocaleKeys.addWord.tr(),
        onAction: _showAddSeedSheet,
      ),
    );
  }

  Future<void> _showAddSeedSheet() async {
    final selected = await showSelectAddSeedTypeSheet(context);

    if (contextSafe != null && selected != null) {
      switch (selected) {
        case SelectAddSeedType.create:
          contextSafe?.compassContinue(
            const EnterSeedNameRouteData(
              command: EnterSeedNameCommand.create,
            ),
          );
        case SelectAddSeedType.import:
          contextSafe?.compassContinue(
            const EnterSeedNameRouteData(
              command: EnterSeedNameCommand.import,
            ),
          );
        case SelectAddSeedType.ledger:
          contextSafe?.compassContinue(
            const EnterSeedNameRouteData(
              command: EnterSeedNameCommand.ledger,
            ),
          );
      }
    }
  }
}
