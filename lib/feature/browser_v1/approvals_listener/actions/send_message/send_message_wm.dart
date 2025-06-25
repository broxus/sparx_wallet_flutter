import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/send_message/send_message_model.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SendMessageWmParams {
  const SendMessageWmParams({
    required this.origin,
    required this.sender,
    required this.recipient,
    required this.amount,
    required this.bounce,
    required this.payload,
    required this.knownPayload,
    this.ignoredComputePhaseCodes,
    this.ignoredActionPhaseCodes,
  });

  final Uri origin;
  final Address sender;
  final Address recipient;
  final BigInt amount;
  final bool bounce;
  final FunctionCall? payload;
  final KnownPayload? knownPayload;
  final List<IgnoreTransactionTreeSimulationError>? ignoredComputePhaseCodes;
  final List<IgnoreTransactionTreeSimulationError>? ignoredActionPhaseCodes;
}

class TransferData {
  TransferData({
    required this.amount,
    required this.numberUnconfirmedTransactions,
    this.attachedAmount,
    this.rootTokenContract,
  });

  final Money amount;
  final BigInt? attachedAmount;
  final Address? rootTokenContract;
  final int? numberUnconfirmedTransactions;
}

@injectable
class SendMessageWidgetModel
    extends CustomWidgetModel<ElementaryWidget, SendMessageModel> {
  SendMessageWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final SendMessageWmParams _wmParams;

  late final account = model.getAccount(_wmParams.sender);

  Uri get origin => _wmParams.origin;
  Address get recipient => _wmParams.recipient;
  FunctionCall? get payload => _wmParams.payload;

  late final _data = createNotifier<TransferData>();
  late final _fee = createNotifier<BigInt>();
  late final _feeError = createNotifier<String>();
  late final _txErrors = createNotifier<List<TxTreeSimulationErrorItem>>();
  late final _publicKey = createNotifier(account?.publicKey);
  late final _custodians = createNotifier<List<PublicKey>>();
  late final _balance = createNotifierFromStream(
    model.getBalanceStream(_wmParams.sender),
  );
  late final _isLoading = createNotifier(true);
  late final _isConfirmed = createNotifier(false);
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

  void onSubmit(String password) =>
      Navigator.of(context).pop((publicKey.value, password));

  // ignore: avoid_positional_boolean_parameters
  void onConfirmed(bool value) => _isConfirmed.accept(value);

  Future<void> _init() async {
    final tokens = switch (_wmParams.knownPayload) {
      KnownPayloadTokenOutgoingTransfer(:final data) => data.tokens,
      KnownPayloadTokenSwapBack(:final data) => data.tokens,
      _ => null,
    };

    if (tokens == null) {
      await _initWalletTon(tokens);

      if (nativeCurrency != null) {
        _data.accept(
          TransferData(
            amount: Money.fromBigIntWithCurrency(
              _wmParams.amount,
              nativeCurrency!,
            ),
            numberUnconfirmedTransactions: numberUnconfirmedTransactions,
          ),
        );
      }
    } else {
      await _getTokenTransferData(tokens);
    }

    await Future.wait([
      _getCustodians(),
      _prepareTransfer(),
    ]);
  }

  Future<void> _getTokenTransferData(BigInt tokens) async {
    final (rootTokenContract, details) =
        await model.getTokenRootDetailsFromTokenWallet(_wmParams.recipient);
    final walletTonState = await model.getTonWalletState(_wmParams.sender);
    numberUnconfirmedTransactions =
        (walletTonState.wallet?.unconfirmedTransactions.length ?? 0) +
            (walletTonState.wallet?.pendingTransactions.length ?? 0);

    final currency = Currency.create(
      details.symbol,
      details.decimals,
      symbol: details.symbol,
      pattern: moneyPattern(details.decimals),
    );

    Currencies().register(currency);

    _data.accept(
      TransferData(
        amount: Money.fromBigIntWithCurrency(tokens, currency),
        attachedAmount: _wmParams.amount,
        rootTokenContract: rootTokenContract,
        numberUnconfirmedTransactions: numberUnconfirmedTransactions,
      ),
    );
  }

  Future<void> _getCustodians() async {
    final custodians = await model.getLocalCustodiansAsync(_wmParams.sender);
    _custodians.accept(custodians);
  }

  Future<void> _prepareTransfer() async {
    UnsignedMessage? message;

    try {
      _isLoading.accept(true);
      message = await model.prepareTransfer(
        address: _wmParams.sender,
        destination: _wmParams.recipient,
        publicKey: account?.publicKey,
        amount: _wmParams.amount,
        payload: _wmParams.payload,
        bounce: _wmParams.bounce,
      );

      await _estimateFees(message);
      await _simulateTransactionTree(message);

      final data = _data.value;
      if (data != null) {
        final balance = _balance.value ??
            await model.getBalanceStream(_wmParams.sender).first;
        final fee = _fee.value ?? BigInt.zero;
        final amount = data.attachedAmount ?? data.amount.amount.minorUnits;

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
        address: _wmParams.sender,
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
        address: _wmParams.sender,
        message: message,
        ignoredComputePhaseCodes: _wmParams.ignoredComputePhaseCodes,
        ignoredActionPhaseCodes: _wmParams.ignoredActionPhaseCodes,
      );

      _txErrors.accept(errors);
    } catch (e) {
      contextSafe?.let(
        (context) => model.showError(context, e.toString()),
      );
    }
  }

  Future<void> _initWalletTon(BigInt? tokens) async {
    final walletTonState = await model.getTonWalletState(_wmParams.sender);
    numberUnconfirmedTransactions =
        (walletTonState.wallet?.unconfirmedTransactions.length ?? 0) +
            (walletTonState.wallet?.pendingTransactions.length ?? 0);
    if (tokens == null && nativeCurrency != null) {
      _data.accept(
        TransferData(
          amount: Money.fromBigIntWithCurrency(
            _wmParams.amount,
            nativeCurrency!,
          ),
          numberUnconfirmedTransactions: numberUnconfirmedTransactions,
        ),
      );
    }
  }
}
