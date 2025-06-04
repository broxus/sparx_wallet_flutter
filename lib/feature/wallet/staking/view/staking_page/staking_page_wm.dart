import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/token_wallet_send/route.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/amount_input/amount_input_asset.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _maxFixedComission = 0.1; // 0.1 EVER

StakingPageWidgetModel defaultStakingPageWidgetModelFactory(
  BuildContext context,
) =>
    StakingPageWidgetModel(
      StakingPageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
        inject(),
        inject(),
      ),
    );

class StakingPageWidgetModel
    extends CustomWidgetModel<StakingPageWidget, StakingPageModel> {
  StakingPageWidgetModel(super.model);

  late final inputController = createTextEditingController();

  final _logger = Logger('StakingPageWidgetModel');

  late final _isLoading = createValueNotifier(true);
  late final _tab = createValueNotifier(StakingTab.stake);
  late final _info = createEntityNotifier<StakingInfo>()..loading();
  late final _data = createNotifier<StakingData>();
  late final _requests = createNotifierFromStream(
    model.getWithdrawRequests(widget.accountAddress),
  );
  late final _receive = createNotifierFromStream(
    Rx.combineLatestList(
      [_tab.asStream(), inputController.asStream()],
    ).switchMap(
      (_) => _getReceive().asStream().whereNotNull(),
    ),
  );
  late final _validation = createNotifierFromStream(
    Rx.combineLatestList(
      [_tab.asStream(), _info.asStream(), inputController.asStream()],
    ).map(
      (_) => _validate(),
    ),
  );

  ValueListenable<bool> get isLoading => _isLoading;

  ValueListenable<StakingTab> get tab => _tab;

  ListenableState<List<StEverWithdrawRequest>> get requests => _requests;

  ListenableState<Money> get receive => _receive;

  ListenableState<ValidationState> get validation => _validation;

  EntityValueListenable<StakingInfo> get info => _info;

  ListenableState<StakingData> get data => _data;

  ThemeStyleV2 get theme => context.themeStyleV2;

  /// Native currency
  Currency get currency => model.nativeCurrency;

  Currency? get tokenCurrency => _info.value.data?.tokenWallet.currency;

  Fixed get _currentValue =>
      Fixed.tryParse(
        inputController.text.trim().replaceAll(',', '.'),
        scale: _currentCurrency?.decimalDigits ?? 0,
      ) ??
      Fixed.zero;

  Currency? get _currentCurrency => _tab.value == StakingTab.stake
      ? currency
      : _info.value.data?.tokenWallet.currency;

  Money get _comission {
    final fees = _info.value.data?.fees ?? StakingFees.empty();

    return _tab.value == StakingTab.stake
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
    final info = await _info.asStream().firstWhere((e) => e.data != null);

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
    _tab.value = value;
    inputController.clear();
    _updateData();
  }

  void onMaxAmount() {
    var max = _data.value?.asset?.balance;

    if (max == null) return;

    if (_tab.value == StakingTab.stake) {
      max = max - _comission;
    }

    inputController.text = max.positiveOrZero().formatImproved();
  }

  void onSubmit() {
    switch (_tab.value) {
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
      final rootContractAddress = model.staking.stakingRootContractAddress;
      final group = model.transport.transport.group;
      final account = model.findAccountByAddress(widget.accountAddress);
      final asset = account?.additionalAssets[group]?.tokenWallets
          .firstWhereOrNull((c) => c.rootTokenContract == rootContractAddress);

      // if staking coin not in account, add it
      if (asset == null) {
        unawaited(account?.addTokenWallet(rootContractAddress));
      }

      final (ever, token) = await FutureExt.wait2(
        model.getWallet(widget.accountAddress),
        model.getTokenWallet(widget.accountAddress),
      );

      if (ever.hasError || token.hasError) {
        _info.error();
        return;
      }

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

      _info.content(
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
      _info.error(e);
    } finally {
      _isLoading.value = false;
    }
  }

  void _updateData() {
    final info = _info.value.data;

    if (info == null) return;

    final data = switch (_tab.value) {
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
            title: info.tokenWallet.symbol.fullName,
            tokenSymbol: info.tokenWallet.symbol.name,
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

    _data.accept(data);
  }

  Future<Money?> _getReceive() async {
    final tab = _tab.value;
    final currency = _currentCurrency;
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
    final info = _info.value.data;
    final value = _currentValue;

    if (info == null) return const ValidationState.invalid();
    if (inputController.text.isEmpty) return const ValidationState.invalid();

    final nativeBalance = Money.fromBigIntWithCurrency(
      info.wallet.contractState.balance,
      currency,
    );
    final balance = switch (_tab.value) {
      StakingTab.stake => nativeBalance,
      StakingTab.unstake => info.tokenWallet.moneyBalance,
      StakingTab.inProgress => Money.fromInt(0, isoCode: currency.isoCode),
    };

    if (_tab.value == StakingTab.stake &&
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
    if (_tab.value == StakingTab.unstake &&
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
    final info = _info.value.data;
    if (info == null) return;

    final valutAddress = model.staking.stakingValutAddress;
    final amount = _currentValue.minorUnits;

    final (payload, fees) = await FutureExt.wait2(
      model.depositEverBodyPayload(amount),
      model.computeFees(),
    );

    contextSafe?.compassContinue(
      TonWalletSendRouteData(
        address: widget.accountAddress,
        publicKey: info.wallet.publicKey,
        payload: payload,
        destination: valutAddress,
        amount: amount,
        attachedAmount: fees.depositAttachedFee,
        popOnComplete: false,
        resultMessage: LocaleKeys.stEverAppearInMinutes.tr(
          args: [tokenCurrency?.symbol ?? ''],
        ),
      ),
    );
  }

  Future<void> _prepareUntaking() async {
    final info = _info.value.data;
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
        owner: widget.accountAddress,
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
