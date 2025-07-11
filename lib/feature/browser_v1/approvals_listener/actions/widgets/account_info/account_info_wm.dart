import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/account_info/account_info_model.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/account_info/account_info_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

@injectable
class AccountInfoWidgetModel
    extends WidgetModel<AccountInfoWidget, AccountInfoModel> {
  AccountInfoWidgetModel(
    super.model,
    @factoryParam this._accountAddress,
  );

  final Address _accountAddress;

  late final account = model.getAccount(_accountAddress);

  Color get color => context.themeStyleV2.colors.background2;
}
