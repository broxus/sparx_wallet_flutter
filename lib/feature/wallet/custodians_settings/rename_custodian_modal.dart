// ignore_for_file: inference_failure_on_function_return_type
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<String?> showRenameCustodianModal(BuildContext context) {
  return showCommonBottomSheet<String>(
    context: context,
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.enterNewName.tr(),
    body: (_, __) => const AccountRenameSheet(),
  );
}

class AccountRenameSheet extends StatefulWidget {
  const AccountRenameSheet({
    super.key,
  });

  @override
  State<AccountRenameSheet> createState() => _AccountRenameSheetState();
}

class _AccountRenameSheetState extends State<AccountRenameSheet> {
  final nameController = TextEditingController();

  String get value => nameController.text.trim();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSize.d16,
      children: [
        PrimaryTextField(
          maxLength: maxLengthForMainEntities,
          textEditingController: nameController,
          hintText: LocaleKeys.nameWord.tr(),
          onSubmit: _onSubmit,
        ),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.renameWord.tr(),
          onPressed: _onSubmit,
        ),
      ],
    );
  }

  void _onSubmit([String? _]) => Navigator.of(context).pop(value);
}
