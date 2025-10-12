import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/app/router/router.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/route.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class RootTabService {
  RootTabService(
    this._router,
    this._browserService,
  );

  final CompassRouter _router;
  final BrowserService _browserService;

  final _scrollTabToTopSubject = PublishSubject<RootTab>();

  Stream<RootTab> get rootTabStream => _router.currentRoutesStream.map(
        (it) => RootTab.getByRoute(it.firstOrNull),
      );

  Stream<BottomBarState> get bottomBarStateStream =>
      _router.currentRoutesStream.switchMap(
        (it) {
          final currentRoute = it.lastOrNull;

          switch (currentRoute?.runtimeType) {
            case BrowserRoute:
              return _browserService.isContentInteractedStream.map(
                (isContentInteracted) => isContentInteracted
                    ? BottomBarState.collapsed
                    : BottomBarState.expanded,
              );
            default:
              final state =
                  currentRoute?.bottomBarState ?? BottomBarState.hidden;

              return Stream.value(state);
          }
        },
      );

  Stream<RootTab> get scrollTabToTopSubject => _scrollTabToTopSubject.stream;

  bool tryToChangeTabAndCheckDiff(RootTab tab) {
    final currentTab = RootTab.getByRoute(_router.currentRoutes.firstOrNull);
    final isTabUpdated = currentTab != tab;

    if (!isTabUpdated) {
      _scrollTabToTopSubject.add(tab);
    }

    return isTabUpdated;
  }
}
