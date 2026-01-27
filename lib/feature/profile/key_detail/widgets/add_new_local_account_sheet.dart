import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// This is a helper method to display AddNewLocalAccountSheet.
Future<void> showAddNewLocalAccountSheet({
  required BuildContext context,
  required PublicKey publicKey,
}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, scrollController) => AddNewLocalAccountSheet(
      publicKey: publicKey,
      controller: scrollController,
    ),
  );
}

/// Sheet widget that allows enter account name before its creating.
///
/// This sheet is used only to create account, to import external, use
/// [AddNewExternalAccountSheet].
class AddNewLocalAccountSheet extends StatefulWidget {
  const AddNewLocalAccountSheet({
    required this.publicKey,
    required this.controller,
    super.key,
  });

  final PublicKey publicKey;
  final ScrollController controller;

  @override
  State<AddNewLocalAccountSheet> createState() =>
      _AddNewLocalAccountSheetState();
}

class _AddNewLocalAccountSheetState extends State<AddNewLocalAccountSheet> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.newAccountName.tr(),
            style: context.themeStyleV2.textStyles.headingLarge,
          ),
          const SizedBox(height: DimensSize.d8),
          Text(
            LocaleKeys.newAccountNameDescription.tr(),
            style: context.themeStyleV2.textStyles.paragraphMedium.copyWith(
              color: context.themeStyleV2.colors.content1,
            ),
          ),
          const SizedBox(height: DimensSize.d24),
          PrimaryTextField(
            maxLength: maxLengthForMainEntities,
            hintText: LocaleKeys.nameWord.tr(),
            textEditingController: nameController,
            onSubmit: (_) => _goNext(context),
          ),
          const SizedBox(height: DimensSizeV2.d24),
          PrimaryButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.continueWord.tr(),
            onPressed: () => _goNext(context),
          ),
        ],
      ),
    );
  }

  void _goNext(BuildContext context) => Navigator.of(context)
    ..pop()
    ..push(
      showAddNewLocalAccountTypeSheet(
        context: context,
        name: nameController.text,
        publicKey: widget.publicKey,
      ),
    );
}
