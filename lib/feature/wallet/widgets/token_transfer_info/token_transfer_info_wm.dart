import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_model.dart';
import 'package:app/feature/wallet/widgets/token_transfer_info/token_transfer_info_widget.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';
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
  });

  final Address? recipient;
  final Money? amount;
  final BigInt? attachedAmount;
  final Address? rootTokenContract;
  final String? transactionIdHash;
  final String? comment;
  final String? payload;
  final Fee? fee;
  final String? feeError;
  final int? numberUnconfirmedTransactions;
}

@injectable
class TokenTransferInfoWidgetModel extends CustomWidgetModelParametrized<
    TokenTransferInfoWidget,
    TokenTransferInfoModel,
    TokenTransferInfoWmParams> {
  TokenTransferInfoWidgetModel(
    super.model,
  );

  late final feeState = createWmParamsNotifier((it) => it.fee);
  late final recipientState = createWmParamsNotifier((it) => it.recipient);

  late final transactionIdHashState =
      createWmParamsNotifier((it) => it.transactionIdHash);

  late final feeErrorState = createWmParamsNotifier((it) => it.feeError);

  late final commentState = createWmParamsNotifier((it) => it.comment);

  late final payloadState = createWmParamsNotifier((it) => it.payload);

  late final numberUnconfirmedTransactionsState =
      createWmParamsNotifier((it) => it.numberUnconfirmedTransactions);

  late final attachedAmountState = createWmParamsNotifier(
    (it) => it.attachedAmount?.let(
      (value) => Money.fromBigIntWithCurrency(value, nativeCurrency),
    ),
  );

  late final isNativeState = createWmParamsNotifier(
    (it) => it.rootTokenContract == null,
  );

  late final amountState = createWmParamsNotifier((it) => it.amount);

  late final _amountUSDPriceState = createWmParamsNotifier(
    (it) => it.rootTokenContract == null
        ? model.getCurrencyForNativeToken()?.price.let(Fixed.tryParse)
        : model
            .getCurrencyForContract(it.rootTokenContract!)
            ?.price
            .let(Fixed.tryParse),
  );
  late final _nativeUSDPriceState = createNotifier(
    model.getCurrencyForNativeToken()?.price.let(Fixed.tryParse),
  );
  late final _feeUSDPriceState = createNotifierFromStream(
    wmParams.switchMap((wmParams) {
      return switch (wmParams.fee) {
        FeeNative() => _nativeUSDPriceState.asStream(),
        FeeToken(:final tokenRootAddress) =>
          wmParams.rootTokenContract == tokenRootAddress
              ? _amountUSDPriceState.asStream()
              : _getTokenPrice(tokenRootAddress).asStream(),
        _ => Stream.value(null),
      };
    }),
  );
  late final _tokenAssetState = createNotifier<TokenContractAsset>();
  late final _feeAssetState = createNotifierFromStream(
    wmParams.switchMap((wmParams) {
      return switch (wmParams.fee) {
        FeeToken(:final tokenRootAddress) =>
          wmParams.rootTokenContract == tokenRootAddress
              ? _tokenAssetState.asStream()
              : _getTokenAsset(tokenRootAddress).asStream(),
        _ => Stream.value(null),
      };
    }),
  );

  ValueListenable<Fixed?> get amountUSDPriceState => _amountUSDPriceState;

  ListenableState<Fixed?> get nativeUSDPriceState => _nativeUSDPriceState;

  ListenableState<Fixed?> get feeUSDPriceState => _feeUSDPriceState;

  ListenableState<TokenContractAsset?> get tokenAssetState => _tokenAssetState;

  ListenableState<TokenContractAsset?> get feeAssetState => _feeAssetState;

  Currency get nativeCurrency =>
      Currencies()[model.transport.nativeTokenTicker]!;

  String get nativeTokenIcon => model.transport.nativeTokenIcon;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _getNativePrice();

    final rootTokenContract = wmParams.value.rootTokenContract;
    if (rootTokenContract != null) {
      _getTokenPrice(rootTokenContract).then((price) {
        _amountUSDPriceState.value = price;
      });
      _getTokenAsset(rootTokenContract).then((asset) {
        _tokenAssetState.accept(asset);
      });
    }
  }

  Future<void> _getNativePrice() async {
    final currency = await model.fetchCurrencyForNativeToken();

    if (currency != null) {
      final price = Fixed.parse(currency.price);
      _nativeUSDPriceState.accept(price);

      if (wmParams.value.rootTokenContract == null) {
        _amountUSDPriceState.value = price;
      }
    }
  }

  Future<Fixed?> _getTokenPrice(Address rootTokenContract) async {
    final currency = await model.fetchCurrencyForContract(rootTokenContract);
    return currency?.let((it) => Fixed.parse(it.price));
  }

  Future<TokenContractAsset?> _getTokenAsset(Address rootTokenContract) {
    return model.getTokenAsset(rootTokenContract);
  }
}
