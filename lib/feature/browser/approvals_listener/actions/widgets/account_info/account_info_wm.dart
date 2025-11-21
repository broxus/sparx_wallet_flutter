import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/account_info/account_info_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/account_info/account_info_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

@injectable
class AccountInfoWidgetModel
    extends
        CustomWidgetModelParametrized<
          AccountInfoWidget,
          AccountInfoModel,
          Address
        > {
  AccountInfoWidgetModel(super.model);

  late final ValueListenable<KeyAccount?> accountAddressState =
      createWmParamsNotifier((address) => model.getAccount(address));

  Color get color => context.themeStyleV2.colors.background2;
}
