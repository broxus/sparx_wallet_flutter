import 'package:app/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ClipboardPasteButton extends StatelessWidget {
  const ClipboardPasteButton({
    required this.value,
    required this.onPaste,
    required this.onClear,
    this.padding = const EdgeInsets.only(right: DimensSize.d8),
    this.buttonSize = ButtonSize.small,
    super.key,
  });

  final EdgeInsetsGeometry padding;
  final ButtonSize buttonSize;
  final ValueNotifier<TextEditingValue> value;
  final ValueChanged<String> onPaste;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) => PasteButton(
    padding: padding,
    buttonSize: buttonSize,
    value: value,
    onClear: onClear,
    onPaste: () async {
      final text = await getClipBoardText();
      if (text != null) {
        onPaste(text);
      }
    },
  );
}
