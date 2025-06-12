import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserSizesUiDelegate {
  BrowserSizesUiDelegate(this._context);

  final BuildContext _context;

  late final _screenSize = MediaQuery.of(_context).size;

  late final urlWidth = screenWidth * .915 + DimensSizeV2.d16;

  late final screenHeight = _screenSize.height;
  late final screenWidth = _screenSize.width;
}
