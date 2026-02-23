import 'package:app/generated/generated.dart';
import 'package:app/widgets/bottom_space.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EmptyTokensWidget extends StatelessWidget {
  const EmptyTokensWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: DimensSize.d20),
        Assets.images.searchX.svg(width: DimensSize.d56),
        const SizedBox(height: DimensSize.d12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: Text(
            LocaleKeys.emptyTokensDescriptionModal.tr(),
            style: theme.textStyles.paragraphSmall,
            textAlign: TextAlign.center,
          ),
        ),
        const BottomSpace(),
      ],
    );
  }
}
