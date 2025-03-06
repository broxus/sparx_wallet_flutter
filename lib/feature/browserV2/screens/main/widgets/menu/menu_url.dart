import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class MenuUrl extends StatelessWidget {
  const MenuUrl(
    this.activeTabState, {
    required this.onPressed,
    super.key,
  });

  final ListenableState<BrowserTab?> activeTabState;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.background1,
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(DimensSizeV2.d10),
              child: StateNotifierBuilder<BrowserTab?>(
                listenableState: activeTabState,
                builder: (_, BrowserTab? tab) {
                  return Text(
                    tab?.url.host ?? '',
                    style: theme.textStyles.labelMedium.copyWith(
                      letterSpacing: -0.1,
                      color: theme.colors.content3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
