import 'dart:io';

import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animated_view_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

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
                return file == null
                    ? Container(color: Colors.blue)
                    : Image.file(
                        file,
                        fit: BoxFit.fill,
                      );
              },
            ),
          ),
        );
      },
    );
  }
}
