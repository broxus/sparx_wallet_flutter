import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_model.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_widget.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

TokenTransferInfoWidgetModel defaultTokenTransferInfoWidgetModelFactory(
  BuildContext context,
) =>
    TokenTransferInfoWidgetModel(
      TokenTransferInfoModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class TokenTransferInfoWidgetModel
    extends CustomWidgetModel<TokenTransferInfoWidget, TokenTransferInfoModel> {
  TokenTransferInfoWidgetModel(super.model);

  late final _amountUSDPrice = createNotifier<Fixed>(
    widget.rootTokenContract == null
        ? model.getCurrencyForNativeToken()?.price.let(Fixed.tryParse)
        : model
            .getCurrencyForContract(widget.rootTokenContract!)
            ?.price
            .let(Fixed.tryParse),
  );
  late final _nativeUSDPrice = createNotifier<Fixed>(
    model.getCurrencyForNativeToken()?.price.let(Fixed.tryParse),
  );
  late final _tokenAsset = createNotifier<TokenContractAsset>();
  late final _fee = createNotifier(
    widget.hasFee
        ? Money.fromBigIntWithCurrency(
            widget.fee ?? BigInt.zero,
            nativeCurrency,
          )
        : null,
  );
  late final _feeError = createNotifier(widget.feeError);
  late final _attachedAmount = createNotifier(
    widget.attachedAmount?.let(
      (value) => Money.fromBigIntWithCurrency(value, nativeCurrency),
    ),
  );

  ListenableState<Fixed> get amountUSDPrice => _amountUSDPrice;

  ListenableState<Fixed> get nativeUSDPrice => _nativeUSDPrice;

  ListenableState<TokenContractAsset> get tokenAsset => _tokenAsset;

  ListenableState<Money> get fee => _fee;

  ListenableState<String> get feeError => _feeError;

  ListenableState<Money> get attachedAmount => _attachedAmount;

  Currency get nativeCurrency =>
      Currencies()[model.transport.nativeTokenTicker]!;

  String get nativeTokenIcon => model.transport.nativeTokenIcon;

  ThemeStyleV2 get theme => context.themeStyleV2;

  bool get isNative => widget.rootTokenContract == null;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _getNativePrice();
    _getTokenPrice();
    _getTokenAsset();
  }

  @override
  void didUpdateWidget(TokenTransferInfoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _fee.accept(
      widget.hasFee
          ? Money.fromBigIntWithCurrency(
              widget.fee ?? BigInt.zero,
              nativeCurrency,
            )
          : null,
    );
    _feeError.accept(widget.feeError);
    _attachedAmount.accept(
      widget.attachedAmount?.let(
        (value) => Money.fromBigIntWithCurrency(value, nativeCurrency),
      ),
    );
  }

  Future<void> _getNativePrice() async {
    final currency = await model.fetchCurrencyForNativeToken();

    if (currency != null) {
      final price = Fixed.parse(currency.price);
      _nativeUSDPrice.accept(price);

      if (isNative && widget.amount != null) {
        _amountUSDPrice.accept(price);
      }
    }
  }

  Future<void> _getTokenPrice() async {
    if (widget.rootTokenContract == null) return;

    final currency = await model.fetchCurrencyForContract(
      widget.rootTokenContract!,
    );

    if (currency != null && widget.amount != null) {
      final price = Fixed.parse(currency.price);
      _amountUSDPrice.accept(price);
    }
  }

  Future<void> _getTokenAsset() async {
    if (widget.rootTokenContract == null) return;

    final tokenAsset = await model.getTokenAsset(widget.rootTokenContract!);

    _tokenAsset.accept(tokenAsset);
  }
}
