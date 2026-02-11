import 'package:app/generated/generated.dart';
import 'package:app/widgets/clipboard_paste_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class RecipientTextField extends StatelessWidget {
  const RecipientTextField({
    required this.receiverController,
    required this.receiverFocus,
    required this.inputFormatters,
    required this.validateAddressField,
    required this.onSubmittedReceiverAddress,
    required this.onPressedScan,
    required this.onPressedReceiverClear,
    required this.onPressedPasteAddress,
    super.key,
  });

  final TextEditingController receiverController;
  final FocusNode receiverFocus;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String? value) validateAddressField;
  final ValueChanged<String?> onSubmittedReceiverAddress;
  final VoidCallback onPressedScan;
  final VoidCallback onPressedReceiverClear;
  final ValueChanged<String> onPressedPasteAddress;

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      labelText: LocaleKeys.toInputLabel.tr(),
      hintText: LocaleKeys.receiverAddress.tr(),
      textEditingController: receiverController,
      focusNode: receiverFocus,
      onSubmit: onSubmittedReceiverAddress,
      inputFormatters: inputFormatters,
      validator: validateAddressField,
      suffixes: [
        _ScanQRButton(receiver: receiverController, onPressed: onPressedScan),
        ClipboardPasteButton(
          value: receiverController,
          onClear: onPressedReceiverClear,
          onPaste: onPressedPasteAddress,
        ),
      ],
    );
  }
}

class _ScanQRButton extends StatelessWidget {
  const _ScanQRButton({required this.receiver, required this.onPressed});

  final ValueNotifier<TextEditingValue> receiver;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: receiver,
      builder: (_, value, ___) => value.text.isEmpty
          ? Padding(
              padding: const EdgeInsets.only(right: DimensSize.d4),
              child: PrimaryButton(
                buttonShape: ButtonShape.square,
                buttonSize: ButtonSize.small,
                icon: LucideIcons.scan,
                onPressed: onPressed,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
