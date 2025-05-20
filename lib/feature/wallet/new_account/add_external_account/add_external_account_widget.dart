import 'package:app/feature/wallet/new_account/add_external_account/add_external_account.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddExternalAccountWidget
    extends ElementaryWidget<AddExternalAccountWidgetModel> {
  const AddExternalAccountWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultAddExternalAccountWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(AddExternalAccountWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.addExternalAccount.tr(),
        onClosePressed: wm.onClose,
      ),
      body: Padding(
        padding: const EdgeInsets.all(DimensSizeV2.d16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.addExistingAccountDescription.tr(),
              style: wm.theme.textStyles.paragraphMedium,
            ),
            const SizedBox(height: DimensSizeV2.d24),
            PrimaryTextField(
              textEditingController: wm.nameController,
              hintText: LocaleKeys.nameWord.tr(),
              onSubmit: (_) => wm.focusNode.requestFocus(),
            ),
            const SizedBox(height: DimensSizeV2.d12),
            PrimaryTextField(
              textEditingController: wm.addressController,
              focusNode: wm.focusNode,
              hintText: LocaleKeys.addressWord.tr(),
              suffixes: [
                if (wm.addressController.text.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: DimensSizeV2.d8,
                    ),
                    child: FloatButton(
                      buttonShape: ButtonShape.square,
                      buttonSize: ButtonSize.small,
                      icon: LucideIcons.arrowDownToDot,
                      onPressed: wm.onPaste,
                    ),
                  ),
                if (wm.addressController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: DimensSizeV2.d8,
                    ),
                    child: FloatButton(
                      buttonShape: ButtonShape.square,
                      buttonSize: ButtonSize.small,
                      icon: LucideIcons.x,
                      onPressed: wm.addressController.clear,
                    ),
                  ),
              ],
              onSubmit: wm.onSubmit,
            ),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: wm.isLoading,
              builder: (_, isLoading, __) => AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.addAccount.tr(),
                isLoading: isLoading,
                onPressed: wm.onSubmit,
              ),
            ),
            const SizedBox(height: DimensSizeV2.d12),
          ],
        ),
      ),
    );
  }
}
