import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_model.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TokenTransferInfoWmParams {
  const TokenTransferInfoWmParams({
    this.recipient,
    this.amount,
    this.attachedAmount,
    this.rootTokenContract,
    this.transactionIdHash,
    this.comment,
    this.payload,
    this.fee,
    this.feeError,
    this.color,
    this.numberUnconfirmedTransactions,
    this.hasFee = true,
    this.margin = EdgeInsets.zero,
  });

  final EdgeInsets margin;
  final Money? amount;
  final Address? recipient;
  final BigInt? fee;
  final BigInt? attachedAmount;
  final Address? rootTokenContract;
  final String? transactionIdHash;
  final String? comment;
  final String? payload;
  final String? feeError;
  final Color? color;
  final int? numberUnconfirmedTransactions;
  final bool hasFee;
}

@injectable
class TokenTransferInfoWidgetModel
    extends CustomWidgetModel<ElementaryWidget, TokenTransferInfoModel> {
  TokenTransferInfoWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final TokenTransferInfoWmParams _wmParams;

  late final _amountUSDPrice = createNotifier<Fixed>(
    _wmParams.rootTokenContract == null
        ? model.getCurrencyForNativeToken()?.price.let(Fixed.tryParse)
        : model
            .getCurrencyForContract(_wmParams.rootTokenContract!)
            ?.price
            .let(Fixed.tryParse),
  );
  late final _nativeUSDPrice = createNotifier<Fixed>(
    model.getCurrencyForNativeToken()?.price.let(Fixed.tryParse),
  );
  late final _tokenAsset = createNotifier<TokenContractAsset>();
  late final _fee = createNotifier(
    _wmParams.hasFee
        ? Money.fromBigIntWithCurrency(
            _wmParams.fee ?? BigInt.zero,
            nativeCurrency,
          )
        : null,
  );
  late final _feeError = createNotifier(_wmParams.feeError);
  late final _attachedAmount = createNotifier(
    _wmParams.attachedAmount?.let(
      (value) => Money.fromBigIntWithCurrency(value, nativeCurrency),
    ),
  );
  late final _amount = createNotifier(_wmParams.amount);

  ListenableState<Fixed> get amountUSDPrice => _amountUSDPrice;

  ListenableState<Fixed> get nativeUSDPrice => _nativeUSDPrice;

  ListenableState<TokenContractAsset> get tokenAsset => _tokenAsset;

  ListenableState<Money> get fee => _fee;

  ListenableState<String> get feeError => _feeError;

  ListenableState<Money> get attachedAmount => _attachedAmount;

  ListenableState<Money> get amount => _amount;

  Currency get nativeCurrency =>
      Currencies()[model.transport.nativeTokenTicker]!;

  String get nativeTokenIcon => model.transport.nativeTokenIcon;

  ThemeStyleV2 get theme => context.themeStyleV2;

  bool get isNative => _wmParams.rootTokenContract == null;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _getNativePrice();
    _getTokenPrice();
    _getTokenAsset();
  }

  Future<void> _getNativePrice() async {
    final currency = await model.fetchCurrencyForNativeToken();

    if (currency != null) {
      final price = Fixed.parse(currency.price);
      _nativeUSDPrice.accept(price);

      if (isNative && _wmParams.amount != null) {
        _amountUSDPrice.accept(price);
      }
    }
  }

  Future<void> _getTokenPrice() async {
    if (_wmParams.rootTokenContract == null) return;

    final currency = await model.fetchCurrencyForContract(
      _wmParams.rootTokenContract!,
    );

    if (currency != null && _wmParams.amount != null) {
      final price = Fixed.parse(currency.price);
      _amountUSDPrice.accept(price);
    }
  }

  Future<void> _getTokenAsset() async {
    if (_wmParams.rootTokenContract == null) return;

    final tokenAsset = await model.getTokenAsset(_wmParams.rootTokenContract!);

    _tokenAsset.accept(tokenAsset);
  }
}
