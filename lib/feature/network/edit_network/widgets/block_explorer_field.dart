import 'package:app/feature/network/edit_network/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

class BlockExplorerField extends StatelessWidget {
  const BlockExplorerField({
    required this.validator,
    required this.isEditable,
    required this.controller,
    super.key,
  });

  final UrlTextValidator validator;
  final bool isEditable;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return NetworkFormField(
      label: LocaleKeys.networkBlockExplorer.tr(),
      child: PrimaryTextField(
        textEditingController: controller,
        hintText: LocaleKeys.networkBlockExplorerHint.tr(),
        isEnabled: isEditable,
        validator: validator.validate,
        suffixes: [
          ClipboardPasteButton(
            value: controller,
            onClear: controller.clear,
            onPaste: (String text) => controller.text = text,
          ),
        ],
      ),
    );
  }
}
