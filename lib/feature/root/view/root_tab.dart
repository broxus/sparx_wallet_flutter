import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/browser_v2/route.dart';
import 'package:app/feature/profile/route.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

enum RootTab {
  wallet(),
  browser(),
  profile();

  const RootTab();

  IconData get icon => switch (this) {
        RootTab.wallet => LucideIcons.wallet,
        RootTab.browser => LucideIcons.compass,
        RootTab.profile => LucideIcons.circleUser,
      };

  String get title => switch (this) {
        RootTab.wallet => LocaleKeys.walletWord.tr(),
        RootTab.browser => LocaleKeys.browserWord.tr(),
        RootTab.profile => LocaleKeys.profileWord.tr(),
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
    };
  }

  static RootTab getByRoute(CompassBaseGoRoute<CompassRouteData>? route) {
    return switch (route) {
      WalletRoute() => RootTab.wallet,
      BrowserRoute() => RootTab.browser,
      ProfileRoute() => RootTab.profile,
      _ => RootTab.wallet,
    };
  }
}
