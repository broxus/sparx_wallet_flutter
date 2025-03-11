import 'package:app/feature/browserV2/screens/main/data/control_panels_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/nav_panel/nav_panel.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [BrowserTabViewMenuNavPanel]
class BrowserTabViewMenuNavPanelModel extends ElementaryModel {
  BrowserTabViewMenuNavPanelModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<BrowserControlPanelData> get controlState =>
      _browserService.tM.controlPanelState;

  void back() {
    _browserService.tM.backWeb();
  }

  void forward() {
    _browserService.tM.forwardWeb();
  }
}
