import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class DestructiveButton extends BaseButton {
  const DestructiveButton({
    required super.buttonShape,
    super.onPressed,
    super.isLoading,
    super.title,
    super.child,
    super.icon,
    super.postfixIcon,
    super.buttonSize,
    super.key,
  });

  @override
  AppButtonStyle getStyle(ThemeStyleV2 theme) =>
      AppButtonStyle.destructive(theme.colors, theme.textStyles);
}
