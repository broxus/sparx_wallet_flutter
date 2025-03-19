import 'package:app/feature/browser_v2/screens/main/data/control_panels_data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panel/main_control_panel/main_control_panel.dart';
import 'package:app/feature/browser_v2/service/browser_service.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [BrowserMainControlPanel]
class BrowserMainControlPanelModel extends ElementaryModel {
  BrowserMainControlPanelModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<BrowserMainControlPanelData> get controlState =>
      _browserService.tM.controlPanelState;

  void back() {
    _browserService.tM.backWeb();
  }

  void forward() {
    _browserService.tM.forwardWeb();
  }
}
