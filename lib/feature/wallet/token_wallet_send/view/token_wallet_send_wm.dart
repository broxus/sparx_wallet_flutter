import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
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
class TokenWalletSendWidgetModel extends InjectedWidgetModel<
    InjectedElementaryParametrizedWidget<TokenWalletSendWidgetModel,
        TokenWalletSendWmParams>,
    TokenWalletSendModel,
    TokenWalletSendWmParams> {
  // extends CustomWidgetModel<ElementaryWidget, TokenWalletSendModel> {
  TokenWalletSendWidgetModel(
    super.model,
  );

  static final _logger = Logger('TokenWalletSendWidgetModel');

  late final _isLoading = createNotifier(false);
  late final _fees = createNotifier<BigInt>();
  late final _txErrors = createNotifier<List<TxTreeSimulationErrorItem>>();
  late final _error = createNotifier<String>();
  late final _state = createNotifier(const TokenWalletSendState.ready());
  late final _attachedAmount =
      createNotifier(wmParams.value.attachedAmount ?? BigInt.zero);
  late final _amount = createNotifier<Money>();

  late final KeyAccount? account = model.getAccount(wmParams.value.owner);

  Address get owner => wmParams.value.owner;
  Address get rootTokenContract => wmParams.value.rootTokenContract;
  PublicKey get publicKey => wmParams.value.publicKey;
  Address get destination => wmParams.value.destination;
  String? get comment => wmParams.value.comment;
  Currency get currency => model.currency;

  ListenableState<bool> get isLoading => _isLoading;

  ListenableState<BigInt> get fees => _fees;

  ListenableState<List<TxTreeSimulationErrorItem>> get txErrors => _txErrors;

  ListenableState<String> get error => _error;

  ListenableState<TokenWalletSendState> get state => _state;

  ListenableState<BigInt> get attachedAmount => _attachedAmount;

  ListenableState<Money> get amount => _amount;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<void> onPasswordEntered(String password) async {
    UnsignedMessage? unsignedMessage;
    InternalMessage? internalMessage;
    try {
      _isLoading.accept(true);

      final resultMessage = wmParams.value.resultMessage ??
          LocaleKeys.transactionSentSuccessfully.tr();

      (internalMessage, unsignedMessage) = await model.prepareTransfer(
        owner: wmParams.value.owner,
        rootTokenContract: wmParams.value.rootTokenContract,
        publicKey: wmParams.value.publicKey,
        destination: wmParams.value.destination,
        amount: wmParams.value.amount,
        comment: wmParams.value.comment,
        attachedAmount: wmParams.value.attachedAmount,
        notifyReceiver: wmParams.value.notifyReceiver,
      );

      final transactionCompleter = await model.sendMessage(
        address: wmParams.value.owner,
        publicKey: wmParams.value.publicKey,
        message: unsignedMessage,
        password: password,
        destination: internalMessage.destination,
        amount: internalMessage.amount,
      );

      _state.accept(const TokenWalletSendState.sending(canClose: true));

      await transactionCompleter;

      model.showMessage(Message.successful(message: resultMessage));

      contextSafe?.compassPointNamed(
        const WalletRouteData(),
      );
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
    InternalMessage? internalMessage;
    try {
      _isLoading.accept(true);

      final (tokenWalletState, walletState) = await FutureExt.wait2(
        model.getTokenWalletState(
          owner: wmParams.value.owner,
          rootTokenContract: wmParams.value.rootTokenContract,
        ),
        model.getWalletState(wmParams.value.owner),
      );

      if (tokenWalletState.hasError) {
        _state.accept(
          TokenWalletSendState.error(error: tokenWalletState.error!),
        );
        return;
      }
      if (walletState.hasError) {
        _state.accept(TokenWalletSendState.error(error: walletState.error!));
        return;
      }

      _amount.accept(
        Money.fromBigIntWithCurrency(
          wmParams.value.amount,
          tokenWalletState.wallet!.currency,
        ),
      );

      (internalMessage, unsignedMessage) = await model.prepareTransfer(
        owner: wmParams.value.owner,
        rootTokenContract: wmParams.value.rootTokenContract,
        publicKey: wmParams.value.publicKey,
        destination: wmParams.value.destination,
        amount: wmParams.value.amount,
        comment: wmParams.value.comment,
        attachedAmount: wmParams.value.attachedAmount,
        notifyReceiver: wmParams.value.notifyReceiver,
      );

      _attachedAmount.accept(internalMessage.amount);

      final (fees, txErrors) = await FutureExt.wait2(
        model.estimateFees(
          address: wmParams.value.owner,
          message: unsignedMessage,
        ),
        model.simulateTransactionTree(
          address: wmParams.value.owner,
          message: unsignedMessage,
        ),
      );

      _fees.accept(fees);
      _txErrors.accept(txErrors);

      final wallet = walletState.wallet!;
      final balance = wallet.contractState.balance;
      final isPossibleToSendMessage = balance > (fees + internalMessage.amount);

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
