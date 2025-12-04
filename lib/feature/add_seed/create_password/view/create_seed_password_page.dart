import 'package:app/app/service/service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/create_password/view/create_seed_password_profile_wm.dart';
import 'package:app/feature/add_seed/create_password/view/create_seed_password_view.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Entry point to create/import seed password from profile (Elementary implementation).
class CreateSeedPasswordProfilePage
    extends
        InjectedElementaryParametrizedWidget<
          CreateSeedPasswordProfileWidgetModel,
          CreateSeedPasswordProfileWmParams
        > {
  CreateSeedPasswordProfilePage({
    required SecureString? seedPhrase,
    required String? name,
    required SeedAddType type,
    required MnemonicType? mnemonicType,
    required bool isChecked,
    super.key,
  }) : super(
         wmFactoryParam: CreateSeedPasswordProfileWmParams(
           seedPhrase: seedPhrase,
           name: name,
           type: type,
           mnemonicType: mnemonicType,
           isChecked: isChecked,
         ),
       );

  @override
  Widget build(CreateSeedPasswordProfileWidgetModel wm) {
    return GestureDetector(
      onTap: resetFocus,
      child: CustomMediaQuery(
        viewInsetsBottomAddon: -DimensSize.d16,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const DefaultAppBar(),
          body: DoubleSourceBuilder(
            firstSource: wm.loadingState,
            secondSource: wm.passwordStatusState,
            builder: (_, isLoading, passwordStatus) => CreateSeedPasswordView(
              needBiometryIfPossible: false,
              passwordController: wm.passwordController,
              confirmController: wm.confirmController,
              onPressedNext: wm.onPressedNext,
              passwordStatus: passwordStatus,
              isLoading: isLoading ?? false,
            ),
          ),
        ),
      ),
    );
  }
}
