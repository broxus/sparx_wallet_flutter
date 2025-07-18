import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TransferData {
  TransferData({
    required this.message,
    required this.recipient,
    required this.amount,
    this.attachedAmount,
    this.rootTokenContract,
  });

  final TransactionPayloadMessage message;
  final Address recipient;
  final Money amount;
  final BigInt? attachedAmount;
  final Address? rootTokenContract;
}

TCSendMessageWidgetModel defaultTCSendMessageWidgetModelFactory(
  BuildContext context,
) =>
    TCSendMessageWidgetModel(
      TCSendMessageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class TCSendMessageWidgetModel
    extends CustomWidgetModel<TCSendMessageWidget, TCSendMessageModel> {
  TCSendMessageWidgetModel(super.model);

  late final account = model.getAccount(widget.connection.walletAddress);

  late final _data = createNotifier<List<TransferData>>();
  late final _fee = createNotifier<BigInt>();
  late final _feeError = createNotifier<String>();
  late final _txErrors = createNotifier<List<TxTreeSimulationErrorItem>>();
  late final _publicKey = createNotifier(account?.publicKey);
  late final _custodians = createNotifier<List<PublicKey>>();
  late final _balance = createNotifierFromStream(
    model.getBalanceStream(widget.connection.walletAddress),
  );
  late final _isLoading = createNotifier(true);
  late final _isConfirmed = createNotifier(false);
  int? numberUnconfirmedTransactions;

  ListenableState<List<TransferData>> get data => _data;

  ListenableState<BigInt> get fee => _fee;

  ListenableState<String> get feeError => _feeError;

  ListenableState<List<TxTreeSimulationErrorItem>> get txErrors => _txErrors;

  ListenableState<PublicKey> get publicKey => _publicKey;

  ListenableState<List<PublicKey>> get custodians => _custodians;

  ListenableState<Money?> get balance => _balance;

  ListenableState<bool> get isLoading => _isLoading;

  ListenableState<bool> get isConfirmed => _isConfirmed;

  Currency get nativeCurrency =>
      Currencies()[model.transport.nativeTokenTicker]!;

  String get symbol => nativeCurrency.symbol;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Address get sender => widget.connection.walletAddress;

  Money get totalAmount => Money.fromBigIntWithCurrency(
        (_data.value ?? []).fold(
          BigInt.zero,
          (prev, e) => prev + (e.attachedAmount ?? e.amount.amount.minorUnits),
        ),
        nativeCurrency,
      );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  String? getSeedName(PublicKey custodian) => model.getSeedName(custodian);

  void onChangedCustodian(PublicKey custodian) => _publicKey.accept(custodian);

  Future<void> onSubmit(String password) async {
    if (account == null) return;

    try {
      _isLoading.accept(true);
      final message = await model.send(
        address: sender,
        publicKey: account!.publicKey,
        messages: widget.payload.messages,
        password: password,
      );

      if (contextSafe != null) {
        model.showMessage(
          Message.successful(
            message: LocaleKeys.transactionSentSuccessfully.tr(),
          ),
        );

        Navigator.of(contextSafe!).pop(message);
      }
    } catch (e) {
      contextSafe?.let(
        (context) => model.showMessage(
          Message.error(
            message: e.toString(),
          ),
        ),
      );
    } finally {
      _isLoading.accept(false);
    }
  }

  // ignore: avoid_positional_boolean_parameters
  void onConfirmed(bool value) => _isConfirmed.accept(value);

  Future<void> _init() async {
    try {
      _isLoading.accept(true);

      await _initWalletTon();

      final data = await Future.wait(
        widget.payload.messages.map(_initTransferData),
      );
      _data.accept(data);

      await Future.wait([
        _getCustodians(),
        _prepareTransfer(),
      ]);
    } finally {
      _isLoading.accept(false);
    }
  }

  Future<TransferData> _initTransferData(
    TransactionPayloadMessage message,
  ) async {
    final payload = message.payload?.let(parseKnownPayload);
    final transfer = switch (payload) {
      KnownPayloadJettonOutgoingTransfer(:final data) => data,
      _ => null,
    };

    if (transfer == null) {
      // Native transfer
      return TransferData(
        message: message,
        recipient: message.address,
        amount: Money.fromBigIntWithCurrency(
          BigInt.parse(message.amount),
          nativeCurrency,
        ),
      );
    }

    // Jetton transfer
    final (rootTokenContract, _) = await model.getJettonRootDetails(
      message.address.copyWith(
        address: message.address.toRaw(),
      ),
    );
    final symbol = await model.getSymbol(rootTokenContract);

    final currency = Currency.create(
      symbol.name,
      symbol.decimals,
      symbol: symbol.name,
      pattern: moneyPattern(symbol.decimals),
    );

    Currencies().register(currency);

    return TransferData(
      message: message,
      recipient: transfer.to,
      amount: Money.fromBigIntWithCurrency(transfer.tokens, currency),
      attachedAmount: BigInt.parse(message.amount),
      rootTokenContract: rootTokenContract,
    );
  }

  Future<void> _getCustodians() async {
    final custodians = await model.getLocalCustodiansAsync(sender);
    _custodians.accept(custodians);
  }

  Future<void> _prepareTransfer() async {
    UnsignedMessage? message;

    try {
      message = await model.prepareTransfer(
        address: sender,
        publicKey: account!.publicKey,
        messages: widget.payload.messages,
      );

      await _estimateFees(message);
      await _simulateTransactionTree(message);

      final data = _data.value;
      if (data != null) {
        final balance =
            _balance.value ?? await model.getBalanceStream(sender).first;
        final fee = _fee.value ?? BigInt.zero;
        final amount = totalAmount.amount.minorUnits;

        if (balance.amount.minorUnits < (fee + amount)) {
          _feeError.accept(LocaleKeys.insufficientFunds.tr());
        }
      }
    } finally {
      message?.dispose();
    }
  }

  Future<void> _estimateFees(UnsignedMessage message) async {
    try {
      final fee = await model.estimateFees(
        address: sender,
        message: message,
      );

      _fee.accept(fee);
    } catch (e) {
      _feeError.accept(e.toString());
    }
  }

  Future<void> _simulateTransactionTree(UnsignedMessage message) async {
    try {
      final errors = await model.simulateTransactionTree(
        address: sender,
        message: message,
      );

      _txErrors.accept(errors);
    } catch (e) {
      contextSafe?.let(
        (context) => model.showMessage(
          Message.error(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _initWalletTon() async {
    final walletTonState = await model.getTonWalletState(sender);
    numberUnconfirmedTransactions =
        (walletTonState.wallet?.unconfirmedTransactions.length ?? 0) +
            (walletTonState.wallet?.pendingTransactions.length ?? 0);
  }
}
