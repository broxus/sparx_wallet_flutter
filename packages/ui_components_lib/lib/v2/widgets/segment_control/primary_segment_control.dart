import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/segment_control/segment_control.dart';

//if you need to select segment, pass SegmentControlState.selected
//example state : user.id == client.id ? SegmentControlState.selected :
// SegmentControlState.normal
class PrimarySegmentControl<T> extends StatelessWidget {
  const PrimarySegmentControl({
    required this.state,
    required this.value,
    this.icon,
    this.postfixIcon,
    this.size = SegmentControlSize.large,
    this.title,
    this.titleSpan,
    this.customIconColor,
    super.key,
  }) : assert(
          title == null || titleSpan == null,
          'title and titleSpan cant be provided simultaneously',
        );

  final SegmentControlSize size;
  final SegmentControlState state;
  final IconData? icon;
  final IconData? postfixIcon;
  final String? title;
  final InlineSpan? titleSpan;
  final T value;
  final Color? customIconColor;

  double get _iconSize {
    switch (size) {
      case SegmentControlSize.large:
        return DimensSizeV2.d20;
      case SegmentControlSize.medium:
        return DimensSizeV2.d16;
      case SegmentControlSize.small:
        return DimensSizeV2.d16;
      case SegmentControlSize.xsmall:
        return DimensSizeV2.d16;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case SegmentControlSize.large:
        return const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d16,
          horizontal: DimensSizeV2.d32,
        );
      case SegmentControlSize.medium:
        return const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d16,
          horizontal: DimensSizeV2.d24,
        );
      case SegmentControlSize.small:
        return const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d16,
          horizontal: DimensSizeV2.d16,
        );
      case SegmentControlSize.xsmall:
        return const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d12,
          horizontal: DimensSizeV2.d12,
        );
    }
  }

  double get _borderRadius {
    switch (size) {
      case SegmentControlSize.large:
        return DimensRadiusV2.radius16;
      case SegmentControlSize.medium:
        return DimensRadiusV2.radius12;
      case SegmentControlSize.small:
      case SegmentControlSize.xsmall:
        return DimensRadiusV2.radius8;
    }
  }

  PrimarySegmentControl<T> copyWith({
    SegmentControlSize? size,
    SegmentControlState? state,
    IconData? icon,
    IconData? postfixIcon,
    String? title,
    InlineSpan? titleSpan,
    T? value,
    Color? customIconColor,
  }) {
    return PrimarySegmentControl<T>(
      size: size ?? this.size,
      state: state ?? this.state,
      icon: icon ?? this.icon,
      postfixIcon: postfixIcon ?? this.postfixIcon,
      title: title ?? this.title,
      titleSpan: titleSpan ?? this.titleSpan,
      value: value ?? this.value,
      customIconColor: customIconColor ?? this.customIconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;
    final style = _getSegmentStyle(themeStyle);
    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: style.backgroundColor,
      ),
      child: SeparatedRow(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: customIconColor ?? style.iconColor,
              size: _iconSize,
            ),
          if (title != null) Text(title!, style: style.titleTextStyle),
          if (titleSpan != null)
            Text.rich(titleSpan!, style: style.titleTextStyle),
          if (postfixIcon != null)
            Icon(
              postfixIcon,
              color: customIconColor ?? style.iconColor,
              size: _iconSize,
            ),
        ],
      ),
    );
  }

  SegmentControlStyle _getSegmentStyle(ThemeStyleV2 theme) {
    switch (state) {
      case SegmentControlState.normal:
        return SegmentControlStyle.normal(
          theme.colors,
          theme.textStyles,
          size,
        );
      case SegmentControlState.selected:
        return SegmentControlStyle.selected(
          theme.colors,
          theme.textStyles,
          size,
        );
      case SegmentControlState.disabled:
        return SegmentControlStyle.disabled(
          theme.colors,
          theme.textStyles,
          size,
        );
    }
  }
}
