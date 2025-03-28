import 'dart:async';

import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet_backup/check_phrase/check_phrase_dialog.dart';
import 'package:app/feature/wallet/wallet_backup/good_job_back_up_dialog.dart';
import 'package:app/feature/wallet/wallet_backup/manual_backup/manual_back_up_data.dart';
import 'package:app/feature/wallet/wallet_backup/manual_backup/manual_back_up_dialog.dart';
import 'package:app/feature/wallet/wallet_backup/manual_backup/manual_back_up_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

ManualBackUpWidgetModel defaultManualBackUpWidgetModelFactory(
  BuildContext context,
) {
  return ManualBackUpWidgetModel(
    ManualBackUpModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      inject(),
    ),
  );
}

class ManualBackUpWidgetModel
    extends CustomWidgetModel<ContentManualBackup, ManualBackUpModel> {
  ManualBackUpWidgetModel(super.model);

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  late final screenState = createEntityNotifier<ManualBackUpData>()
    ..loading(ManualBackUpData(isCopied: false));

  late final List<String> words = widget.words;

  Future<void> copySeed() async {
    await Clipboard.setData(
      ClipboardData(text: words.join(' ')),
    );
    model.showMessageAboutCopy();
  }

  void clickCheckPhrase(BuildContext context) {
    showCheckPhraseDialog(
      context,
      words,
      widget.address,
      widget.finishedBackupCallback,
    );
  }

  void clickSkip(BuildContext context) {
    model.setShowingBackUpFlag(widget.address);
    widget.finishedBackupCallback();
    context.maybePop(); //close current dialog
    showGoodJobDialog(context);
  }
}
