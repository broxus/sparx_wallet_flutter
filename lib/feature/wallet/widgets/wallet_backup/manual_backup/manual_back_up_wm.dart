import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/wallet_backup.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/foundation.dart';
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
  final ValueChanged<bool> finishedBackupCallback;
}

@injectable
class ManualBackUpWidgetModel
    extends
        CustomWidgetModelParametrized<
          ContentManualBackup,
          ManualBackUpModel,
          ManualBackUpWmParams
        > {
  ManualBackUpWidgetModel(super.model);

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  late final screenState = createEntityNotifier<ManualBackUpData>()
    ..loading(ManualBackUpData(isCopied: false));

  late final ValueListenable<List<String>> wordsState =
      createWmParamsNotifier<List<String>>((it) => it.words);

  Future<void> copySeed() async {
    await setClipBoardData(wordsState.value.join(' '), isSensitive: true);
    model.showMessageAboutCopy();
  }

  void clickCheckPhrase(BuildContext context) {
    final currentWords = wordsState.value;

    showCheckPhraseDialog(
      context,
      currentWords,
      wmParams.value.address,
      wmParams.value.finishedBackupCallback,
    );
  }

  void clickSkip(BuildContext context) {
    // Don't hide backup banner when skipping manual backup - user should
    // verify seed phrase

    context.compassBack(); //close current dialog
  }
}
