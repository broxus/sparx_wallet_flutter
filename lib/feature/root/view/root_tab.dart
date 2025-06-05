import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser_v2/route.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/feature/profile/route.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum RootTab {
  wallet(),
  browser(),
  profile(),
  nft();

  const RootTab();

  Object get icon => switch (this) {
        RootTab.wallet => LucideIcons.wallet,
        RootTab.browser => LucideIcons.compass,
        RootTab.profile => LucideIcons.circleUser,
        RootTab.nft => Assets.images.nftIcon.path,
      };

  String get title => switch (this) {
        RootTab.wallet => LocaleKeys.walletWord.tr(),
        RootTab.browser => LocaleKeys.browserWord.tr(),
        RootTab.profile => LocaleKeys.profileWord.tr(),
        RootTab.nft => LocaleKeys.nftWord.tr(),
      };

  BottomNavigationBarItem item() => BottomNavigationBarItem(
        icon: switch (icon) {
          final IconData icon => Icon(icon, size: DimensSizeV2.d24),
          final String assetName => Builder(
              builder: (context) {
                final theme = IconTheme.of(context);
                return SvgPicture.asset(
                  assetName,
                  colorFilter: theme.color?.colorFilter,
                  width: DimensSizeV2.d24,
                  height: DimensSizeV2.d24,
                );
              },
            ),
          _ => const SizedBox.shrink(),
        },
        label: title,
        tooltip: title,
      );

  CompassRouteData routeData() {
    return switch (this) {
      RootTab.wallet => const WalletRouteData(),
      RootTab.browser => const BrowserRouteData(),
      RootTab.profile => const ProfileRouteData(),
      RootTab.nft => const NftRouteData(),
    };
  }

  static RootTab getByRoute(CompassBaseGoRoute<CompassRouteData>? route) {
    return switch (route) {
      WalletRoute() => RootTab.wallet,
      BrowserRoute() => RootTab.browser,
      ProfileRoute() => RootTab.profile,
      NftRoute() => RootTab.nft,
      _ => RootTab.wallet,
    };
  }
}
