import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/widgets/switch_to_seed_sheet/switch_to_seed_model.dart';
import 'package:app/feature/profile/widgets/switch_to_seed_sheet/switch_to_seed_widget.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

@injectable
class SwitchToSeedWidgetModel extends CustomWidgetModelParametrized<
    SwitchToSeedWidget, SwitchToSeedModel, PublicKey> {
  SwitchToSeedWidgetModel(
    super.model,
  );

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onSwitch() async {
    await model.changeCurrentAccount(wmParams.value);

    contextSafe?.compassBack();
    unawaited(
      callWithDelay(
        () {
          contextSafe?.compassPointNamed(const WalletRouteData());
        },
        duration: const Duration(milliseconds: 10),
      ),
    );
  }

  void onContinue() {
    Navigator.of(context).pop();
  }
}
