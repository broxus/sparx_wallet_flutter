import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<bool?> showDeleteNetworkConfirmationSheet({
  required BuildContext context,
  required String networkName,
}) {
  return showCommonBottomSheet<bool?>(
    context: context,
    body: (_, __) => _DeleteNetworkConfirmation(networkName: networkName),
  );
}

class _DeleteNetworkConfirmation extends StatelessWidget {
  const _DeleteNetworkConfirmation({required this.networkName});

  final String networkName;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: DimensSize.d24),
        Image.asset(
          Assets.images.alertOctagonFill.alertOctagonFill.path,
          height: DimensSize.d56,
          width: DimensSize.d56,
        ),
        const SizedBox(height: DimensSize.d16),
        Text(
          LocaleKeys.networkDeleteTitle.tr(args: [networkName]),
          style: theme.textStyles.headingLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSize.d24),
        DestructiveButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.networkDelete.tr(),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        const SizedBox(height: DimensSize.d8),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.backToSettings.tr(),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }
}
