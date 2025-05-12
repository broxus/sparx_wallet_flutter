
import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/history/history_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@singleton
class BrowserHistoryRoute
    extends CompassRouteParameterless<BrowserHistoryRouteData> {
  BrowserHistoryRoute()
      : super(
          name: 'browser-history',
          builder: (context, _, __) => const HistoryPage(),
        );

  @override
  BrowserHistoryRouteData dataFabric() {
    return const BrowserHistoryRouteData();
  }
}

/// Data model for BrowserHistory route
@freezed
class BrowserHistoryRouteData
    with _$BrowserHistoryRouteData
    implements CompassRouteData {
  const factory BrowserHistoryRouteData() = _BrowserHistoryRouteData;

  const BrowserHistoryRouteData._();
}
