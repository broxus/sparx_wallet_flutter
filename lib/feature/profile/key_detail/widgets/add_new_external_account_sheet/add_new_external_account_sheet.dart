import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/key_detail/widgets/add_new_external_account_sheet/add_new_external_account_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper method to display [AddNewExternalAccountSheet].
Future<void> showAddNewExternalAccountSheet({
  required BuildContext context,
  required PublicKey publicKey,
}) =>
    showCommonBottomSheet(
      context: context,
      titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
      title: LocaleKeys.addExistingAccount.tr(),
      subtitle: LocaleKeys.addExistingAccountDescription.tr(),
      body: (_, scrollController) => AddNewExternalAccountSheet(
        publicKey: publicKey,
        controller: scrollController,
      ),
    );

/// Sheet that allows to add new external account.
class AddNewExternalAccountSheet
    extends InjectedElementaryWidget<AddNewExternalAccountSheetWidgetModel> {
  const AddNewExternalAccountSheet({
    required PublicKey publicKey,
    required this.controller,
    super.key,
  }) : super(
          wmFactoryParam: publicKey,
        );

  final ScrollController controller;

  @override
  Widget build(AddNewExternalAccountSheetWidgetModel wm) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: DimensSizeV2.d16,
        children: [
          PrimaryTextField(
            textEditingController: wm.nameController,
            hintText: LocaleKeys.nameWord.tr(),
            onSubmit: (_) => wm.focusNode.requestFocus(),
          ),
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
          ValueListenableBuilder(
            valueListenable: wm.isLoading,
            builder: (_, isLoading, __) => PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.confirm.tr(),
              isLoading: isLoading,
              onPressed: wm.onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
