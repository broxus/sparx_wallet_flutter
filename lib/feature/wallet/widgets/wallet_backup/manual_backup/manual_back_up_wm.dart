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
  final ValueChanged<bool> finishedBackupCallback;
}

@injectable
class ManualBackUpWidgetModel
    extends CustomWidgetModel<ContentManualBackup, ManualBackUpModel> {
  ManualBackUpWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final ManualBackUpWmParams _wmParams;

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  late final screenState = createEntityNotifier<ManualBackUpData>()
    ..loading(ManualBackUpData(isCopied: false));

  late final List<String> words = _wmParams.words;

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
      _wmParams.address,
      _wmParams.finishedBackupCallback,
    );
  }

  void clickSkip(BuildContext context) {
    // Don't hide backup banner when skipping manual backup - user should
    // verify seed phrase
    context.compassBack(); //close current dialog
  }
}
