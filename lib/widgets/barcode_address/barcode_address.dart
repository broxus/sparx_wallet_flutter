import 'package:app/core/wm/custom_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/barcode_address/barcode_address_wm.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/components/common/container/shaped_container_column.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BarcodeAddress extends InjectedElementaryParametrizedWidget<
    BarcodeAddressWidgetModel, BarcodeAddressWmParams> {
  BarcodeAddress({
    required Address address,
    super.key,
  }) : super(
          wmFactoryParam: BarcodeAddressWmParams(address),
        );

  @override
  Widget build(BarcodeAddressWidgetModel wm) {


    return ShapedContainerColumn(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 0,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSizeV2.d32,
      ),
      color: wm.colors.background2,
      children: [
        BarcodeWidget(
          margin: const EdgeInsets.symmetric(
            vertical: DimensSizeV2.d32,
          ),
          width: DimensSize.d148,
          height: DimensSize.d148,
          data: wm.address,
          barcode: Barcode.qrCode(),
          color: wm.colors.primaryA,
        ),
        Text(
          LocaleKeys.addressWord.tr(),
          style: wm.textStyles.labelXSmall.copyWith(
            color: wm.colors.content3,
          ),
        ),
        const SizedBox(height: DimensSizeV2.d4),
        Text(
          wm.address,
          style: wm.textStyles.labelXSmall.copyWith(
            color: wm.colors.content0,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSize.d12),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          onPressed: wm.copyAddress,
          title: LocaleKeys.copyWord.tr(),
          postfixIcon: LucideIcons.copy,
          isFullWidth: false,
          padding: const EdgeInsets.symmetric(
            vertical: DimensSizeV2.d12,
            horizontal: DimensSizeV2.d24,
          ),
        ),
        const SizedBox(height: DimensSizeV2.d32),
      ],
    );
  }


}
