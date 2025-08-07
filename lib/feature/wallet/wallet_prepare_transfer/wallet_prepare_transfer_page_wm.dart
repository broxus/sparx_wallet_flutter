// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/app/service/currency_convert_service.dart';
import 'package:app/bootstrap/sentry.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/token_contract/token_contract_asset.dart';
import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:app/feature/wallet/token_wallet_send/route.dart';
import 'package:app/feature/wallet/ton_wallet_send/route.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_balance_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_transfer_asset.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_transfer_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page_model.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/amount_input/amount_input_asset.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

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
    extends CustomWidgetModelParametrized<WalletPrepareTransferPage,
        WalletPrepareTransferPageModel, WalletPrepareTransferPageWmParams> {
  WalletPrepareTransferPageWidgetModel(
    super.model,
  );

  late final screenState = createEntityNotifier<WalletPrepareTransferData?>()
    ..loading(
      WalletPrepareTransferData(),
    );

  late final commentState = createNotifier(false);
  late final _isInitialDataLoaded = createNotifier(false);

  final formKey = GlobalKey<FormState>();

  late final receiverController =
      createTextEditingController(wmParams.value.destination?.address);
  late final receiverFocus = createFocusNode();

  late final amountController = createTextEditingController();
  late final amountFocus = createFocusNode();

  late final commentController = createTextEditingController();
  late final commentFocus = createFocusNode();

  final addressFilterFormatter = FilteringTextInputFormatter.deny(
    RegExp(r'\s'),
  );

  final _assets = <(Address, String), WalletPrepareTransferAsset>{};
  late final _assetsList = createValueNotifier(_assets.values.toList());

  late final _sentry = SentryWorker.instance;

  WalletPrepareTransferData? get _data => screenState.value.data;

  WalletPrepareTransferAsset? get _selectedAsset => _data?.selectedAsset;

  PublicKey? get _selectedCustodian => _data?.selectedCustodian;

  ValueListenable<List<WalletPrepareTransferAsset>> get assets => _assetsList;

  ListenableState<bool> get isInitialDataLoaded => _isInitialDataLoaded;

  late final ValueListenable<Address> addressState = createWmParamsNotifier(
    (it) => it.address,
  );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
    _initListeners();
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

    final addr = Address(
      address: receiverController.text.trim(),
    );

    if (!validateAddress(addr)) {
      model.showError(LocaleKeys.addressIsWrong.tr());

      return;
    }

    final amnt = Fixed.parse(
      amountController.text.trim().replaceAll(',', '.'),
      scale: _selectedAsset?.balance.decimalDigits,
    );

    _goNext(addr, amnt);
  }

  Future<void> setMaxBalance() async {
    final asset = _selectedAsset;
    var available = asset?.balance;

    if (asset == null || available == null) {
      return;
    }

    if (asset.isNative) {
      // subtract approximate comission
      final gas = await model.getFeeFactor();
      final valueComission = gas == null ? 0.01 : gas / pow(2, 16) * 0.01;
      final comission = Money.fromFixedWithCurrency(
        Fixed.fromNum(valueComission),
        available.currency,
      );
      final amountMinusComission = available - comission;
      if (amountMinusComission.amount < Fixed.zero) {
        model.showError(
          LocaleKeys.sendingNotEnoughBalanceToSend.tr(
            args: [
              comission.formatImproved(),
              comission.currency.isoCode,
            ],
          ),
        );
        return;
      } else {
        available = amountMinusComission;
      }
    }

    amountController.text = available.formatImproved();
  }

  void onPressedReceiverClear() => receiverController.clear();

  void onPressedPasteAddress(String text) {
    if (text.isEmpty) {
      model.showError(LocaleKeys.addressIsWrong.tr());
      return;
    }

    if (validateAddress(Address(address: text))) {
      receiverController.text = text;
      receiverFocus.unfocus();
    } else {
      model.showError(LocaleKeys.addressIsWrong.tr());
    }
  }

  Future<void> onPressedScan() async {
    final result = await showQrScanner(context, types: [QrScanType.address]);

    if (!context.mounted) return;

    if (result case QrScanResultAddress(:final value)) {
      receiverController.text = value.address;
      receiverFocus.unfocus();
    }
  }

  void onSubmittedReceiverAddress(_) => amountFocus.requestFocus();

  void onSubmittedAmountWord(_) => commentFocus.requestFocus();

  String? validateAddressField(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.addressIsEmpty.tr();
    }

    if (_selectedAsset?.isNative != true &&
        addressState.value.address == value) {
      return LocaleKeys.invalidReceiverAddress.tr();
    }
    return null;
  }

  void onPressedCleanComment() {
    commentController.clear();
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

    _updateState(
      account: acc,
    );

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

    final localCustodians =
        await model.getLocalCustodiansAsync(addressState.value);

    _updateState(
      account: acc,
      selectedCustodian: localCustodians?.firstOrNull ?? acc.publicKey,
      localCustodians: localCustodians,
    );

    _isInitialDataLoaded.accept(true);
  }

  void _initListeners() {
    WalletPrepareTransferAsset? prevSelectedAsset;

    screenState.addListener(() {
      if (prevSelectedAsset?.rootTokenContract !=
          _selectedAsset?.rootTokenContract) {
        amountController.clear();
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
        StateError(
          "Failed navigate to wallet send, publicKey doesn't exists",
        ),
      );
      return;
    }

    final comment = commentController.text.trim();

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
    final currency = asset.currency ??
        await model.getCurrencyForContract(
          asset.rootTokenContract,
        );

    final balance =
        await model.getBalance(asset: asset, address: addressState.value) ??
            _zeroBalance(asset.tokenSymbol);

    final updatedAsset = asset.copyWith(
      currency: currency,
      balance: balance,
    );

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
      balance: _zeroBalance(transport.nativeTokenTicker),
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
      balance: _zeroBalance(contract.symbol),
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
        balance: Money.fromBigIntWithCurrency(
          balance,
          Currencies()[symbol]!,
        ),
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
        balance: _zeroBalance(e.symbol),
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
    _assetsList.value = _assets.values.toList();
  }

  Money _zeroBalance(String symbol) {
    return Money.fromBigIntWithCurrency(
      BigInt.zero,
      Currencies()[symbol] ??
          Currency.create(
            symbol,
            0,
            symbol: symbol,
            pattern: moneyPattern(0),
          ),
    );
  }
}
