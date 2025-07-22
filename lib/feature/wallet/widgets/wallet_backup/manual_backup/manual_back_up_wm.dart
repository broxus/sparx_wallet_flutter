import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/wallet_backup.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ManualBackUpWmParams {
  ManualBackUpWmParams({
    required this.words,
    required this.address,
    required this.finishedBackupCallback,
  });

  final List<String> words;
  final String address;
  final VoidCallback finishedBackupCallback;
}

@injectable
class ManualBackUpWidgetModel extends InjectedWidgetModel<ContentManualBackup,
    ManualBackUpModel, ManualBackUpWmParams> {
  ManualBackUpWidgetModel(
    super.model,
  );

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  late final screenState = createEntityNotifier<ManualBackUpData>()
    ..loading(ManualBackUpData(isCopied: false));

  late final words = createWmParamsNotifier<List<String>>(
    (it) => it.words,
  );

  Future<void> copySeed() async {
    await Clipboard.setData(
      ClipboardData(text: words.value.join(' ')),
    );
    model.showMessageAboutCopy();
  }

  void clickCheckPhrase(BuildContext context) {
    final currentWords = words.value;

    showCheckPhraseDialog(
      context,
      currentWords,
      wmParams.value.address,
      wmParams.value.finishedBackupCallback,
    );
  }

  void clickSkip(BuildContext context) {
    final params = wmParams.value;
    model.setShowingBackUpFlag(params.address);
    params.finishedBackupCallback();
    context.compassBack(); //close current dialog
    showGoodJobDialog(context);
  }
}
