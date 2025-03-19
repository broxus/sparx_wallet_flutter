import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class PrimaryBottomSheetContainer extends StatelessWidget {
  const PrimaryBottomSheetContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background1,
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      ),
      child: Column(
        children: [
          const _Label(),
          Flexible(
            child: child,
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label();

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return Padding(
      padding: const EdgeInsets.only(
        top: DimensSizeV2.d6,
        bottom: DimensSizeV2.d21,
      ),
      child: SizedBox(
        width: DimensSizeV2.d36,
        height: DimensSizeV2.d5,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensSizeV2.d2),
            color: colors.primaryA.withOpacity(.7),
          ),
        ),
      ),
    );
  }
}
