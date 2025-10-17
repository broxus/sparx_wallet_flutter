import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser_v2/screens/main/route.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/profile/route.dart';
import 'package:app/feature/root/view/root_page.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class RootRoute extends CompassShellRoute {
  RootRoute(
    @Named.from(WalletRoute) CompassBaseRoute walletRoute,
    @Named.from(BrowserRoute) CompassBaseRoute browserRoute,
    @Named.from(ProfileRoute) CompassBaseRoute profileRoute,
    @Named.from(NftRoute) CompassBaseRoute nftRoute,
  ) : super(
        isTopLevel: true, // Mark as top-level route
        builder: (context, state, shell) => RootPage(child: shell),
        compassBaseRoutes: [walletRoute, browserRoute, profileRoute, nftRoute],
      );
}
