import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class EndpointItem extends StatelessWidget {
  const EndpointItem({
    required this.editable,
    required this.index,
    required this.controller,
    required this.validator,
    required this.onRemove,
    super.key,
  });

  final bool editable;
  final int index;
  final TextEditingController controller;
  final UrlTextValidator validator;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      textEditingController: controller,
      hintText: index == 0
          ? LocaleKeys.networkEndpointHint.tr()
          : LocaleKeys.networkAdditionalEndpointHint.tr(),
      isEnabled: editable,
      validator: validator.validate,
      suffixes: [
        ClipboardPasteButton(
          value: controller,
          onClear: controller.clear,
          onPaste: (String text) => controller.text = text,
        ),
        if (index > 0 && editable)
          Padding(
            padding: const EdgeInsets.only(right: DimensSizeV2.d8),
            child: PrimaryButton(
              buttonShape: ButtonShape.square,
              buttonSize: ButtonSize.small,
              icon: LucideIcons.trash,
              onPressed: onRemove,
            ),
          ),
      ],
    );
  }
}
