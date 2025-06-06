import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/create_password/model/password_status.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen_wm.dart';
import 'package:app/feature/add_seed/create_password/view/create_seed_password_view.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template create_seed_password_onboarding_page}
/// Entry point to create seed password from onboarding.
/// {@endtemplate}
class CreateSeedPasswordScreen
    extends ElementaryWidget<CreateSeedPasswordScreenWidgetModel> {
  const CreateSeedPasswordScreen({
    required this.phrase,
    required this.mnemonicType,
    Key? key,
    WidgetModelFactory wmFactory =
        defaultCreateSeedPasswordScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final SeedPhraseModel? phrase;
  final MnemonicType? mnemonicType;

  @override
  Widget build(CreateSeedPasswordScreenWidgetModel wm) {
    return GestureDetector(
      onTap: resetFocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: wm.themeStyle.colors.background0,
        appBar: DefaultAppBar(
          onClosePressed: (_) => wm.pop(),
        ),
        body: DoubleSourceBuilder<bool, PasswordStatus>(
          firstSource: wm.loadState,
          secondSource: wm.passwordStatusState,
          builder: (_, isLoading, passwordStatus) {
            return CreateSeedPasswordView(
              needBiometryIfPossible: true,
              passwordController: wm.passwordController,
              confirmController: wm.confirmController,
              onPressedNext: wm.onPressedNext,
              isLoading: isLoading ?? false,
              passwordStatus: passwordStatus,
            );
          },
        ),
      ),
    );
  }
}
