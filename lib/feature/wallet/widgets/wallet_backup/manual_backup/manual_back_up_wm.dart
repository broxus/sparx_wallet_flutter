import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/secure_string_service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/check_phrase/route.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/wallet_backup.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ManualBackUpWmParams {
  ManualBackUpWmParams({required this.seedPhrase, required this.address});

  final SecureString seedPhrase;
  final String address;
}

@injectable
class ManualBackUpWidgetModel
    extends
        CustomWidgetModelParametrized<
          ManualBackupScreen,
          ManualBackUpModel,
          ManualBackUpWmParams
        > {
  ManualBackUpWidgetModel(super.model);

  late final screenState = createEntityNotifier<ManualBackUpData>()
    ..loading(ManualBackUpData(isCopied: false));

  late final _wordsState = createNotNullNotifier<List<String>>([]);

  ListenableState<List<String>> get wordsState => _wordsState;

  ColorsPaletteV2 get colors => _theme.colors;

  TextStylesV2 get textStyle => _theme.textStyles;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _initWords();
  }

  Future<void> copySeed() async {
    final phrase = _wordsState.value.join(' ');

    if (phrase.isEmpty) {
      return;
    }

    await setClipBoardData(phrase, isSensitive: true);
    model.showMessageAboutCopy();
  }

  Future<void> clickCheckPhrase() async {
    context.compassContinue(
      CheckPhraseRouteData(
        seedPhrase: wmParams.value.seedPhrase,
        address: wmParams.value.address,
      ),
    );
  }

  void clickSkip() {
    // Don't hide backup banner when skipping manual backup - user should
    // verify seed phrase

    context.compassBack();
  }

  Future<void> _initWords() async {
    _wordsState.accept(await model.getSeedWords(wmParams.value.seedPhrase));
  }
}
