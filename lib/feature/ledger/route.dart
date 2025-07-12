import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class LedgerRoute extends CompassRouteParameterless<LedgerRouteData> {
  LedgerRoute()
      : super(
          name: 'ledger',
          path: '/ledger',
          isSaveLocation: true,
          isSaveSubroutes: true,
          isBottomNavigationBarVisible: true,
          builder: (context, _, __) => const LedgerTestPageWidget(),
          compassBaseRoutes: [],
        );

  @override
  LedgerRouteData createData() {
    return const LedgerRouteData();
  }
}

class LedgerRouteData implements CompassRouteData {
  const LedgerRouteData();
}
