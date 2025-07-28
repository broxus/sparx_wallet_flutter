import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/feature/wallet/ton_wallet_send/data/ton_wallet_send_state.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_model.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

TonWalletSendWidgetModel defaultTonWalletSendWidgetModelFactory(
  BuildContext context,
) =>
    TonWalletSendWidgetModel(
      TonWalletSendModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class TonWalletSendWidgetModel
    extends CustomWidgetModel<TonWalletSendWidget, TonWalletSendModel>
    with BleAvailabilityWmMixin {
  TonWalletSendWidgetModel(super.model);

  static final _logger = Logger('TonWalletSendWidgetModel');

  late final _isLoading = createNotifier(false);
  late final _fees = createNotifier<BigInt>();
  late final _txErrors = createNotifier<List<TxTreeSimulationErrorItem>>();
  late final _error = createNotifier<String>();
  late final _state = createNotifier(const TonWalletSendState.ready());

  late final data = widget.data;
  late final KeyAccount? account = model.getAccount(data.address);
  late final Money amount = Money.fromBigIntWithCurrency(data.amount, currency);

  Currency get currency => model.currency;

  ListenableState<bool> get isLoading => _isLoading;

  ListenableState<BigInt> get fees => _fees;

  ListenableState<List<TxTreeSimulationErrorItem>> get txErrors => _txErrors;

  ListenableState<String> get error => _error;

  ListenableState<TonWalletSendState> get state => _state;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<SignInputAuthLedger> getLedgerAuthInput() => model.getLedgerAuthInput(
        address: data.address,
        custodian: data.publicKey,
      );

  Future<void> onConfirmed(SignInputAuth signInputAuth) async {
    UnsignedMessage? unsignedMessage;
    try {
      _isLoading.accept(true);

      if (signInputAuth.isLedger) {
        final isAvailable = await checkBluetoothAvailability();
        if (!isAvailable) return;
      }

      final resultMessage =
          data.resultMessage ?? LocaleKeys.transactionSentSuccessfully.tr();
      final totalAmount = data.amount + (data.attachedAmount ?? BigInt.zero);

      unsignedMessage = await model.prepareTransfer(
        address: data.address,
        publicKey: data.publicKey,
        destination: data.destination,
        amount: totalAmount,
        comment: data.comment,
        payload: data.payload,
      );

      final transactionCompleter = await model.sendMessage(
        address: data.address,
        publicKey: data.publicKey,
        message: unsignedMessage,
        signInputAuth: signInputAuth,
        destination: data.destination,
        amount: totalAmount,
      );

      _state.accept(const TonWalletSendState.sending(canClose: true));

      await transactionCompleter;

      model.showMessage(Message.successful(message: resultMessage));

      if (!isMounted) return;

      if (data.popOnComplete) {
        contextSafe?.compassBack(true);
      } else {
        contextSafe?.compassPointNamed(const WalletRouteData());
      }
    } on OperationCanceledException catch (_) {
      // TODO(Levitsky): Now exception is muted, but in future
      // _nekotonRepository could be improved, to graceful
      // handle account change.
    } on Exception catch (e, s) {
      _logger.severe('Failed to send transaction', e, s);
      model.showMessage(Message.error(message: e.toString()));
    } finally {
      unsignedMessage?.dispose();
      _isLoading.accept(false);
    }
  }

  Future<void> _init() async {
    UnsignedMessage? unsignedMessage;
    try {
      _isLoading.accept(true);

      final walletState = await model.getWalletState(data.address);
      if (walletState.hasError) {
        _state.accept(TonWalletSendState.error(error: walletState.error!));
        return;
      }

      final totalAmount = data.amount + (data.attachedAmount ?? BigInt.zero);

      unsignedMessage = await model.prepareTransfer(
        address: data.address,
        publicKey: data.publicKey,
        destination: data.destination,
        amount: totalAmount,
        comment: data.comment,
        payload: data.payload,
      );

      final (fees, txErrors) = await FutureExt.wait2(
        model.estimateFees(
          address: data.address,
          message: unsignedMessage,
        ),
        model.simulateTransactionTree(
          address: data.address,
          message: unsignedMessage,
        ),
      );

      _fees.accept(fees);
      _txErrors.accept(txErrors);

      final wallet = walletState.wallet!;
      final balance = wallet.contractState.balance;
      final isPossibleToSendMessage = balance > (fees + totalAmount);

      if (!isPossibleToSendMessage) {
        _error.accept(LocaleKeys.insufficientFunds.tr());
      }
    } on ContractNotExistsException catch (e, s) {
      _logger.severe('Failed to prepare transaction', e, s);
      _error.accept(LocaleKeys.insufficientFunds.tr());
    } on Exception catch (e, s) {
      _logger.severe('Failed to prepare transaction', e, s);
      _error.accept(e.toString());
    } finally {
      unsignedMessage?.dispose();
      _isLoading.accept(false);
    }
  }
}
