import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/feature/wallet/token_wallet_send/data/data.dart';
import 'package:app/feature/wallet/token_wallet_send/view/token_wallet_send_model.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class TokenWalletSendWmParams {
  const TokenWalletSendWmParams({
    required this.owner,
    required this.rootTokenContract,
    required this.publicKey,
    required this.destination,
    required this.amount,
    required this.attachedAmount,
    required this.comment,
    required this.resultMessage,
    required this.notifyReceiver,
  });

  final Address owner;
  final Address rootTokenContract;
  final PublicKey publicKey;
  final Address destination;
  final BigInt amount;
  final BigInt? attachedAmount;
  final String? comment;
  final String? resultMessage;
  final bool? notifyReceiver;
}

@injectable
class TokenWalletSendWidgetModel extends CustomWidgetModelParametrized<
    InjectedElementaryParametrizedWidget<TokenWalletSendWidgetModel,
        TokenWalletSendWmParams>,
    TokenWalletSendModel,
    TokenWalletSendWmParams> with BleAvailabilityWmMixin {
  // extends CustomWidgetModel<ElementaryWidget, TokenWalletSendModel> {
  TokenWalletSendWidgetModel(
    super.model,
  );

  static final _logger = Logger('TokenWalletSendWidgetModel');

  late final _isLoadingState = createNotifier(false);
  late final _feesState = createEntityNotifier<Fee>()..loading();
  late final _txErrorsState = createNotifier<List<TxTreeSimulationErrorItem>>();
  late final _sendState = createNotifier(const TokenWalletSendState.ready());
  late final _attachedAmountState =
      createNotifier(wmParams.value.attachedAmount ?? BigInt.zero);
  late final _amountState = createNotifier<Money>();

  late final KeyAccount? account = model.getAccount(wmParams.value.owner);

  TonWallet? _wallet;
  GenericTokenWallet? _tokenWallet;
  PreparedTokenTransfer? _transfer;

  Address get owner => wmParams.value.owner;
  Address get rootTokenContract => wmParams.value.rootTokenContract;
  PublicKey get publicKey => wmParams.value.publicKey;
  Address get destination => wmParams.value.destination;
  String? get comment => wmParams.value.comment;
  Currency get currency => model.currency;

  ListenableState<bool> get isLoadingState => _isLoadingState;

  EntityValueListenable<Fee> get feesState => _feesState;

  ListenableState<List<TxTreeSimulationErrorItem>> get txErrorsState =>
      _txErrorsState;

  ListenableState<TokenWalletSendState> get sendState => _sendState;

  ListenableState<BigInt> get attachedAmountState => _attachedAmountState;

  ListenableState<Money> get amountState => _amountState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  SignInputAuthLedger getLedgerAuthInput() {
    if (_wallet == null || _tokenWallet == null) {
      throw StateError('Wallet or token wallet is not initialized');
    }

    return model.getLedgerAuthInput(
      wallet: _wallet!,
      tokenWallet: _tokenWallet!,
      custodian: publicKey,
    );
  }

  Future<void> onConfirmed(SignInputAuth signInputAuth) async {
    if (_transfer == null) return;

    try {
      _isLoadingState.accept(true);

      if (signInputAuth.isLedger) {
        final isAvailable = await checkBluetoothAvailability();
        if (!isAvailable) return;
      }

      final resultMessage = wmParams.value.resultMessage ??
          LocaleKeys.transactionSentSuccessfully.tr();

      final transactionCompleter = await model.sendMessage(
        transfer: _transfer!,
        publicKey: wmParams.value.publicKey,
        signInputAuth: signInputAuth,
      );

      _sendState.accept(const TokenWalletSendState.sending(canClose: true));

      await transactionCompleter.future;

      model.showMessage(Message.successful(message: resultMessage));

      contextSafe?.compassPointNamed(
        const WalletRouteData(),
      );
    } on OperationCanceledException catch (_) {
      // TODO(Levitsky): Now exception is muted, but in future
      // _nekotonRepository could be improved, to graceful
      // handle account change.
    } on Exception catch (e, s) {
      if (e is AnyhowException && e.isCancelled) return;
      _logger.severe('Failed to send transaction', e, s);
      model.showMessage(
        Message.error(message: LocaleKeys.failedToSendTransaction.tr()),
      );
    } finally {
      _isLoadingState.accept(false);
    }
  }

  Future<void> _init() async {
    try {
      _isLoadingState.accept(true);

      await model.initTransfer(
        owner: wmParams.value.owner,
        rootTokenContract: wmParams.value.rootTokenContract,
      );

      final (tokenWalletState, walletState) = await FutureExt.wait2(
        model.getTokenWalletState(
          owner: wmParams.value.owner,
          rootTokenContract: wmParams.value.rootTokenContract,
        ),
        model.getWalletState(wmParams.value.owner),
      );

      if (tokenWalletState.hasError) {
        _sendState.accept(
          TokenWalletSendState.error(error: tokenWalletState.error!),
        );
        return;
      }
      if (walletState.hasError) {
        _sendState
            .accept(TokenWalletSendState.error(error: walletState.error!));
        return;
      }

      _amountState.accept(
        Money.fromBigIntWithCurrency(
          wmParams.value.amount,
          tokenWalletState.wallet!.currency,
        ),
      );

      final transfer = await model.prepareTransfer(
        owner: wmParams.value.owner,
        rootTokenContract: wmParams.value.rootTokenContract,
        publicKey: wmParams.value.publicKey,
        destination: wmParams.value.destination,
        amount: wmParams.value.amount,
        comment: wmParams.value.comment,
        attachedAmount: wmParams.value.attachedAmount,
        notifyReceiver: wmParams.value.notifyReceiver,
      );

      _transfer = transfer;
      _attachedAmountState.accept(
        (transfer is PreparedTokenTransferBasic)
            ? transfer.attachedAmount
            : null,
      );

      final (fee, txErrors) = await FutureExt.wait2(
        model.estimateFees(transfer),
        model.simulateTransactionTree(transfer),
      );

      _feesState.content(fee);
      _txErrorsState.accept(txErrors);
      _wallet = walletState.wallet;
      _tokenWallet = tokenWalletState.wallet;

      final canSend = _canSend(transfer: transfer, fee: fee);

      if (!canSend) {
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
        UiException(LocaleKeys.failedToPrepareTransaction.tr()),
        _feesState.value.data,
      );
    } finally {
      _isLoadingState.accept(false);
    }
  }

  bool _canSend({
    required PreparedTokenTransfer transfer,
    required Fee fee,
  }) {
    if (_wallet == null || _tokenWallet == null) return false;

    return switch (transfer) {
      PreparedTokenTransferBasic(:final attachedAmount) when fee is FeeNative =>
        _wallet!.contractState.balance > (attachedAmount + fee.minorUnits),
      PreparedTokenTransferGasless(:final rootTokenContract)
          when fee is FeeToken =>
        // ignore: avoid_bool_literals_in_conditional_expressions
        fee.tokenRootAddress == rootTokenContract
            ? _tokenWallet!.balance >= (fee.minorUnits + transfer.amount)
            // comission token is not same as transfer token (not supported)
            : false,
      _ => false, // invalid state
    };
  }
}
