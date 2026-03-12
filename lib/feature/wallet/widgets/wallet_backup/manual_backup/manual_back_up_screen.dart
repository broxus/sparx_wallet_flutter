import 'package:app/app/service/secure_string_service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/wallet_backup.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/seed_view_layout.dart';
import 'package:flutter/material.dart';

class ManualBackupScreen
    extends
        InjectedElementaryParametrizedWidget<
          ManualBackUpWidgetModel,
          ManualBackUpWmParams
        > {
  ManualBackupScreen({
    required SecureString seedPhrase,
    required String address,
    super.key,
  }) : super(
         wmFactoryParam: ManualBackUpWmParams(
           seedPhrase: seedPhrase,
           address: address,
         ),
       );

  @override
  Widget build(ManualBackUpWidgetModel wm) {
    return SeedViewLayout(
      title: LocaleKeys.manualBackupTitleDialog.tr(),
      description: LocaleKeys.manualBackupSubtitleDialog.tr(),
      wordsState: wm.wordsState,
      onPressSkip: wm.clickSkip,
      onPressCopy: wm.copySeed,
      onPressCheck: wm.clickCheckPhrase,
    );
  }
}
