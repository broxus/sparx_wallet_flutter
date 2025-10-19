import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/feature/wallet/ton_wallet_send/data/data.dart';
import 'package:app/feature/wallet/ton_wallet_send/route.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_model.dart';
import 'package:app/feature/wallet/ton_wallet_send/view/ton_wallet_send_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class TonWalletSendWidgetModel extends CustomWidgetModelParametrized<
    TonWalletSendWidget,
    TonWalletSendModel,
    TonWalletSendRouteData> with BleAvailabilityWmMixin {
  TonWalletSendWidgetModel(
    super.model,
  );

  static final _logger = Logger('TonWalletSendWidgetModel');

  late final _isLoadingState = createNotifier(false);
  late final _feesState = createEntityNotifier<Fee>()..loading();
  late final _txErrorsState = createNotifier<List<TxTreeSimulationErrorItem>>();
  late final _sendState = createNotifier(const TonWalletSendState.ready());

  late final KeyAccount? account = model.getAccount(wmParams.value.address);
  late final Money amount =
      Money.fromBigIntWithCurrency(wmParams.value.amount, currency);

  Currency get currency => model.currency;

  ListenableState<bool> get isLoadingState => _isLoadingState;

  EntityValueListenable<Fee> get feesState => _feesState;

  ListenableState<List<TxTreeSimulationErrorItem>> get txErrorsState =>
      _txErrorsState;

  ListenableState<TonWalletSendState> get sendState => _sendState;

  PublicKey get publicKey => wmParams.value.publicKey;

  Address get destination => wmParams.value.destination;

  bool get popOnComplete => wmParams.value.popOnComplete;

  BigInt? get attachedAmount => wmParams.value.attachedAmount;

  String? get comment => wmParams.value.comment;

  String? get payload => wmParams.value.payload;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<SignInputAuthLedger> getLedgerAuthInput() => model.getLedgerAuthInput(
        address: wmParams.value.address,
        custodian: wmParams.value.publicKey,
      );

  Future<void> onConfirmed(SignInputAuth signInputAuth) async {
    UnsignedMessage? unsignedMessage;
    try {
      _isLoadingState.accept(true);

      if (signInputAuth.isLedger) {
        final isAvailable = await checkBluetoothAvailability();
        if (!isAvailable) return;
      }

      final data = wmParams.value;
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

      _sendState.accept(const TonWalletSendState.sending(canClose: true));

      await transactionCompleter;

      model.showMessage(Message.successful(message: resultMessage));

      if (!isMounted) return;

      if (data.popOnComplete) {
        contextSafe?.compassBack(true);
      } else {
        contextSafe?.compassPointNamed(const WalletRouteData());
      }
    } on OperationCanceledException {
      // TODO(Levitsky): Now exception is muted, but in future
      // _nekotonRepository could be improved, to graceful
      // handle account change.
    } on Exception catch (e, s) {
      if (e is AnyhowException && e.isCancelled) return;
      _logger.severe('Failed to send transaction', e, s);
      model.showMessage(Message.error(message: e.toString()));
    } finally {
      unsignedMessage?.dispose();
      _isLoadingState.accept(false);
    }
  }

  Future<void> _init() async {
    UnsignedMessage? unsignedMessage;
    try {
      if (!model.checkIsValidWorkchain(wmParams.value.destination.address)) {
        _feesState.error(
          UiException(LocaleKeys.invalidWorkchainAddressFrom0To1.tr()),
          _feesState.value.data,
        );
        return;
      }

      _isLoadingState.accept(true);

      final data = wmParams.value;
      final walletState = await model.getWalletState(data.address);
      if (walletState.hasError) {
        _sendState.accept(TonWalletSendState.error(error: walletState.error!));
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

      _feesState.content(
        Fee.native(
          Money.fromBigIntWithCurrency(fees, currency),
        ),
      );
      _txErrorsState.accept(txErrors);

      final wallet = walletState.wallet!;
      final balance = wallet.contractState.balance;
      final isPossibleToSendMessage = balance > (fees + totalAmount);

      if (!isPossibleToSendMessage) {
        _feesState.error(
          UiException(LocaleKeys.insufficientFunds.tr()),
          _feesState.value.data,
        );
      }
    } on ContractNotExistsException catch (e, s) {
      _logger.severe('Failed to prepare transaction', e, s);
      _feesState.error(
        UiException(LocaleKeys.insufficientFunds.tr()),
        _feesState.value.data,
      );
    } on Exception catch (e, s) {
      _logger.severe('Failed to prepare transaction', e, s);
      _feesState.error(
        UiException(e.toString()),
        _feesState.value.data,
      );
    } finally {
      unsignedMessage?.dispose();
      _isLoadingState.accept(false);
    }
  }
}
