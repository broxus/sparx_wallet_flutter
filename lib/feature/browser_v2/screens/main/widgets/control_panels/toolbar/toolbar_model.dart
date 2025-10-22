import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/data/toolbar_data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/toolbar/toolbar.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [Toolbar]
@injectable
class ToolbarModel extends ElementaryModel {
  ToolbarModel(ErrorHandler errorHandler, this._browserService)
    : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  ListenableState<ToolbarData> get controlState =>
      _browserService.tab.controlPanelState;

  void back() {
    _browserService.tab.backWeb();
  }

  void forward() {
    _browserService.tab.forwardWeb();
  }
}
