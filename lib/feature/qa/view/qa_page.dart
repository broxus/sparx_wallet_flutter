import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/qa/view/qa_wm.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/buttons/accent_button.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';

Future<void> showQaSheet({required BuildContext context}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, __) => const QaSheet(),
  );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.subtitle, required this.value});

  final String subtitle;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$subtitle:',
          maxLines: 1,
          style: theme.textStyles.labelSmall.copyWith(
            color: theme.colors.content1,
          ),
        ),
        const SizedBox(height: DimensSizeV2.d4),
        Text(value, style: theme.textStyles.labelMedium, maxLines: 1),
      ],
    );
  }
}

class QaSheet extends InjectedElementaryWidget<QaWidgetModel> {
  const QaSheet({super.key});

  @override
  Widget build(QaWidgetModel wm) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DimensSizeV2.d20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DimensSizeV2.d8,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'QA functions',
                style: wm.theme.textStyles.headingLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: DimensSizeV2.d24),
            StateNotifierBuilder<String>(
              listenableState: wm.keyState,
              builder: (context, keyValue) {
                return _InfoRow(subtitle: 'Key', value: keyValue ?? 'Not set');
              },
            ),
            StateNotifierBuilder<String>(
              listenableState: wm.ivState,
              builder: (context, ivValue) {
                return _InfoRow(subtitle: 'IV', value: ivValue ?? 'Not set');
              },
            ),
            const SizedBox(height: DimensSizeV2.d8),
            AccentButton(
              buttonShape: ButtonShape.pill,
              title: 'Drop DB',
              onPressed: wm.clearEncryptedDb,
            ),
            AccentButton(
              buttonShape: ButtonShape.pill,
              title: 'Drop Keys',
              onPressed: wm.clearEncryptedKeys,
            ),
          ],
        ),
      ),
    );
  }
}
