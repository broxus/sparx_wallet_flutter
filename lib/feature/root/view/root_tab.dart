import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser_v2/screens/main/route.dart';
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
  nft(),
  profile();

  const RootTab();

  IconData get icon => switch (this) {
        RootTab.wallet => LucideIcons.wallet,
        RootTab.browser => LucideIcons.compass,
        RootTab.profile => LucideIcons.circleUser,
        RootTab.nft => LucideIcons.image,
      };

  String get title => switch (this) {
        RootTab.wallet => LocaleKeys.walletWord.tr(),
        RootTab.browser => LocaleKeys.browserWord.tr(),
        RootTab.profile => LocaleKeys.profileWord.tr(),
        RootTab.nft => LocaleKeys.nftWord.tr(),
      };

  BottomNavigationBarItem item() => BottomNavigationBarItem(
        icon: Icon(icon, size: DimensSizeV2.d24),
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
