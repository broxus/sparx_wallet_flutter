import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NothingFound extends StatelessWidget {
  const NothingFound({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonIconWidget.svg(
          svg: Assets.images.searchEmpty.path,
          width: DimensSizeV2.d56,
          height: DimensSize.d56,
        ),
        const SizedBox(height: DimensSizeV2.d12),
        Text(
          LocaleKeys.nothingFound.tr(),
          style: theme.textStyles.paragraphSmall.copyWith(
            color: theme.colors.content3,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
