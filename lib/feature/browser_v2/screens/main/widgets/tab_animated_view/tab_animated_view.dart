import 'dart:io';

import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animated_view_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TabAnimatedView extends ElementaryWidget<TabAnimatedViewWidgetModel> {
  const TabAnimatedView({
    required this.showAnimationState,
    required this.onAnimationStart,
    required this.onAnimationEnd,
    WidgetModelFactory<TabAnimatedViewWidgetModel> wmFactory =
        defaultTabAnimatedViewWidgetModelFactory,
    super.key,
  }) : super(wmFactory);

  final ListenableState<TabAnimationType?> showAnimationState;

  final VoidCallback onAnimationStart;
  final VoidCallback onAnimationEnd;

  @override
  Widget build(TabAnimatedViewWidgetModel wm) {
    return StateNotifierBuilder<TabAnimationType?>(
      listenableState: showAnimationState,
      builder: (_, TabAnimationType? type) {
        return Visibility(
          visible: switch (type) {
            ShowViewAnimationType() || ShowTabsAnimationType() => true,
            _ => false,
          },
          child: AnimatedBuilder(
            animation: wm.animationListenable,
            builder: (_, Widget? child) {
              return Stack(
                children: [
                  Positioned(
                    top: wm.topPositionAnimation?.value ?? 0,
                    left: wm.leftPositionAnimation?.value ?? 0,
                    child: Opacity(
                      opacity: wm.opacityAnimation.value,
                      child: SizedBox(
                        width: wm.widthAnimation.value,
                        height: wm.heightAnimation.value,
                        child: child ?? const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ],
              );
            },
            child: StateNotifierBuilder<File?>(
              listenableState: wm.screenshotStateState,
              builder: (_, File? file) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(
                    wm.borderRadiusAnimation.value,
                  ),
                  child: file == null
                      ? const _StartPageAnimationView()
                      : Image.file(
                          file,
                          fit: BoxFit.fill,
                        ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _StartPageAnimationView extends StatelessWidget {
  const _StartPageAnimationView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.themeStyleV2.colors.background0,
        ),
        child: Transform.translate(
          offset: const Offset(0, -DimensSizeV2.d140),
          child: Assets.images.bgNetwork.image(
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
