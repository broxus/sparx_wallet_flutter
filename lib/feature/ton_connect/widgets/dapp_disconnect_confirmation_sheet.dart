import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

// TODO(komarov): Common confirmation sheet?
Future<bool?> showDappDisconnectConfirmationSheet({
  required BuildContext context,
  TonAppConnection? connection,
}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, scrollController) => _DappDisconnectConfirmationSheet(
      scrollController: scrollController,
      connection: connection,
    ),
  );
}

class _DappDisconnectConfirmationSheet extends StatelessWidget {
  const _DappDisconnectConfirmationSheet({
    required this.scrollController,
    required this.connection,
  });

  final ScrollController scrollController;
  final TonAppConnection? connection;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: DimensSize.d24),
          Assets.images.exclamationMarkAlert.image(
            width: DimensSize.d56,
            height: DimensSize.d56,
          ),
          const SizedBox(height: DimensSize.d16),
          Text(
            connection == null
                ? LocaleKeys.disconnectAllText.tr()
                : LocaleKeys.disconnectDappText.tr(),
            style: theme.textStyles.headingLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DimensSize.d24),
          DestructiveButton(
            buttonShape: ButtonShape.pill,
            title: connection == null
                ? LocaleKeys.disconnectAll.tr()
                : LocaleKeys.disconnectDapp.tr(),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          const SizedBox(height: DimensSize.d8),
          PrimaryButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.backWord.tr(),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}
