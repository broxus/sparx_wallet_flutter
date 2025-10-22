import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum LedgerInteractionStepState { initial, loading, success }

class LedgerInteractionStep {
  const LedgerInteractionStep({
    required this.title,
    this.state = LedgerInteractionStepState.initial,
  });

  final String title;
  final LedgerInteractionStepState state;
}

class LedgerStatusContainer extends StatelessWidget {
  const LedgerStatusContainer({required this.steps, super.key});

  final Iterable<LedgerInteractionStep> steps;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return ShapedContainerColumn(
      mainAxisSize: MainAxisSize.min,
      color: theme.colors.background2,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(DimensSizeV2.d16),
      children: [
        for (final step in steps)
          CommonListTile(
            padding: EdgeInsets.zero,
            height: DimensSizeV2.d40,
            leading: CommonBackgroundedIconWidget.icon(
              icon: switch (step.state) {
                LedgerInteractionStepState.initial => LucideIcons.arrowRight,
                LedgerInteractionStepState.loading => LucideIcons.loader,
                LedgerInteractionStepState.success => LucideIcons.check,
              },
              iconColor: switch (step.state) {
                LedgerInteractionStepState.success => theme.colors.positive,
                _ => theme.colors.content0,
              },
              backgroundColor: theme.colors.background3,
            ),
            titleChild: Text(
              step.title,
              style: theme.textStyles.button.copyWith(
                color: switch (step.state) {
                  LedgerInteractionStepState.success => theme.colors.positive,
                  _ => theme.colors.content0,
                },
              ),
            ),
          ),
      ],
    );
  }
}
