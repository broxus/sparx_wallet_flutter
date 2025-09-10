import 'package:app/core/wm/custom_wm.dart';
import 'package:app/widgets/barcode_address/barcode_address.dart';
import 'package:app/widgets/barcode_address/barcode_address_model.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';

/// [WidgetModel] for [BarcodeAddress]
@injectable
class BarcodeAddressWidgetModel extends CustomWidgetModelParametrized<
    BarcodeAddress, BarcodeAddressModel, BarcodeAddressWmParams> {
  BarcodeAddressWidgetModel(
    super.model,
  );

  String get address => wmParams.value.address.address;

  ColorsPaletteV2 get colors => _theme.colors;

  TextStylesV2 get textStyles => _theme.textStyles;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  void copyAddress() {
    model.showSuccess(wmParams.value.address);
  }
}

class BarcodeAddressWmParams {
  const BarcodeAddressWmParams(this.address);

  final Address address;
}
