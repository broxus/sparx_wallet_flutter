import 'package:app/feature/network/edit_network/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TokenListField extends StatelessWidget {
  const TokenListField({
    required this.isEditable,
    required this.controller,
    required this.validator,
    required this.errorText,
    required this.isLoading,
    required this.onTap,
    super.key,
  });

  final bool isEditable;
  final TextEditingController controller;
  final UrlTextValidator validator;
  final ListenableState<String> errorText;
  final ListenableState<bool> isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return NetworkFormField(
      label: LocaleKeys.networkTokenList.tr(),
      child: SeparatedColumn(
        children: [
          DoubleSourceBuilder(
            firstSource: errorText,
            secondSource: isLoading,
            builder: (_, errorText, isLoading) {
              return PrimaryTextField(
                textEditingController: controller,
                errorText: errorText,
                hintText: LocaleKeys.networkTokenListHint.tr(),
                isEnabled: isEditable,
                validator: validator.validate,
                suffixes: [
                  if (isLoading ?? false)
                    const Padding(
                      padding: EdgeInsets.only(right: DimensSizeV2.d20),
                      child: ProgressIndicatorWidget(size: DimensSizeV2.d16),
                    )
                  else
                    ClipboardPasteButton(
                      value: controller,
                      onClear: controller.clear,
                      onPaste: (String text) => controller.text = text,
                    ),
                ],
              );
            },
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: LocaleKeys.networkTokenListText.tr(),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                ),
                TextSpan(
                  text: LocaleKeys.networkTokenListTextLink.tr(),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content0,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
