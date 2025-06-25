import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class PrimaryButton extends BaseButton {
  const PrimaryButton({
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
      AppButtonStyle.primary(theme.colors, theme.textStyles);
}
