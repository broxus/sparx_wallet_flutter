import 'package:app/feature/browser/domain/service/browser_service.dart';
import 'package:app/feature/browser/screens/main/widgets/tab_animated_view/tab_animated_view.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [TabAnimatedView]
@injectable
class TabAnimatedViewModel extends ElementaryModel {
  TabAnimatedViewModel(ErrorHandler errorHandler, this._browserService)
    : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  String? get screenshotPath => _browserService.tab.activeTabScreenshotPath;
}
