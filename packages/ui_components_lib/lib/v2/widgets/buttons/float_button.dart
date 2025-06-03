import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const defaultBackgroundBlur = 25.0;

class FloatButton extends BaseButton {
  const FloatButton({
    required super.buttonShape,
    super.onPressed,
    super.isLoading,
    super.title,
    super.child,
    super.icon,
    super.postfixIcon,
    super.buttonSize,
    super.key,
    super.isFullWidth,
    super.backgroundBlur = defaultBackgroundBlur,
  });

  @override
  AppButtonStyle getStyle(ThemeStyleV2 theme) =>
      AppButtonStyle.float(theme.colors, theme.textStyles);
}
