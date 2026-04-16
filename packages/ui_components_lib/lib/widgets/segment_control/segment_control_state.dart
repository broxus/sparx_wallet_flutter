import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum SegmentControlState { normal, selected, disabled }

class SegmentControlStyle {
  SegmentControlStyle.normal(
    ColorsPalette colors,
    TextStyles textStyles,
    SegmentControlSize size,
  ) : backgroundColor = colors.background1,
      iconColor = colors.content1,
      titleTextStyle =
          (size == SegmentControlSize.large
                  ? textStyles.labelMedium
                  : textStyles.labelSmall)
              .copyWith(color: colors.content2),
      valueTextStyle =
          (size == SegmentControlSize.large
                  ? textStyles.paragraphMedium
                  : textStyles.paragraphSmall)
              .copyWith(color: colors.content2);

  SegmentControlStyle.selected(
    ColorsPalette colors,
    TextStyles textStyles,
    SegmentControlSize size,
  ) : backgroundColor = colors.background2,
      iconColor = colors.content0,
      titleTextStyle = size == SegmentControlSize.large
          ? textStyles.labelMedium
          : textStyles.labelSmall,
      valueTextStyle = size == SegmentControlSize.large
          ? textStyles.paragraphMedium
          : textStyles.paragraphSmall;

  SegmentControlStyle.disabled(
    ColorsPalette colors,
    TextStyles textStyles,
    SegmentControlSize size,
  ) : backgroundColor = ColorsRes.transparent,
      iconColor = colors.content1.withAlpha(Opac.opac50.toByteInt()),
      titleTextStyle =
          (size == SegmentControlSize.large
                  ? textStyles.labelMedium
                  : textStyles.labelSmall)
              .copyWith(
                color: colors.content2.withAlpha(Opac.opac50.toByteInt()),
              ),
      valueTextStyle =
          (size == SegmentControlSize.large
                  ? textStyles.paragraphMedium
                  : textStyles.paragraphSmall)
              .copyWith(
                color: colors.content2.withAlpha(Opac.opac50.toByteInt()),
              );

  final Color backgroundColor;
  final Color iconColor;
  final TextStyle titleTextStyle;
  final TextStyle valueTextStyle;
}
