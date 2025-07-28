import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/data/data.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_model.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_widget.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

ConfirmMultisigTransactionWidgetModel
    defaultConfirmMultisigTransactionWidgetModelFactory(
  BuildContext context,
) =>
        ConfirmMultisigTransactionWidgetModel(
          ConfirmMultisigTransactionModel(
            createPrimaryErrorHandler(context),
            inject(),
            inject(),
            inject(),
          ),
        );

class ConfirmMultisigTransactionWidgetModel extends CustomWidgetModel<
    ConfirmMultisigTransactionWidget,
    ConfirmMultisigTransactionModel> with BleAvailabilityWmMixin {
  ConfirmMultisigTransactionWidgetModel(super.model);

  static final _logger = Logger('ConfirmMultisigTransactionWidgetModel');

  late final _isLoading = createNotifier(false);
  late final _fees = createNotifier<BigInt>();
  late final _txErrors = createNotifier<List<TxTreeSimulationErrorItem>>();
  late final _error = createNotifier<String>();
  late final _state = createNotifier<ConfirmMultisigTransactionState>();

  late final KeyAccount? account = model.getAccount(widget.walletAddress);
  late final Map<PublicKey, String?> custodianNames = Map.fromEntries(
    widget.localCustodians.map((c) => MapEntry(c, model.getSeedKey(c)?.name)),
  );
  late final Money amount = Money.fromBigIntWithCurrency(
    widget.amount,
    currency,
  );

  PublicKey? _custodian;
  TonWallet? _wallet;

  ListenableState<bool> get isLoading => _isLoading;

  ListenableState<BigInt> get fees => _fees;

  ListenableState<List<TxTreeSimulationErrorItem>> get txErrors => _txErrors;

  ListenableState<String> get error => _error;

  ListenableState<ConfirmMultisigTransactionState> get state => _state;

  Currency get currency => Currencies()[model.transport.nativeTokenTicker]!;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    if (widget.localCustodians.length == 1) {
      onCustodianSelected(widget.localCustodians.first);
    } else {
      _state.accept(
        const ConfirmMultisigTransactionState.prepare(),
      );
    }
  }

  SignInputAuthLedger getLedgerAuthInput() {
    if (_wallet == null) {
      throw StateError('Wallet is not initialized');
    }

    return model.getLedgerAuthInput(
      wallet: _wallet!,
      currency: currency,
    );
  }

  Future<void> onCustodianSelected(PublicKey custodian) async {
    _custodian = custodian;

    UnsignedMessage? unsignedMessage;
    try {
      _isLoading.accept(true);
      _state.accept(
        ConfirmMultisigTransactionState.ready(custodian: custodian),
      );

      final walletState = await model.getWalletState(widget.walletAddress);
      if (walletState.hasError) {
        _state.accept(
          ConfirmMultisigTransactionState.error(error: walletState.error!),
        );
        return;
      }

      unsignedMessage = await model.prepareConfirmTransaction(
        address: widget.walletAddress,
        publicKey: custodian,
        transactionId: widget.transactionId,
      );

      final (fees, txErrors) = await FutureExt.wait2(
        model.estimateFees(
          address: widget.walletAddress,
          message: unsignedMessage,
        ),
        model.simulateTransactionTree(
          address: widget.walletAddress,
          message: unsignedMessage,
        ),
      );

      _fees.accept(fees);
      _txErrors.accept(txErrors);
      _wallet = walletState.wallet;

      final wallet = walletState.wallet!;
      final balance = wallet.contractState.balance;
      final isPossibleToSendMessage = balance > (fees + widget.amount);

      if (!isPossibleToSendMessage) {
        _error.accept(LocaleKeys.insufficientFunds.tr());
      }
    } on Exception catch (e, t) {
      _logger.severe('onCustodianSelected', e, t);
      _error.accept(e.toString());
    } finally {
      unsignedMessage?.dispose();
      _isLoading.accept(false);
    }
  }

  Future<void> onConfirmed(SignInputAuth signInputAuth) async {
    if (_custodian == null) return;

    UnsignedMessage? unsignedMessage;
    try {
      _isLoading.accept(true);

      if (signInputAuth.isLedger) {
        final isAvailable = await checkBluetoothAvailability();
        if (!isAvailable) return;
      }

      unsignedMessage = await model.prepareConfirmTransaction(
        address: widget.walletAddress,
        publicKey: _custodian!,
        transactionId: widget.transactionId,
      );

      final transactionCompleter = await model.sendMessage(
        address: widget.walletAddress,
        destination: widget.destination,
        publicKey: _custodian!,
        message: unsignedMessage,
        amount: widget.amount,
        signInputAuth: signInputAuth,
      );

      _state.accept(
        const ConfirmMultisigTransactionState.sending(canClose: true),
      );

      await transactionCompleter;

      model.showMessage(
        Message.successful(
          message: LocaleKeys.transactionSentSuccessfully.tr(),
        ),
      );

      contextSafe?.compassPointNamed(
        const WalletRouteData(),
      );
    } on OperationCanceledException catch (_) {
    } on Exception catch (e, t) {
      _logger.severe('onPasswordEntered', e, t);
      model.showMessage(Message.error(message: e.toString()));
    } finally {
      unsignedMessage?.dispose();
      _isLoading.accept(false);
    }
  }
}
