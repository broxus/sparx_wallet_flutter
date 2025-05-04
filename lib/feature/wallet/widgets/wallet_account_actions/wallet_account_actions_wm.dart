import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/wallet_deploy/widgets/deploy_wallet_min_ever_modal.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings.dart';
import 'package:app/feature/wallet/widgets/wallet_account_actions/wallet_account_actions_model.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v1/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

/// Action that describes behavior for account.
enum WalletAccountActionBehavior {
  deploy, // deploy wallet needed
  send, // send without any restrictions
  sendLocalCustodiansNeeded, // send button but with showing snackbar
}

WalletAccountActionsWidgetModel defaultWalletAccountActionsWidgetModelFactory(
  BuildContext context,
) {
  return WalletAccountActionsWidgetModel(
    WalletAccountActionsModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      inject(),
    ),
  );
}

/// Widget model for wallet account actions, handles state management
class WalletAccountActionsWidgetModel
    extends CustomWidgetModel<WalletAccountActions, WalletAccountActionsModel> {
  WalletAccountActionsWidgetModel(super.model);

  static final _logger = Logger('WalletAccountActionsWidgetModel');

  late final _action = createNotifier<WalletAccountActionBehavior>(
    WalletAccountActionBehavior.send,
  );
  late final _hasStake = createNotifier(model.hasStake && widget.allowStake);
  late final _hasStakeActions = createNotifier(false);

  int _numberUnconfirmedTransactions = 0;
  BigInt _balance = BigInt.zero;
  BigInt _minBalance = BigInt.zero;
  List<PublicKey>? _custodians;
  TonWallet? _wallet;
  StreamSubscription<TonWallet>? _walletSubscription;
  StreamSubscription<List<StEverWithdrawRequest>>? _withdrawsSubscription;

  ListenableState<WalletAccountActionBehavior> get action => _action;

  ListenableState<bool> get hasStake => _hasStake;

  ListenableState<bool> get hasStakeActions => _hasStakeActions;

  @override
  void initWidgetModel() {
    _walletSubscription =
        model.getWalletStateStream(widget.account.address).listen(_onWallet);
    super.initWidgetModel();
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
      model.getWithdrawRequestsStream(widget.account.address),
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
          widget.account.address,
        );
        action = localCustodians != null && localCustodians.isNotEmpty
            ? WalletAccountActionBehavior.send
            : WalletAccountActionBehavior.sendLocalCustodiansNeeded;
      } else {
        action = WalletAccountActionBehavior.deploy;
      }

      final hasStakeValue = action != WalletAccountActionBehavior.deploy &&
          model.hasStake &&
          widget.allowStake;

      _action.accept(action);
      _hasStake.accept(hasStakeValue);
      _hasStakeActions.accept(hasStakeValue && withdraws.isNotEmpty);

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
      final message = await model.prepareDeploy(widget.account.address);
      final fees = await model.estimateDeploymentFees(
        address: widget.account.address,
        message: message,
      );

      _minBalance = fees;
    } catch (e, s) {
      _logger.severe('estimateFees', e, s);
    }
  }

  void onReceive() {
    if (widget.disableSensetiveActions) return;

    showReceiveFundsSheet(context, widget.account.address);
  }

  void onMainAction() {
    final action = _action.value;

    if (widget.disableSensetiveActions || action == null) {
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
    if (widget.disableSensetiveActions || _hasStake.value != true) {
      return;
    }

    if (_numberUnconfirmedTransactions >= 5) {
      model.showMessage(
        Message.error(
          message: LocaleKeys.errorMessageMaxUnconfirmedTransactions.tr(),
        ),
      );
    } else {
      context.goFurther(
        AppRoute.walletStake.pathWithData(
          pathParameters: {
            walletStakeAddressPathParam: widget.account.address.address,
          },
        ),
      );
    }
  }

  void onInfo() {
    showAccountSettingsModal(
      context: context,
      account: widget.account,
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

    if (widget.sendSpecified) {
      context.goFurther(
        AppRoute.walletPrepareTransferSpecified.pathWithData(
          pathParameters: {
            walletPrepareTransferAddressPathParam:
                widget.account.address.address,
            walletPrepareTransferRootTokenAddressPathParam:
                model.nativeTokenAddress.address,
            walletPrepareTransferSymbolPathParam: model.nativeTokenTicker,
          },
        ),
      );
    } else {
      context.goFurther(
        AppRoute.walletPrepareTransfer.pathWithData(
          pathParameters: {
            walletPrepareTransferAddressPathParam:
                widget.account.address.address,
          },
        ),
      );
    }
  }

  void _handleDeployAction() {
    if (contextSafe == null) return;

    if (_balance >= _minBalance) {
      contextSafe!.goFurther(
        AppRoute.walletDeploy.pathWithData(
          pathParameters: {
            walletDeployAddressPathParam: widget.account.address.address,
            walletDeployPublicKeyPathParam: widget.account.publicKey.publicKey,
          },
        ),
      );
    } else {
      showDeployMinEverModal(
        context: contextSafe!,
        account: widget.account,
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
          contextSafe!.goFurther(
            AppRoute.enterSeedName.pathWithData(
              pathParameters: {
                enterSeedNameCommandPathParam: EnterSeedNameCommand.create.name,
              },
            ),
          );
        case SelectAddSeedType.import:
          contextSafe!.goFurther(
            AppRoute.enterSeedName.pathWithData(
              pathParameters: {
                enterSeedNameCommandPathParam: EnterSeedNameCommand.import.name,
              },
            ),
          );
      }
    }
  }
}
