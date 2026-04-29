import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class PasteButton extends StatelessWidget {
  const PasteButton({
    required this.value,
    required this.onClear,
    required this.onPaste,
    this.padding = const EdgeInsets.only(right: DimensSize.d8),
    this.buttonSize = ButtonSize.small,
    super.key,
  });

  final EdgeInsetsGeometry padding;
  final ButtonSize buttonSize;
  final ValueNotifier<TextEditingValue> value;
  final VoidCallback onClear;
  final VoidCallback onPaste;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ValueListenableBuilder(
        valueListenable: value,
        builder: (_, value, __) {
          final isEmpty = value.text.isEmpty;

          return PrimaryButton(
            icon: isEmpty ? LucideIcons.arrowDownToDot : LucideIcons.x,
            buttonShape: ButtonShape.square,
            buttonSize: buttonSize,
            onPressed: isEmpty ? onPaste : onClear,
          );
        },
      ),
    );
  }
}
