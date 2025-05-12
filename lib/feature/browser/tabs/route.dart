import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/tabs/tabs_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@singleton
class BrowserTabsRoute extends CompassRouteParameterless<BrowserTabsRouteData> {
  BrowserTabsRoute()
      : super(
          name: 'browser-tabs',
          builder: (context, _, __) => const TabsPage(),
        );

  @override
  BrowserTabsRouteData dataFabric() {
    return const BrowserTabsRouteData();
  }
}

/// Data model for BrowserTabs route
@freezed
class BrowserTabsRouteData
    with _$BrowserTabsRouteData
    implements CompassRouteData {
  const factory BrowserTabsRouteData() = _BrowserTabsRouteData;

  const BrowserTabsRouteData._();
}
