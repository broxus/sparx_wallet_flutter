import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class NftSendWidgetModel extends CustomWidgetModelParametrized<NftSendWidget,
    NftSendModel, NftSendRouteData> with BleAvailabilityWmMixin {
  NftSendWidgetModel(
    super.model,
  );

  static final _logger = Logger('NftSendWidgetModel');

  late final _loadingState = createNotifier(false);
  late final _collectionState = createNotifier<NftCollection>();
  late final _itemState = createNotifier<NftItem>();
  late final _attachedAmountState = createNotifier<BigInt>();
  late final _feesState = createNotifier<BigInt>();
  late final _txErrorsState = createNotifier<List<TxTreeSimulationErrorItem>>();
  late final _errorState = createNotifier<String>();
  late final _sendState = createNotifier(const NftSendState.ready());

  late final KeyAccount? account = model.getAccount(wmParams.value.owner);

  Currency get currency => model.currency;

  ListenableState<bool> get loadingState => _loadingState;

  ListenableState<BigInt> get attachedAmountState => _attachedAmountState;

  ListenableState<BigInt> get feesState => _feesState;

  ListenableState<List<TxTreeSimulationErrorItem>> get txErrorsState =>
      _txErrorsState;

  ListenableState<String> get errorState => _errorState;

  ListenableState<NftSendState> get sendState => _sendState;

  ListenableState<NftCollection> get collectionState => _collectionState;

  ListenableState<NftItem> get itemState => _itemState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<SignInputAuthLedger> getLedgerAuthInput() {
    return model.getLedgerAuthInput(
      address: wmParams.value.owner,
      custodian: wmParams.value.publicKey,
    );
  }

  Future<void> onConfirmed(SignInputAuth signInputAuth) async {
    final account = this.account;
    final nftItem = _itemState.value;
    if (account == null || nftItem == null) return;

    UnsignedMessage? unsignedMessage;
    try {
      _loadingState.accept(true);

      if (signInputAuth.isLedger) {
        final isAvailable = await checkBluetoothAvailability();
        if (!isAvailable) return;
      }

      final resultMessage = LocaleKeys.nftTransferSuccessMessage.tr();
      final internalMessage = await _prepareTransfer(
        data: wmParams.value,
        nftItem: nftItem,
      );

      unsignedMessage = await model.prepareMessage(
        address: account.address,
        publicKey: wmParams.value.publicKey,
        destination: internalMessage.destination,
        amount: internalMessage.amount,
        payload: internalMessage.body,
      );

      final transactionCompleter = await model.sendMessage(
        address: wmParams.value.owner,
        publicKey: wmParams.value.publicKey,
        message: unsignedMessage,
        signInputAuth: signInputAuth,
        destination: internalMessage.destination,
        amount: internalMessage.amount,
      );

      _sendState.accept(const NftSendState.sending(canClose: true));

      await transactionCompleter;

      model.showMessage(Message.successful(message: resultMessage));

      if (!isMounted) return;

      contextSafe?.compassPointNamed(const WalletRouteData());
    } on OperationCanceledException catch (_) {
    } on Exception catch (e, s) {
      if (e is AnyhowException && e.isCancelled) return;
      _logger.severe('Failed to send transaction', e, s);
      model.showMessage(Message.error(message: e.toString()));
    } finally {
      unsignedMessage?.dispose();
      _loadingState.accept(false);
    }
  }

  Future<void> _init() async {
    final account = this.account;
    if (account == null) return;

    UnsignedMessage? unsignedMessage;
    try {
      _loadingState.accept(true);

      final (nftItem, nftCollection) = await FutureExt.wait2(
        model.getNftItem(
          address: wmParams.value.address,
          owner: wmParams.value.owner,
        ),
        model.getCollection(wmParams.value.collection),
      );
      if (nftItem == null || nftCollection == null) return;

      _collectionState.accept(nftCollection);
      _itemState.accept(nftItem);

      final walletState = await model.getWalletState(account.address);
      if (walletState.hasError) {
        _sendState.accept(NftSendState.error(error: walletState.error!));
        return;
      }

      final internalMessage = await _prepareTransfer(
        data: wmParams.value,
        nftItem: nftItem,
      );

      _attachedAmountState.accept(internalMessage.amount);

      unsignedMessage = await model.prepareMessage(
        address: account.address,
        publicKey: wmParams.value.publicKey,
        destination: internalMessage.destination,
        amount: internalMessage.amount,
        payload: internalMessage.body,
      );

      final (fees, txErrors) = await FutureExt.wait2(
        model.estimateFees(
          address: account.address,
          message: unsignedMessage,
        ),
        model.simulateTransactionTree(
          address: account.address,
          message: unsignedMessage,
        ),
      );

      _feesState.accept(fees);
      _txErrorsState.accept(txErrors);

      final wallet = walletState.wallet!;
      final balance = wallet.contractState.balance;
      final isPossibleToSendMessage = balance > (fees + internalMessage.amount);

      if (!isPossibleToSendMessage) {
        _errorState.accept(LocaleKeys.insufficientFunds.tr());
      }
    } on ContractNotExistsException catch (e, s) {
      _logger.severe('Failed to prepare transaction', e, s);
      _errorState.accept(LocaleKeys.insufficientFunds.tr());
    } on Exception catch (e, s) {
      _logger.severe('Failed to prepare transaction', e, s);
      _errorState.accept(e.toString());
    } finally {
      unsignedMessage?.dispose();
      _loadingState.accept(false);
    }
  }

  Future<InternalMessage> _prepareTransfer({
    required NftSendRouteData data,
    required NftItem nftItem,
  }) {
    if (data.amount != null) {
      return model.prepareNftTokenTransfer(
        id: nftItem.nft.id,
        count: data.amount!,
        collection: data.collection,
        owner: data.owner,
        recipient: data.destination,
      );
    }

    return model.prepareNftTransfer(
      address: data.address,
      owner: data.owner,
      recipient: data.destination,
    );
  }
}
