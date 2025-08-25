import 'package:app/feature/network/edit_network/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class DecimalsField extends StatelessWidget {
  const DecimalsField({
    required this.isEditable,
    required this.controller,
    super.key,
  });

  final bool isEditable;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return NetworkFormField(
      label: LocaleKeys.networkCurrencyDecimals.tr(),
      child: PrimaryTextField(
        textEditingController: controller,
        hintText: LocaleKeys.networkCurrencyDecimalsHint.tr(),
        isEnabled: isEditable,
        keyboardType: TextInputType.number,
        inputFormatters: [
          InputFormatters.noSpacesFormatter,
          InputFormatters.onlyDigitsFormatter,
        ],
      ),
    );
  }
}
