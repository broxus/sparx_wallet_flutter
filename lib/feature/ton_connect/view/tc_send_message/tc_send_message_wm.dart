import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/app/service/ton_connect/ton_connect.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TransferData {
  TransferData({
    required this.messages,
    required this.currency,
    required this.numberUnconfirmedTransactions,
  });

  // final Money amount;
  final List<TransactionPayloadMessage> messages;
  final Currency currency;
  final int? numberUnconfirmedTransactions;

  Address? get recipient =>
      messages.singleOrNull?.address ??
      (messages.every((e) => e.address == messages.first.address)
          ? messages.first.address
          : null);

  Money get amount => Money.fromBigIntWithCurrency(
        messages.fold<BigInt>(
          BigInt.zero,
          (prev, e) => prev + BigInt.parse(e.amount),
        ),
        currency,
      );
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

  late final _data = createNotifier<TransferData>();
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
  late final _manifest = createNotifier<DappManifest>();
  int? numberUnconfirmedTransactions;

  ListenableState<TransferData> get data => _data;

  ListenableState<BigInt> get fee => _fee;

  ListenableState<String> get feeError => _feeError;

  ListenableState<List<TxTreeSimulationErrorItem>> get txErrors => _txErrors;

  ListenableState<PublicKey> get publicKey => _publicKey;

  ListenableState<List<PublicKey>> get custodians => _custodians;

  ListenableState<Money?> get balance => _balance;

  ListenableState<bool> get isLoading => _isLoading;

  ListenableState<bool> get isConfirmed => _isConfirmed;

  ListenableState<DappManifest> get manifest => _manifest;

  Currency? get nativeCurrency =>
      Currencies()[model.transport.nativeTokenTicker];

  String? get symbol => nativeCurrency?.symbol;

  ThemeStyleV2 get theme => context.themeStyleV2;

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
      final message = await model.send(
        address: widget.connection.walletAddress,
        publicKey: account!.publicKey,
        messages: widget.payload.messages,
        password: password,
      );

      if (contextSafe != null) {
        model.showMessage(
          Message.successful(
            context: contextSafe,
            message: LocaleKeys.transactionSentSuccessfully.tr(),
          ),
        );

        Navigator.of(contextSafe!).pop(message);
      }
    } catch (e) {
      contextSafe?.let(
        (context) => model.showMessage(
          Message.error(
            context: context,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  // ignore: avoid_positional_boolean_parameters
  void onConfirmed(bool value) => _isConfirmed.accept(value);

  Future<void> _init() async {
    await _initWalletTon();

    if (nativeCurrency != null) {
      _data.accept(
        TransferData(
          messages: widget.payload.messages,
          currency: nativeCurrency!,
          numberUnconfirmedTransactions: numberUnconfirmedTransactions,
        ),
      );
    }

    await Future.wait([
      _getCustodians(),
      _prepareTransfer(),
      _getManifest(),
    ]);
  }

  Future<void> _getCustodians() async {
    final custodians =
        await model.getLocalCustodiansAsync(widget.connection.walletAddress);
    _custodians.accept(custodians);
  }

  Future<void> _prepareTransfer() async {
    UnsignedMessage? message;

    try {
      _isLoading.accept(true);
      message = await model.prepareTransfer(
        address: widget.connection.walletAddress,
        publicKey: account!.publicKey,
        messages: widget.payload.messages,
      );

      await _estimateFees(message);
      await _simulateTransactionTree(message);

      final data = _data.value;
      if (data != null) {
        final balance = _balance.value ??
            await model.getBalanceStream(widget.connection.walletAddress).first;
        final fee = _fee.value ?? BigInt.zero;
        final amount = data.amount.amount.minorUnits;

        if (balance.amount.minorUnits < (fee + amount)) {
          _feeError.accept(LocaleKeys.insufficientFunds.tr());
        }
      }
    } finally {
      message?.dispose();
      _isLoading.accept(false);
    }
  }

  Future<void> _estimateFees(UnsignedMessage message) async {
    try {
      final fee = await model.estimateFees(
        address: widget.connection.walletAddress,
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
        address: widget.connection.walletAddress,
        message: message,
      );

      _txErrors.accept(errors);
    } catch (e) {
      contextSafe?.let(
        (context) => model.showMessage(
          Message.error(
            context: context,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _initWalletTon() async {
    final walletTonState =
        await model.getTonWalletState(widget.connection.walletAddress);
    numberUnconfirmedTransactions =
        (walletTonState.wallet?.unconfirmedTransactions.length ?? 0) +
            (walletTonState.wallet?.pendingTransactions.length ?? 0);

    if (nativeCurrency != null) {
      _data.accept(
        TransferData(
          messages: widget.payload.messages,
          currency: nativeCurrency!,
          numberUnconfirmedTransactions: numberUnconfirmedTransactions,
        ),
      );
    }
  }

  Future<void> _getManifest() async {
    final manifest = await model.getManifest(widget.connection.manifestUrl);
    _manifest.accept(manifest);
  }
}
