import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/feature/profile/widgets/rename_sheet/rename_sheet.dart';
import 'package:app/feature/profile/widgets/rename_sheet/rename_sheet_model.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class RenameSheetWidgetModel
    extends
        CustomWidgetModelParametrized<
          RenameSheet,
          RenameSheetModel,
          RenameSheetParams
        > {
  RenameSheetWidgetModel(super.model);

  late final nameController = createTextEditingController(
    model.getName(
      publicKey: wmParams.value.publicKey,
      isSeed: wmParams.value.isSeed,
    ),
  );

  void rename([String? _]) {
    final name = nameController.text.trim();
    if (name.isEmpty) return;

    final params = wmParams.value;

    model
      ..rename(publicKey: params.publicKey, isSeed: params.isSeed, name: name)
      ..showMessage(
        Message.successful(
          message: params.isSeed
              ? LocaleKeys.valueRenamed.tr(args: [LocaleKeys.seedPhrase.tr()])
              : params.isCustodian
              ? LocaleKeys.custodianRenamed.tr()
              : LocaleKeys.valueRenamed.tr(args: [LocaleKeys.keyWord.tr()]),
        ),
      );

    Navigator.of(context).pop();
  }
}

class RenameSheetParams {
  const RenameSheetParams({
    required this.publicKey,
    required this.isSeed,
    required this.isCustodian,
  });

  final PublicKey publicKey;
  final bool isSeed;
  final bool isCustodian;
}
