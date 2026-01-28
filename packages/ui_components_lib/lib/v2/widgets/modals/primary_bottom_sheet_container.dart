import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class PrimaryBottomSheetContainer extends StatelessWidget {
  const PrimaryBottomSheetContainer({
    required this.child,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return PrimaryBottomSheetContainerBox(
      child: Column(
        children: [
          const PrimaryBottomSheetLabel(),
          Flexible(child: child),
        ],
      ),
    );
  }
}

class PrimaryBottomSheetContainerBox extends StatelessWidget {
  const PrimaryBottomSheetContainerBox({
    required this.child,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.background1,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(DimensRadius.radius16),
          topRight: Radius.circular(DimensRadius.radius16),
        ),
      ),
      child: child,
    );
  }
}

class PrimaryBottomSheetLabel extends StatelessWidget {
  const PrimaryBottomSheetLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return Padding(
      padding: const EdgeInsets.only(
        top: DimensSize.d6,
        bottom: DimensSize.d21,
      ),
      child: SizedBox(
        width: DimensSize.d36,
        height: DimensSize.d5,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensSize.d2),
            color: colors.primaryA.withValues(alpha: .7),
          ),
        ),
      ),
    );
  }
}
