import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class LoaderScreenWidget extends StatelessWidget {
  const LoaderScreenWidget({
    required this.title,
    required this.canClose,
    super.key,
  });

  final String title;
  final bool canClose;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Scaffold(
      appBar: canClose ? const DefaultAppBar() : null,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRect(
              child: AspectRatio(
                aspectRatio: 1,
                child: RiveAnimation.asset(
                  Assets.animations.loader,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              title,
              style: theme.textStyles.paragraphLarge.copyWith(
                color: theme.colors.content1,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
