import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animated_view.dart';
import 'package:app/feature/browser_v2/service/browser_service.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [TabAnimatedView]
class TabAnimatedViewModel extends ElementaryModel {
  TabAnimatedViewModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  String? get screenshotPath => _browserService.tM.activeTabScreenshotPath;
}
