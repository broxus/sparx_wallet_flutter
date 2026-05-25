import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

ModalRoute<bool?> getConfirmationSheetRoute({
  required String confirmationText,
  required String confirmButtonTitle,
  String? backButtonTitle,
  String? title,
}) {
  return commonBottomSheetRoute(
    title: title,
    centerTitle: true,
    body: (_, scrollController) => _ConfirmationSheet(
      scrollController: scrollController,
      confirmationText: confirmationText,
      confirmButtonTitle: confirmButtonTitle,
      backButtonTitle: backButtonTitle,
    ),
  );
}

Future<bool?> showConfirmationSheet({
  required BuildContext context,
  required String confirmationText,
  required String confirmButtonTitle,
  String? backButtonTitle,
  String? title,
}) {
  return showCommonBottomSheet(
    context: context,
    title: title,
    centerTitle: true,
    body: (_, scrollController) => _ConfirmationSheet(
      scrollController: scrollController,
      confirmationText: confirmationText,
      confirmButtonTitle: confirmButtonTitle,
      backButtonTitle: backButtonTitle,
    ),
  );
}

class _ConfirmationSheet extends StatelessWidget {
  const _ConfirmationSheet({
    required this.scrollController,
    required this.confirmationText,
    required this.confirmButtonTitle,
    this.backButtonTitle,
  });

  final ScrollController scrollController;
  final String confirmationText;
  final String confirmButtonTitle;
  final String? backButtonTitle;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyle;

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: DimensSize.d24),
          ExcludeSemantics(
            child: Assets.images.exclamationMarkAlert.image(
              width: DimensSize.d56,
              height: DimensSize.d56,
            ),
          ),
          const SizedBox(height: DimensSize.d16),
          Text(
            confirmationText,
            style: theme.textStyles.headingLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DimensSize.d24),
          DestructiveButton(
            buttonShape: ButtonShape.pill,
            title: confirmButtonTitle,
            onPressed: () => Navigator.of(context).pop(true),
          ),
          const SizedBox(height: DimensSize.d8),
          PrimaryButton(
            buttonShape: ButtonShape.pill,
            title: backButtonTitle ?? LocaleKeys.backWord.tr(),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}
