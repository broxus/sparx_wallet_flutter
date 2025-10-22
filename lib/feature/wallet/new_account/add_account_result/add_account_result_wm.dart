import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_model.dart';
import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_widget.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddAccountResultWmParams {
  AddAccountResultWmParams({required this.address, required this.isExternal});

  final Address address;
  final bool isExternal;
}

@injectable
class AddAccountResultWidgetModel
    extends
        CustomWidgetModelParametrized<
          AddAccountResultWidget,
          AddAccountResultModel,
          AddAccountResultWmParams
        > {
  AddAccountResultWidgetModel(super.model);

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onSwitch() async {
    final address = repackAddress(wmParams.value.address);
    model.changeCurrentAccount(address);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    if (wmParams.value.isExternal) {
      contextSafe?.compassPointNamed(const WalletRouteData());
    }
  }

  void onContinue() {
    Navigator.of(context).pop();
    if (wmParams.value.isExternal) {
      contextSafe?.compassPointNamed(const WalletRouteData());
    }
  }
}
