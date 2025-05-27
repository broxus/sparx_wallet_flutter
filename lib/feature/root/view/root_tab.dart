import 'package:app/app/router/router.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum RootTab {
  wallet(AppRoute.wallet),
  browser(AppRoute.browser),
  profile(AppRoute.profile),
  nft(AppRoute.nft);

  const RootTab(this.route);

  final AppRoute route;

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

  static RootTab getByPath(String path) {
    return RootTab.values.firstWhere(
      (e) => e.route.path == path,
      orElse: () {
        Logger('RootTabs').warning('No route found for path: $path');

        return wallet;
      },
    );
  }
}
