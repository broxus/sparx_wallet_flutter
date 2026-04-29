import 'package:app/core/wm/custom_wm.dart';
import 'package:app/widgets/barcode_address/barcode_address.dart';
import 'package:app/widgets/barcode_address/barcode_address_model.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// [WidgetModel] for [BarcodeAddress]
@injectable
class BarcodeAddressWidgetModel
    extends
        CustomWidgetModelParametrized<
          BarcodeAddress,
          BarcodeAddressModel,
          BarcodeAddressWmParams
        > {
  BarcodeAddressWidgetModel(super.model);

  String get address => wmParams.value.address.address;

  ColorsPalette get colors => _theme.colors;

  TextStyles get textStyles => _theme.textStyles;

  ThemeStyle get _theme => context.themeStyle;

  void copyAddress() {
    model.showSuccess(wmParams.value.address);
  }
}

class BarcodeAddressWmParams {
  const BarcodeAddressWmParams(this.address);

  final Address address;
}
