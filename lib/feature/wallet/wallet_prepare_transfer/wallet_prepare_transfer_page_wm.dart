// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/app/service/currency_convert_service.dart';
import 'package:app/core/sentry.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/token_contract/token_contract_asset.dart';
import 'package:app/feature/wallet/token_wallet_send/route.dart';
import 'package:app/feature/wallet/ton_wallet_send/route.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_balance_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_transfer_asset.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_transfer_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/delegates/amount_ui_delegate.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/delegates/comment_ui_delegate.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/delegates/recipient_ui_delegate.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page_model.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/amount_input/amount_input_asset.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _zeroAddress = Address(
  address: '0:0000000000000000000000000000000000000000000000000000000000000000',
);

class WalletPrepareTransferPageWmParams {
  const WalletPrepareTransferPageWmParams({
    required this.address,
    this.destination,
    this.rootTokenContract,
    this.tokenSymbol,
  });

  final Address address;
  final Address? destination;
  final Address? rootTokenContract;
  final String? tokenSymbol;
}

/// [WidgetModel] для [WalletPrepareTransferPage]
@injectable
class WalletPrepareTransferPageWidgetModel
    extends
        CustomWidgetModelParametrized<
          WalletPrepareTransferPage,
          WalletPrepareTransferPageModel,
          WalletPrepareTransferPageWmParams
        > {
  WalletPrepareTransferPageWidgetModel(super.model);

  late final screenState = createEntityNotifier<WalletPrepareTransferData?>()
    ..loading(WalletPrepareTransferData());

  late final _isInitialDataLoadedState = createNotifier(false);

  final formKey = GlobalKey<FormState>();

  final _assets = <(Address, String), WalletPrepareTransferAsset>{};
  late final _assetsState = createValueNotifier(_assets.values.toList());

  late final _sentry = SentryWorker.instance;

  late final _amountUiDelegate = AmountUiDelegate();

  late final _commentUiDelegate = CommentUiDelegate();

  late final _recipientUiDelegate = RecipientUiDelegate(context, model);

  AmountUi get amountUi => _amountUiDelegate;

  CommentUi get commentUi => _commentUiDelegate;

  RecipientUi get recipientUi => _recipientUiDelegate;

  WalletPrepareTransferData? get _data => screenState.value.data;

  WalletPrepareTransferAsset? get _selectedAsset => _data?.selectedAsset;

  PublicKey? get _selectedCustodian => _data?.selectedCustodian;

  ValueListenable<List<WalletPrepareTransferAsset>> get assetsState =>
      _assetsState;

  ListenableState<bool> get isInitialDataLoadedState =>
      _isInitialDataLoadedState;

  late final ValueListenable<Address> addressState = createWmParamsNotifier(
    (it) => it.address,
  );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _recipientUiDelegate.init(address: wmParams.value.destination?.address);
    _init();
    _initListeners();
  }

  @override
  void dispose() {
    _amountUiDelegate.dispose();
    _commentUiDelegate.dispose();
    _recipientUiDelegate.dispose();
    super.dispose();
  }

  String? getSeedName(PublicKey custodian) => model.getSeedName(custodian);

  void onChangeAsset(AmountInputAsset newAsset) {
    final asset = _assets[newAsset.key];
    if (_selectedAsset?.rootTokenContract == newAsset.rootTokenContract &&
            _selectedAsset?.tokenSymbol == newAsset.tokenSymbol ||
        asset == null) {
      return;
    }

    _updateState(selectedAsset: asset);
    unawaited(_updateAsset(asset));

    model.startListeningBalance(
      contract: _assets[asset.key],
      address: addressState.value,
    );
  }

  void onChangedCustodian(PublicKey custodian) {
    if (_data?.selectedCustodian == custodian) {
      return;
    }

    _updateState(selectedCustodian: custodian);
  }

  Future<void> onPressedNext() async {
    final isValidate = formKey.currentState?.validate() ?? false;

    if (!isValidate) {
      return;
    }

    final address = _recipientUiDelegate.address;

    if (!address.isValid) {
      model.showError(LocaleKeys.addressIsWrong.tr());
      return;
    }

    final result = model.validateCrosschainTransfer(address);
    if (!result.isValid) return;

    final amnt = Fixed.parse(
      _amountUiDelegate.amountText.trim().replaceAll(',', '.'),
      decimalDigits: _selectedAsset?.balance.decimalDigits,
    );

    _goNext(address, amnt);
  }

  void onPressedPlus() {
    _commentUiDelegate.commentState.accept(true);
    _commentUiDelegate.requestFocus();
  }

  Future<void> setMaxBalance() async {
    final asset = _selectedAsset;
    var available = asset?.balance;
    Money? comission;

    if (asset == null || available == null) {
      return;
    }

    if (asset.isNative) {
      comission = await _computeNativeComissionEstimate(
        available: available,
        sender: addressState.value,
      );
    } else {
      comission = await _computeTokenComissionEstimate(
        rootTokenContract: asset.rootTokenContract,
      );
    }

    if (comission != null) {
      final amountMinusComission = available - comission;
      if (amountMinusComission.amount < Fixed.zero) {
        model.showError(
          LocaleKeys.sendingNotEnoughBalanceToSend.tr(
            args: [comission.formatImproved(), comission.currency.isoCode],
          ),
        );
        return;
      } else {
        available = amountMinusComission;
      }
    }

    _amountUiDelegate.amountController.text = available.formatImproved();
  }

  void onSubmittedReceiverAddress(_) => _amountUiDelegate.resetFocus();

  void onSubmittedAmountWord(_) => _commentUiDelegate.requestFocus();

  String? validateAddressField(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.addressIsEmpty.tr();
    }

    final address = Address(address: value.trim());
    if (!address.isValid) {
      return LocaleKeys.invalidAddressFormat.tr();
    }

    if (_selectedAsset?.isNative != true && addressState.value == address) {
      return LocaleKeys.invalidReceiverAddress.tr();
    }

    final result = model.validateCrosschainTransfer(address);
    if (result.errorMessage case final String message) {
      return message;
    }

    return null;
  }

  Future<void> _init() async {
    final acc = model.findAccountByAddress(addressState.value);
    if (acc == null) {
      screenState.content(null);
      _sentry.captureException(
        StateError(
          'Transfer prepreate initialization failed, address not found',
        ),
      );
      return;
    }

    _updateState(account: acc);

    // If default contract not specified, then native is default and load
    // all existed assets
    final root = wmParams.value.rootTokenContract;

    _createNativeContract();
    model.findExistedContracts(
      onUpdate: _onUpdateContractsForAccount,
      address: addressState.value,
    );

    if (root != null &&
        wmParams.value.tokenSymbol != _selectedAsset?.tokenSymbol) {
      unawaited(_findSpecifiedContract(root));
    }

    final localCustodians = await model.getLocalCustodiansAsync(
      addressState.value,
    );

    _updateState(
      account: acc,
      selectedCustodian: localCustodians?.firstOrNull ?? acc.publicKey,
      localCustodians: localCustodians,
    );

    _isInitialDataLoadedState.accept(true);
  }

  void _initListeners() {
    WalletPrepareTransferAsset? prevSelectedAsset;

    screenState.addListener(() {
      if (prevSelectedAsset?.rootTokenContract !=
          _selectedAsset?.rootTokenContract) {
        _amountUiDelegate.amountController.clear();
      }
      prevSelectedAsset = _selectedAsset;
    });

    model.balanceDataStream.listen(_onUpdateBalanceData);
  }

  void _goNext(Address receiveAddress, Fixed amount) {
    final selectedAsset = _selectedAsset;

    if (selectedAsset == null) {
      return;
    }

    final publicKey = _selectedCustodian;

    if (publicKey == null) {
      _sentry.captureException(
        StateError("Failed navigate to wallet send, publicKey doesn't exists"),
      );
      return;
    }

    final comment = _commentUiDelegate.text.trim();

    final CompassRouteData routeData;

    if (selectedAsset.isNative) {
      routeData = TonWalletSendRouteData(
        address: addressState.value,
        publicKey: publicKey,
        comment: comment,
        destination: receiveAddress,
        amount: amount.minorUnits,
        popOnComplete: false,
      );
    } else {
      routeData = TokenWalletSendRouteData(
        owner: addressState.value,
        rootTokenContract: selectedAsset.rootTokenContract,
        publicKey: publicKey,
        comment: comment,
        destination: receiveAddress,
        amount: amount.minorUnits,
      );
    }

    contextSafe?.compassContinue(routeData);
  }

  Future<void> _updateAsset(WalletPrepareTransferAsset asset) async {
    final currency =
        asset.currency ??
        await model.getCurrencyForContract(asset.rootTokenContract);

    final balance =
        await model.getBalance(asset: asset, address: addressState.value) ??
        _getZeroBalance(asset.tokenSymbol);

    final updatedAsset = asset.copyWith(currency: currency, balance: balance);

    _updateAssets((assets) => assets[updatedAsset.key] = updatedAsset);

    if (updatedAsset.key == _selectedAsset?.key) {
      _updateState(selectedAsset: updatedAsset);
    }
  }

  void _createNativeContract() {
    final transport = model.currentTransport;
    final root = transport.nativeTokenAddress;

    final selectedAsset = WalletPrepareTransferAsset(
      rootTokenContract: root,
      isNative: true,
      balance: _getZeroBalance(transport.nativeTokenTicker),
      tokenSymbol: transport.nativeTokenTicker,
      logoURI: transport.nativeTokenIcon,
      title: transport.nativeTokenTicker,
    );

    _updateAssets((assets) => assets[selectedAsset.key] = selectedAsset);
    _updateState(selectedAsset: selectedAsset);
    unawaited(_updateAsset(selectedAsset));

    model.startListeningBalance(
      contract: selectedAsset,
      address: addressState.value,
    );
  }

  Future<void> _findSpecifiedContract(Address root) async {
    final contract = await model.getTokenContractAsset(root);

    if (contract == null) {
      screenState.content(null);

      return;
    }

    final selectedAsset = WalletPrepareTransferAsset(
      rootTokenContract: contract.address,
      isNative: false,
      balance: _getZeroBalance(contract.symbol),
      logoURI: contract.logoURI,
      tokenSymbol: contract.symbol,
      title: contract.name,
      version: contract.version,
    );

    _updateAssets((assets) => assets[selectedAsset.key] = selectedAsset);
    _updateState(selectedAsset: selectedAsset);
    unawaited(_updateAsset(selectedAsset));

    model.startListeningBalance(
      contract: selectedAsset,
      address: addressState.value,
    );
  }

  void _updateState({
    KeyAccount? account,
    PublicKey? selectedCustodian,
    List<PublicKey>? localCustodians,
    WalletPrepareTransferAsset? selectedAsset,
  }) {
    screenState.content(
      _data?.copyWith(
        account: account,
        selectedCustodian: selectedCustodian,
        localCustodians: localCustodians,
        selectedAsset: selectedAsset,
      ),
    );
  }

  void _onUpdateBalanceData(WalletPrepareBalanceData value) {
    if (value is WalletPrepareErrorBalanceData) {
      screenState.error(value.error);
      return;
    }

    WalletPrepareTransferAsset? updated;
    Address? root;
    String? symbol;

    if (value is WalletPrepareNativeBalanceData) {
      root = value.root;
      symbol = value.symbol;
      final balance = value.balance;

      updated = _assets[(root, symbol)]?.copyWith(
        balance: Money.fromBigIntWithCurrency(balance, Currencies()[symbol]!),
      );
    } else if (value is WalletPrepareTokenBalanceData) {
      root = value.root;
      symbol = value.symbol;
      final money = value.money;

      updated = _assets[(root, symbol)]?.copyWith(balance: money);
    }

    if (updated == null || root == null || symbol == null) {
      return;
    }

    _updateAssets((assets) => assets[(root!, symbol!)] = updated!);

    if (_selectedAsset?.rootTokenContract == root &&
        _selectedAsset?.tokenSymbol == symbol) {
      _updateState(selectedAsset: updated);
    }
  }

  void _onUpdateContractsForAccount(List<TokenContractAsset> contracts) {
    final assets = contracts.map(
      (e) => WalletPrepareTransferAsset(
        rootTokenContract: e.address,
        isNative: false,
        balance: _getZeroBalance(e.symbol),
        tokenSymbol: e.symbol,
        logoURI: e.logoURI,
        title: e.name,
        version: e.version,
      ),
    );
    final entries = assets.map((asset) => MapEntry(asset.key, asset));

    _updateAssets((assets) => assets.addEntries(entries));

    for (final asset in assets) {
      _updateAsset(asset);
    }

    _updateState();
  }

  void _updateAssets(
    void Function(Map<(Address, String), WalletPrepareTransferAsset> aseets)
    updater,
  ) {
    updater(_assets);
    _assetsState.value = _assets.values.toList();
  }

  Money _getZeroBalance(String symbol) {
    return Money.fromBigIntWithCurrency(
      BigInt.zero,
      Currencies()[symbol] ??
          Currency.create(symbol, 0, symbol: symbol, pattern: moneyPattern(0)),
    );
  }

  Future<Money> _computeNativeComissionEstimate({
    required Address sender,
    required Money available,
  }) async {
    if (sender.workchain == -1) {
      final fundamentals = await model.getFundamentalAddresses();

      if (fundamentals.contains(sender)) {
        return Money.fromFixedWithCurrency(Fixed.zero, available.currency);
      }
    }

    // subtract approximate comission
    final gas = await model.getFeeFactor();
    final valueComission = gas == null ? 0.01 : gas / pow(2, 16) * 0.01;

    return Money.fromFixedWithCurrency(
      Fixed.fromNum(valueComission),
      available.currency,
    );
  }

  Future<Money?> _computeTokenComissionEstimate({
    required Address rootTokenContract,
  }) async {
    final keyAccount = _data?.account;
    final publicKey = _data?.selectedCustodian;
    final address = _recipientUiDelegate.address;

    return keyAccount != null && publicKey != null
        ? await model.estimateGaslessCommission(
            keyAccount: keyAccount,
            rootTokenContract: rootTokenContract,
            publicKey: publicKey,
            destination: address.isValid ? address : _zeroAddress,
          )
        : null;
  }
}
