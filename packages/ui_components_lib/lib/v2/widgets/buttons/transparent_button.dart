import 'package:ui_components_lib/ui_components_lib.dart';

class TransparentButton extends BaseButton {
  const TransparentButton({
    required super.buttonShape,
    super.onPressed,
    super.isLoading,
    super.title,
    super.child,
    super.icon,
    super.postfixIcon,
    super.buttonSize,
    super.isFullWidth,
    super.padding,
    super.key,
  });

  @override
  AppButtonStyle getStyle(ThemeStyleV2 theme) =>
      AppButtonStyle.transparent(theme.colors, theme.textStyles);
}
