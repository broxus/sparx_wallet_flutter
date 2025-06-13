import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

NftSendWidgetModel defaultNftSendWidgetModelFactory(
  BuildContext context,
) =>
    NftSendWidgetModel(
      NftSendModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class NftSendWidgetModel
    extends CustomWidgetModel<NftSendWidget, NftSendModel> {
  NftSendWidgetModel(super.model);

  static final _logger = Logger('NftSendWidgetModel');

  late final _isLoading = createNotifier(false);
  late final _collection = createNotifier<NftCollection>();
  late final _item = createNotifier<NftItem>();
  late final _attachedAmount = createNotifier<BigInt>();
  late final _fees = createNotifier<BigInt>();
  late final _txErrors = createNotifier<List<TxTreeSimulationErrorItem>>();
  late final _error = createNotifier<String>();
  late final _state = createNotifier(const NftSendState.ready());

  late final KeyAccount? account = model.getAccount(widget.data.owner);
  late final routeData = createWidgetProperty((w) => w.data);

  Currency get currency => model.currency;

  ListenableState<bool> get isLoading => _isLoading;

  ListenableState<BigInt> get attachedAmount => _attachedAmount;

  ListenableState<BigInt> get fees => _fees;

  ListenableState<List<TxTreeSimulationErrorItem>> get txErrors => _txErrors;

  ListenableState<String> get error => _error;

  ListenableState<NftSendState> get state => _state;

  ListenableState<NftCollection> get collection => _collection;

  ListenableState<NftItem> get item => _item;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<void> onPasswordEntered(String password) async {
    final routeData = this.routeData.value;
    final account = this.account;
    final nftItem = _item.value;
    if (routeData == null || account == null || nftItem == null) return;

    UnsignedMessage? unsignedMessage;
    try {
      _isLoading.accept(true);

      final resultMessage = LocaleKeys.nftTransferSuccessMessage.tr();
      final internalMessage = await _prepareTransfer(
        data: routeData,
        nftItem: nftItem,
      );

      unsignedMessage = await model.prepareMessage(
        address: account.address,
        publicKey: routeData.publicKey,
        destination: internalMessage.destination,
        amount: internalMessage.amount,
        payload: internalMessage.body,
      );

      final transactionCompleter = await model.sendMessage(
        address: routeData.owner,
        publicKey: routeData.publicKey,
        message: unsignedMessage,
        password: password,
        destination: internalMessage.destination,
        amount: internalMessage.amount,
      );

      _state.accept(const NftSendState.sending(canClose: true));

      await transactionCompleter;

      model.showMessage(Message.successful(message: resultMessage));

      if (!isMounted) return;

      contextSafe?.compassPointNamed(const WalletRouteData());
    } on OperationCanceledException catch (_) {
    } on Exception catch (e, s) {
      _logger.severe('Failed to send transaction', e, s);
      model.showMessage(Message.error(message: e.toString()));
    } finally {
      unsignedMessage?.dispose();
      _isLoading.accept(false);
    }
  }

  Future<void> _init() async {
    final routeData = this.routeData.value;
    final account = this.account;
    if (routeData == null || account == null) return;

    UnsignedMessage? unsignedMessage;
    try {
      _isLoading.accept(true);

      final (nftItem, nftCollection) = await FutureExt.wait2(
        model.getNftItem(address: routeData.address, owner: routeData.owner),
        model.getCollection(routeData.collection),
      );
      if (nftItem == null || nftCollection == null) return;

      _collection.accept(nftCollection);
      _item.accept(nftItem);

      final walletState = await model.getWalletState(account.address);
      if (walletState.hasError) {
        _state.accept(NftSendState.error(error: walletState.error!));
        return;
      }

      final internalMessage = await _prepareTransfer(
        data: routeData,
        nftItem: nftItem,
      );

      _attachedAmount.accept(internalMessage.amount);

      unsignedMessage = await model.prepareMessage(
        address: account.address,
        publicKey: routeData.publicKey,
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
