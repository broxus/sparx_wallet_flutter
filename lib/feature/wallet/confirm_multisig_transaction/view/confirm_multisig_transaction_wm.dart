import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/data/data.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_model.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/view/confirm_multisig_transaction_widget.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class ConfirmMultisigTransactionWmParams {
  const ConfirmMultisigTransactionWmParams({
    required this.walletAddress,
    required this.localCustodians,
    required this.transactionId,
    required this.amount,
    required this.destination,
    required this.comment,
    this.transactionIdHash,
  });

  final Address walletAddress;
  final List<PublicKey> localCustodians;
  final String transactionId;
  final String? transactionIdHash;
  final BigInt amount;
  final Address destination;
  final String? comment;
}

@injectable
class ConfirmMultisigTransactionWidgetModel
    extends CustomWidgetModelParametrized<
        ConfirmMultisigTransactionWidget,
        ConfirmMultisigTransactionModel,
        ConfirmMultisigTransactionWmParams> with BleAvailabilityWmMixin {
  ConfirmMultisigTransactionWidgetModel(
    super.model,
  );

  static final _logger = Logger('ConfirmMultisigTransactionWidgetModel');

  late final _isLoading = createNotifier(false);
  late final _fees = createNotifier<BigInt>();
  late final _txErrors = createNotifier<List<TxTreeSimulationErrorItem>>();
  late final _error = createNotifier<String>();
  late final _state = createNotifier<ConfirmMultisigTransactionState>();

  late final KeyAccount? account = model.getAccount(_walletAddress);
  late final Map<PublicKey, String?> custodianNames = Map.fromEntries(
    wmParams.value.localCustodians
        .map((c) => MapEntry(c, model.getSeedKey(c)?.name)),
  );
  late final Money amount = Money.fromBigIntWithCurrency(
    wmParams.value.amount,
    currency,
  );

  PublicKey? _custodian;
  TonWallet? _wallet;

  Address get _walletAddress => wmParams.value.walletAddress;
  List<PublicKey> get localCustodians => wmParams.value.localCustodians;
  String get transactionId => wmParams.value.transactionId;
  String? get transactionIdHash => wmParams.value.transactionIdHash;
  Address get destination => wmParams.value.destination;
  String? get comment => wmParams.value.comment;

  ListenableState<bool> get isLoading => _isLoading;

  ListenableState<BigInt> get fees => _fees;

  ListenableState<List<TxTreeSimulationErrorItem>> get txErrors => _txErrors;

  ListenableState<String> get error => _error;

  ListenableState<ConfirmMultisigTransactionState> get state => _state;

  Currency get currency => Currencies()[model.transport.nativeTokenTicker]!;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    if (wmParams.value.localCustodians.length == 1) {
      onCustodianSelected(wmParams.value.localCustodians.first);
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

      final walletState = await model.getWalletState(_walletAddress);
      if (walletState.hasError) {
        _state.accept(
          ConfirmMultisigTransactionState.error(error: walletState.error!),
        );
        return;
      }

      unsignedMessage = await model.prepareConfirmTransaction(
        address: _walletAddress,
        publicKey: custodian,
        transactionId: wmParams.value.transactionId,
      );

      final (fees, txErrors) = await FutureExt.wait2(
        model.estimateFees(
          address: _walletAddress,
          message: unsignedMessage,
        ),
        model.simulateTransactionTree(
          address: _walletAddress,
          message: unsignedMessage,
        ),
      );

      _fees.accept(fees);
      _txErrors.accept(txErrors);
      _wallet = walletState.wallet;

      final wallet = walletState.wallet!;
      final balance = wallet.contractState.balance;
      final isPossibleToSendMessage = balance > (fees + wmParams.value.amount);

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
        address: _walletAddress,
        publicKey: _custodian!,
        transactionId: wmParams.value.transactionId,
      );

      final transactionCompleter = await model.sendMessage(
        address: _walletAddress,
        destination: wmParams.value.destination,
        publicKey: _custodian!,
        message: unsignedMessage,
        amount: wmParams.value.amount,
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
