import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/token_wallet_send/route.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/amount_input/amount_input_asset.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _maxFixedComission = 0.1; // 0.1 EVER

@injectable
class StakingPageWidgetModel extends CustomWidgetModelParametrized<
    StakingPageWidget, StakingPageModel, Address> {
  StakingPageWidgetModel(
    super.model,
  );

  late final inputController = createTextEditingController();

  final _logger = Logger('StakingPageWidgetModel');

  late final _isLoadingState = createValueNotifier(true);
  late final _tabState = createValueNotifier(StakingTab.stake);
  late final _infoState = createEntityNotifier<StakingInfo>()..loading();
  late final _dataState = createNotifier<StakingData>();
  late final _requestsState = createNotifierFromStream(
    model.getWithdrawRequests(accountAddress),
  );
  late final _receiveState = createNotifierFromStream(
    Rx.combineLatestList(
      [_tabState.asStream(), inputController.asStream()],
    ).switchMap(
      (_) => _getReceive().asStream().whereNotNull(),
    ),
  );
  late final _validationState = createNotifierFromStream(
    Rx.combineLatestList(
      [_tabState.asStream(), _infoState.asStream(), inputController.asStream()],
    ).map(
      (_) => _validate(),
    ),
  );

  TonWallet? _wallet;

  Address get accountAddress => wmParams.value;

  ValueListenable<bool> get isLoadingState => _isLoadingState;

  ValueListenable<StakingTab> get tabState => _tabState;

  ListenableState<List<StEverWithdrawRequest>> get requestsState =>
      _requestsState;

  ListenableState<Money> get receiveState => _receiveState;

  ListenableState<ValidationState> get validationState => _validationState;

  EntityValueListenable<StakingInfo> get infoState => _infoState;

  ListenableState<StakingData> get dataState => _dataState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  /// Native currency
  Currency get currency => model.nativeCurrency;

  Currency? get tokenCurrency => _infoState.value.data?.tokenWallet.currency;

  Fixed get _currentValue =>
      Fixed.tryParse(
        inputController.text.trim().replaceAll(',', '.'),
        scale: _currentCurrency?.decimalDigits ?? 0,
      ) ??
      Fixed.zero;

  Currency? get _currentCurrency => _tabState.value == StakingTab.stake
      ? currency
      : _infoState.value.data?.tokenWallet.currency;

  Money get _comission {
    final fees = _infoState.value.data?.fees ?? StakingFees.empty();

    return _tabState.value == StakingTab.stake
        ? Money.fromBigIntWithCurrency(
            // around 2.1 EVER
            fees.depositAttachedFee +
                _maxFixedComission.toNativeToken(
                  model.transport.defaultNativeCurrencyDecimal,
                ),
            currency,
          )
        : Money.fromBigIntWithCurrency(
            // around 3.1 EVER
            fees.withdrawAttachedFee +
                _maxFixedComission.toNativeToken(
                  model.transport.defaultNativeCurrencyDecimal,
                ),
            currency,
          );
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  void unfocus() => FocusScope.of(context).unfocus();

  Future<void> showHowItWorksSheet() async {
    final info = await _infoState.asStream().firstWhere((e) => e.data != null);

    model.saveWasStEverOpened();
    contextSafe?.let((context) {
      showStEverHowItWorksSheet(
        context: context,
        info: info.data!,
        nativeTokenTicker: model.transport.nativeTokenTicker,
        nativeTokenIcon: model.transport.nativeTokenIcon,
      );
    });
  }

  // ignore: use_setters_to_change_properties
  void onTabChanged(StakingTab value) {
    _tabState.value = value;
    inputController.clear();
    _updateData();
  }

  void onMaxAmount() {
    var max = _dataState.value?.asset?.balance;

    if (max == null) return;

    if (_tabState.value == StakingTab.stake) {
      max = max - _comission;
    }

    inputController.text = max.positiveOrZero().formatImproved();
  }

  void onSubmit() {
    switch (_tabState.value) {
      case StakingTab.stake:
        _prepareStaking();
      case StakingTab.unstake:
        _prepareUntaking();
      case StakingTab.inProgress:
        // do nothing
        break;
    }
  }

  Future<void> _init() async {
    try {
      unawaited(model.tryAddTokenWallet(accountAddress));

      final (ever, token) = await FutureExt.wait2(
        model.getWallet(wmParams.value),
        model.getTokenWallet(wmParams.value),
      );

      if (ever.hasError || token.hasError) {
        _infoState.error();
        return;
      }

      _wallet = ever.wallet;

      final (
        tokenCurrency,
        currency,
        apyValue,
        details,
        tokenContractAsset,
        fees,
      ) = await FutureExt.wait6(
        model.getTokenCurrency(),
        model.getEverCurrency(),
        model.getAverageAPYPercent(),
        model.getStEverDetails(),
        model.getTokenContractAsset(),
        model.computeFees(),
      );

      final time = Duration(
        seconds: int.tryParse(details.withdrawHoldTime) ?? 0,
      ).inHours;

      _infoState.content(
        StakingInfo(
          wallet: ever.wallet!,
          tokenWallet: token.wallet!,
          currency: currency!,
          tokenCurrency: tokenCurrency!,
          details: details,
          apy: apyValue,
          withdrawHours: 0 <= time && time <= 24 ? time + 36 : time + 18,
          tokenContractAsset: tokenContractAsset,
          fees: fees,
        ),
      );

      _updateData();

      if (!model.getWasStEverOpened) {
        unawaited(showHowItWorksSheet());
      }
    } on Exception catch (e, t) {
      _logger.severe('init', e, t);
      _infoState.error(e);
    } finally {
      _isLoadingState.value = false;
    }
  }

  void _updateData() {
    final info = _infoState.value.data;

    if (info == null) return;

    final data = switch (_tabState.value) {
      StakingTab.stake => StakingData(
          tab: StakingTab.stake,
          attachedAmount: Money.fromBigIntWithCurrency(
            info.fees.depositAttachedFee,
            currency,
          ),
          exchangeRate: info.details.stEverSupply / info.details.totalAssets,
          receiveCurrency: info.tokenWallet.currency,
          asset: AmountInputAsset(
            rootTokenContract: model.transport.nativeTokenAddress,
            isNative: true,
            balance: Money.fromBigIntWithCurrency(
              info.wallet.contractState.balance,
              currency,
            ),
            logoURI: model.transport.nativeTokenIcon,
            title: model.transport.nativeTokenTicker,
            tokenSymbol: model.transport.nativeTokenTicker,
            currency: info.currency,
          ),
        ),
      StakingTab.unstake => StakingData(
          tab: StakingTab.unstake,
          attachedAmount: Money.fromBigIntWithCurrency(
            info.fees.withdrawAttachedFee,
            currency,
          ),
          exchangeRate: info.details.totalAssets / info.details.stEverSupply,
          receiveCurrency: currency,
          asset: AmountInputAsset(
            rootTokenContract: info.tokenWallet.symbol.rootTokenContract,
            isNative: false,
            balance: info.tokenWallet.moneyBalance,
            logoURI: info.tokenContractAsset?.logoURI ??
                Assets.images.tokenDefaultIcon.path,
            title: info.tokenWallet.currency.name,
            tokenSymbol: info.tokenWallet.currency.symbol,
            currency: info.tokenCurrency,
          ),
        ),
      StakingTab.inProgress => StakingData(
          tab: StakingTab.inProgress,
          attachedAmount: Money.fromBigIntWithCurrency(
            info.fees.removePendingWithdrawAttachedFee,
            currency,
          ),
          exchangeRate: info.details.totalAssets / info.details.stEverSupply,
          receiveCurrency: info.tokenWallet.currency,
        ),
    };

    _dataState.accept(data);
  }

  Future<Money?> _getReceive() async {
    final tab = _tabState.value;
    final currency = tab == StakingTab.stake
        ? _infoState.value.data?.tokenWallet.currency
        : model.nativeCurrency;
    final value = _currentValue;

    if (currency == null) return null;

    if (value.isZero) {
      return Money.fromBigIntWithCurrency(BigInt.zero, currency);
    }

    final amount = tab == StakingTab.stake
        ? await model.getDepositTokenAmount(value.minorUnits)
        : await model.getWithdrawEverAmount(value.minorUnits);

    return Money.fromBigIntWithCurrency(amount, currency);
  }

  ValidationState _validate() {
    final info = _infoState.value.data;
    final value = _currentValue;

    if (info == null) return const ValidationState.invalid();
    if (inputController.text.isEmpty) return const ValidationState.invalid();

    final nativeBalance = Money.fromBigIntWithCurrency(
      info.wallet.contractState.balance,
      currency,
    );
    final balance = switch (_tabState.value) {
      StakingTab.stake => nativeBalance,
      StakingTab.unstake => info.tokenWallet.moneyBalance,
      StakingTab.inProgress => Money.fromInt(0, isoCode: currency.isoCode),
    };

    if (_tabState.value == StakingTab.stake &&
        balance.amount < _comission.amount + value) {
      final max = balance - _comission;

      return ValidationState.invalid(
        LocaleKeys.stakingMaxSendableAmount.tr(
          args: [
            max.positiveOrZero().formatImproved(),
            max.currency.isoCode,
          ],
        ),
      );
    }
    if (_tabState.value == StakingTab.unstake &&
        nativeBalance.amount < _comission.amount) {
      return ValidationState.invalid(
        LocaleKeys.stakingNotEnoughBalanceToUnstake.tr(
          args: [
            _comission.formatImproved(),
            _comission.currency.isoCode,
          ],
        ),
      );
    }
    if (value == Fixed.zero || value > balance.amount) {
      return const ValidationState.invalid();
    }

    return const ValidationState.valid();
  }

  Future<void> _prepareStaking() async {
    final info = _infoState.value.data;
    if (info == null) return;

    final valutAddress = model.staking.stakingValutAddress;
    final amount = _currentValue.minorUnits;

    final (payload, fees) = await FutureExt.wait2(
      model.depositEverBodyPayload(amount),
      model.computeFees(),
    );

    final isMultisig = (_wallet?.custodians?.length ?? 0) > 1;

    contextSafe?.compassContinue(
      TonWalletSendRouteData(
        address: accountAddress,
        publicKey: info.wallet.publicKey,
        payload: payload,
        destination: valutAddress,
        amount: amount,
        attachedAmount: fees.depositAttachedFee,
        popOnComplete: false,
        resultMessage: !isMultisig
            ? LocaleKeys.stEverAppearInMinutes.tr(
                args: [tokenCurrency?.symbol ?? ''],
              )
            : null,
      ),
    );
  }

  Future<void> _prepareUntaking() async {
    final info = _infoState.value.data;
    if (info == null) return;

    final valutAddress = model.staking.stakingValutAddress;
    final rootContractAddress = model.staking.stakingRootContractAddress;
    final amount = _currentValue.minorUnits;

    final (payload, fees) = await FutureExt.wait2(
      model.withdrawStEverPayload(),
      model.computeFees(),
    );

    contextSafe?.compassContinue(
      TokenWalletSendRouteData(
        owner: accountAddress,
        rootTokenContract: rootContractAddress,
        publicKey: info.wallet.publicKey,
        comment: payload,
        destination: valutAddress,
        amount: amount,
        attachedAmount: fees.withdrawAttachedFee,
        resultMessage: LocaleKeys.withdrawHoursProgress.tr(
          args: [currency.symbol, info.withdrawHours.toString()],
        ),
        notifyReceiver: true,
      ),
    );
  }
}

class ValidationState {
  const ValidationState._(
    this.isValid, {
    this.message,
  });

  const ValidationState.valid() : this._(true);

  const ValidationState.invalid([String? message])
      : this._(false, message: message);

  final bool isValid;
  final String? message;
}
