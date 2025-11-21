import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:app/feature/browser/screens/main/widgets/control_panels/navigation_panel/address_bar/address_bar_wm.dart';
import 'package:app/feature/browser/screens/main/widgets/past_go.dart';
import 'package:app/feature/browser/widgets/tips_bar/tips_bar.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserAddressBar
    extends InjectedElementaryWidget<BrowserAddressBarWidgetModel> {
  const BrowserAddressBar({
    required this.listenable,
    required this.viewVisibleState,
    required this.width,
    required this.onPressedCurrentUrlMenu,
    required this.onPressedRefresh,
    required this.onEditingComplete,
    super.key,
  });

  final NotNullListenableState<BrowserTab> listenable;
  final ListenableState<bool> viewVisibleState;
  final double width;
  final ValueChanged<String> onPressedCurrentUrlMenu;
  final ValueChanged<String> onPressedRefresh;
  final DoubleValueCallback<String, String> onEditingComplete;

  @override
  Widget build(BrowserAddressBarWidgetModel wm) {
    return GestureDetector(
      onTap: wm.onPressedBackground,
      child: SizedBox(
        width: width,
        height: DimensSizeV2.d40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d4),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: wm.theme.colors.backgroundInput,
              borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
            ),
            child: CompositedTransformTarget(
              link: wm.link,
              child: OverlayPortal(
                controller: wm.tipsOverlayController,
                overlayChildBuilder: (_) => CompositedTransformFollower(
                  targetAnchor: Alignment.topCenter,
                  followerAnchor: Alignment.bottomCenter,
                  link: wm.link,
                  child: StateNotifierBuilder(
                    listenableState: wm.tipsState,
                    builder: (_, TipType? type) {
                      return switch (type) {
                        TipType.pastGo => PastGoView(
                          onPressed: wm.onPastGoPressed,
                        ),
                        TipType.pages => TipsBar(
                          textNotifier: wm.textNotifier,
                          onPressedItem: wm.onPressedTip,
                        ),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),
                ),

                child: Stack(
                  children: [
                    StateNotifierBuilder<bool>(
                      listenableState: wm.urlVisibleTextState,
                      builder: (_, bool? isVisibleText) {
                        return Visibility(
                          visible: isVisibleText ?? false,
                          child: _UrlText(
                            listenable: listenable,
                            onPressedMenu: wm.onPressedMenu,
                            onPressedText: wm.onPressedText,
                            onPressedRefresh: wm.onPressedRefresh,
                          ),
                        );
                      },
                    ),
                    StateNotifierBuilder<bool>(
                      listenableState: wm.urlVisibleTextState,
                      builder: (_, bool? isVisibleText) {
                        return Visibility(
                          visible: !(isVisibleText ?? false),
                          child: _UrlTextField(
                            controller: wm.controller,
                            focusNode: wm.focusNode,
                            closeVisibleState: wm.closeVisibleState,
                            onPressedClear: wm.onPressedClear,
                            onEditingComplete: wm.onEditingComplete,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.onPressed, required this.icon});

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d12),
        child: Icon(icon, color: colors.content3, size: DimensSizeV2.d16),
      ),
    );
  }
}

class _UrlTextField extends StatelessWidget {
  const _UrlTextField({
    required this.controller,
    required this.focusNode,
    required this.closeVisibleState,
    required this.onPressedClear,
    required this.onEditingComplete,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ListenableState<bool> closeVisibleState;
  final VoidCallback onPressedClear;
  final VoidCallback onEditingComplete;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            autocorrect: false,
            enableSuggestions: false,
            style: theme.textStyles.paragraphXMedium.copyWith(
              color: ColorsResV2.black,
            ),
            cursorColor: ColorsResV2.black,
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d14,
              ),
            ),
            onEditingComplete: onEditingComplete,
          ),
        ),
        StateNotifierBuilder(
          listenableState: closeVisibleState,
          builder: (_, bool? isVisible) {
            isVisible ??= true;
            return AnimatedOpacity(
              opacity: isVisible ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: IgnorePointer(
                ignoring: !isVisible,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onPressedClear,
                  child: Padding(
                    padding: const EdgeInsets.only(right: DimensSizeV2.d12),
                    child: Assets.images.clear.svg(
                      width: DimensSizeV2.d20,
                      height: DimensSizeV2.d20,
                      colorFilter:
                          context.themeStyleV2.colors.content3.colorFilter,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _UrlText extends StatelessWidget {
  const _UrlText({
    required this.listenable,
    required this.onPressedMenu,
    required this.onPressedText,
    required this.onPressedRefresh,
  });

  final NotNullListenableState<BrowserTab> listenable;
  final VoidCallback onPressedMenu;
  final VoidCallback onPressedText;
  final VoidCallback onPressedRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StateNotifierBuilder(
          listenableState: listenable,
          builder: (_, BrowserTab? tab) {
            if (tab?.url.host.isEmpty ?? true) {
              return const SizedBox.shrink();
            }

            return _Button(onPressed: onPressedMenu, icon: LucideIcons.menu);
          },
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onPressedText,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: DimensSizeV2.d4),
                  child: StateNotifierBuilder(
                    listenableState: listenable,
                    builder: (_, BrowserTab? tab) {
                      return tab?.url.host.isEmpty ?? true
                          ? Icon(
                              LucideIcons.search,
                              size: DimensSizeV2.d16,
                              color: theme.colors.content3,
                            )
                          : Assets.images.lockFill.svg(
                              width: DimensSizeV2.d16,
                              height: DimensSizeV2.d16,
                              colorFilter: context
                                  .themeStyleV2
                                  .colors
                                  .content3
                                  .colorFilter,
                            );
                    },
                  ),
                ),
                Flexible(
                  child: StateNotifierBuilder(
                    listenableState: listenable,
                    builder: (_, BrowserTab? tab) {
                      return Text(
                        tab?.url.host.isEmpty ?? true
                            ? LocaleKeys.browserSearchURL.tr()
                            : tab!.url.host,
                        style: theme.textStyles.labelMedium.copyWith(
                          color: theme.colors.content3,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        StateNotifierBuilder(
          listenableState: listenable,
          builder: (_, BrowserTab? tab) {
            if (tab?.url.host.isEmpty ?? true) {
              return const SizedBox.shrink();
            }

            return _Button(
              onPressed: onPressedRefresh,
              icon: LucideIcons.rotateCcw,
            );
          },
        ),
      ],
    );
  }
}
