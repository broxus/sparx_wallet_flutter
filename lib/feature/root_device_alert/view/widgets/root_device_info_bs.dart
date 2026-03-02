import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

Future<void> showRootInfo(BuildContext context) {
  return showPrimaryBottomSheet(
    context: context,
    barrierColor: Colors.black.withValues(alpha: .8),
    content: const _Body(),
  );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Column(
      children: [
        const SizedBox(height: DimensSize.d24),
        Assets.images.exclamationMark.image(
          width: DimensSize.d56,
          height: DimensSize.d56,
        ),
        const SizedBox(height: DimensSize.d16),
        Text(
          LocaleKeys.rootInfoTitle.tr(),
          style: theme.textStyles.headingLarge.copyWith(letterSpacing: -.336),
        ),
        const SizedBox(height: DimensSize.d8),
        Text(
          LocaleKeys.rootInfoDescription.tr(),
          style: theme.textStyles.paragraphMedium.copyWith(letterSpacing: -.1),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSize.d24),
        PrimaryCard(
          color: context.themeStyleV2.colors.background2,
          padding: const EdgeInsets.all(DimensSize.d16),
          borderRadius: BorderRadius.circular(DimensRadius.radius12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.whatYouCanDoTitle.tr(),
                style: theme.textStyles.labelMedium.copyWith(
                  letterSpacing: -.096,
                ),
              ),
              const SizedBox(height: DimensSize.d10),
              _Item(LocaleKeys.whatYouCanDoDescription0.tr()),
              _Item(LocaleKeys.whatYouCanDoDescription1.tr()),
              _Item(LocaleKeys.whatYouCanDoDescription2.tr()),
            ],
          ),
        ),
        const SizedBox(height: DimensSize.d24),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.gotIt.tr(),
          postfixIcon: LucideIcons.check,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: DimensSize.d6,
            left: DimensSize.d10,
            right: DimensSize.d8,
          ),
          child: Icon(
            Icons.circle,
            color: ColorsResV2.white48,
            size: DimensSize.d8,
          ),
        ),
        Flexible(
          child: Text(
            text,
            style: theme.textStyles.labelMedium.copyWith(
              letterSpacing: -.096,
              color: ColorsResV2.white48,
            ),
          ),
        ),
      ],
    );
  }
}
