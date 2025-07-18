import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

NftTransferInfoWidgetModel defaultNftTransferInfoWidgetModelFactory(
  BuildContext context,
) =>
    NftTransferInfoWidgetModel(
      NftTransferInfoModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
      ),
    );

class NftTransferInfoWidgetModel
    extends CustomWidgetModel<NftTransferInfoWidget, NftTransferInfoModel> {
  NftTransferInfoWidgetModel(super.model);

  late final _nativeUSDPrice = createNotifier<Fixed>(
    model.getCurrencyForNativeToken()?.price.let(Fixed.tryParse),
  );

  ListenableState<Fixed> get nativeUSDPrice => _nativeUSDPrice;

  Currency get nativeCurrency =>
      Currencies()[model.transport.nativeTokenTicker]!;

  String get nativeTokenIcon => model.transport.nativeTokenIcon;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _getNativePrice();
  }

  Future<void> _getNativePrice() async {
    final currency = await model.fetchCurrencyForNativeToken();

    if (currency != null) {
      final price = Fixed.parse(currency.price);
      _nativeUSDPrice.accept(price);
    }
  }
}
