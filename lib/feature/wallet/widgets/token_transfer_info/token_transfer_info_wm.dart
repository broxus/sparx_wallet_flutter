import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_model.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_widget.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
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
    this.numberUnconfirmedTransactions,
    this.hasFee = true,
  });

  final Address? recipient;
  final Money? amount;
  final BigInt? attachedAmount;
  final Address? rootTokenContract;
  final String? transactionIdHash;
  final String? comment;
  final String? payload;
  final BigInt? fee;
  final String? feeError;
  final int? numberUnconfirmedTransactions;
  final bool hasFee;
}

@injectable
class TokenTransferInfoWidgetModel extends CustomWidgetModelParametrized<
    TokenTransferInfoWidget,
    TokenTransferInfoModel,
    TokenTransferInfoWmParams> {
  TokenTransferInfoWidgetModel(
    super.model,
  );
  late final _amountUSDPriceState = createWmParamsNotifier<Fixed?>(
    (it) => it.rootTokenContract == null
        ? model.getCurrencyForNativeToken()?.price.let(Fixed.tryParse)
        : model
            .getCurrencyForContract(it.rootTokenContract!)
            ?.price
            .let(Fixed.tryParse),
  );

  late final _nativeUSDPriceState = createNotifier<Fixed>(
    model.getCurrencyForNativeToken()?.price.let(Fixed.tryParse),
  );
  late final _tokenAssetState = createNotifier<TokenContractAsset>();
  late final ValueListenable<Money?> feeState = createWmParamsNotifier(
    (it) => it.hasFee
        ? Money.fromBigIntWithCurrency(
            it.fee ?? BigInt.zero,
            nativeCurrency,
          )
        : null,
  );

  late final ValueListenable<Address?> recipientState =
      createWmParamsNotifier((it) => it.recipient);

  late final ValueListenable<String?> transactionIdHashState =
      createWmParamsNotifier((it) => it.transactionIdHash);

  late final ValueListenable<String?> feeErrorState =
      createWmParamsNotifier((it) => it.feeError);

  late final ValueListenable<String?> commentState =
      createWmParamsNotifier((it) => it.comment);

  late final ValueListenable<String?> payloadState =
      createWmParamsNotifier((it) => it.payload);

  late final ValueListenable<int?> numberUnconfirmedTransactionsState =
      createWmParamsNotifier((it) => it.numberUnconfirmedTransactions);

  late final ValueListenable<Money?> attachedAmountState =
      createWmParamsNotifier(
    (it) => it.attachedAmount?.let(
      (value) => Money.fromBigIntWithCurrency(value, nativeCurrency),
    ),
  );

  late final ValueListenable<bool> isNativeState = createWmParamsNotifier(
    (it) => it.rootTokenContract == null,
  );

  late final ValueListenable<Money?> amountState =
      createWmParamsNotifier((it) => it.amount);

  ValueListenable<Fixed?> get amountUSDPriceState => _amountUSDPriceState;

  ListenableState<Fixed?> get nativeUSDPriceState => _nativeUSDPriceState;

  ListenableState<TokenContractAsset?> get tokenAssetState => _tokenAssetState;

  Currency get nativeCurrency =>
      Currencies()[model.transport.nativeTokenTicker]!;

  String get nativeTokenIcon => model.transport.nativeTokenIcon;

  ThemeStyleV2 get theme => context.themeStyleV2;

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
      _nativeUSDPriceState.accept(price);

      if (wmParams.value.rootTokenContract == null &&
          wmParams.value.amount != null) {
        _amountUSDPriceState.value = price;
      }
    }
  }

  Future<void> _getTokenPrice() async {
    if (wmParams.value.rootTokenContract == null) return;

    final currency = await model.fetchCurrencyForContract(
      wmParams.value.rootTokenContract!,
    );

    if (currency != null && wmParams.value.amount != null) {
      final price = Fixed.parse(currency.price);
      _amountUSDPriceState.value = price;
    }
  }

  Future<void> _getTokenAsset() async {
    if (wmParams.value.rootTokenContract == null) return;

    final tokenAsset =
        await model.getTokenAsset(wmParams.value.rootTokenContract!);

    _tokenAssetState.accept(tokenAsset);
  }
}
