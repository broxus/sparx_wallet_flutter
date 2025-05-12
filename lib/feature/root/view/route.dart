import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser/route.dart';
import 'package:app/feature/profile/route.dart';
import 'package:app/feature/root/view/root_page.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:injectable/injectable.dart';

@singleton
class RootRoute extends CompassShellRoute {
  RootRoute({
    required this.walletRoute,
    required this.browserRoute,
    required this.profileRoute,
  }) : super(
          isTopLevel: true, // Mark as top-level route
          builder: (context, state, shell) => RootPage(
            child: shell,
          ),
          compassBaseRoutes: [
            walletRoute,
            browserRoute,
            profileRoute,
          ],
        );

  final WalletRoute walletRoute;
  final BrowserRoute browserRoute;
  final ProfileRoute profileRoute;
}
