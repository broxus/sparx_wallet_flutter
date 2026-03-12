import 'package:app/app/service/secure_string_service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/check_phrase/backup_check_phrase_data.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/check_phrase/backup_check_phrase_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/check_seed_layout.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BackupCheckPhraseScreen
    extends
        InjectedElementaryParametrizedWidget<
          BackupCheckPhraseWidgetModel,
          BackupCheckPhraseWmParams
        > {
  BackupCheckPhraseScreen({
    required SecureString seedPhrase,
    required String address,
    super.key,
  }) : super(
         wmFactoryParam: BackupCheckPhraseWmParams(
           seedPhrase: seedPhrase,
           address: address,
         ),
       );

  @override
  Widget build(BackupCheckPhraseWidgetModel wm) {
    return Scaffold(
      backgroundColor: wm.colors.background0,
      appBar: DefaultAppBar(
        actions: [
          GhostButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.skip.tr(),
            onPressed: wm.clickSkip,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: EntityStateNotifierBuilder<BackupCheckPhraseData?>(
          listenableEntityState: wm.screenState,
          builder: (context, data) {
            if (data?.availableAnswers?.isNotEmpty ?? false) {
              return CheckSeedLayout(
                availableAnswers: data?.availableAnswers ?? [],
                userAnswers: data?.userAnswers ?? [],
                currentCheckIndex: data?.currentCheckIndex ?? 0,
                clearAnswer: wm.clearAnswer,
                answerQuestion: wm.answerQuestion,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
