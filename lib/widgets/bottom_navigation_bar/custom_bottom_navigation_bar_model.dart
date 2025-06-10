import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/feature/root/domain/root_tab_service.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [CustomBottomNavigationBar]
class CustomBottomNavigationBarModel extends ElementaryModel {
  CustomBottomNavigationBarModel(
    ErrorHandler errorHandler,
    this._rootTabRepository,
  ) : super(errorHandler: errorHandler);

  final RootTabService _rootTabRepository;

  Stream<RootTab> get rootTabStream => _rootTabRepository.rootTabStream;

  Stream<BottomBarState> get bottomBarStateStream =>
      _rootTabRepository.bottomBarStateStream;

  bool tryToChangeTabAndCheckDiff(RootTab tab) {
    return _rootTabRepository.tryToChangeTabAndCheckDiff(tab);
  }
}
