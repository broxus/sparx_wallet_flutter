import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/new_account/add_external_account/add_external_account.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddExternalAccountWidget
    extends InjectedElementaryWidget<AddExternalAccountWidgetModel> {
  const AddExternalAccountWidget({super.key});

  @override
  Widget build(AddExternalAccountWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.addExternalAccount.tr(),
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
                ClipboardPasteButton(
                  value: wm.addressController,
                  onClear: wm.addressController.clear,
                  onPaste: wm.onPaste,
                ),
              ],
              onSubmit: wm.onSubmit,
            ),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: wm.isLoadingState,
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
