import 'package:app/app/service/service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/new_account/new_account_type/new_account_type_widget.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NewAccountScreen
    extends
        InjectedElementaryParametrizedWidget<
          NewAccountScreenWidgetModel,
          NewAccountScreenWmParams
        > {
  NewAccountScreen({String? publicKey, SecureString? password, super.key})
    : super(
        wmFactoryParam: NewAccountScreenWmParams(
          publicKey: publicKey,
          password: password,
        ),
      );

  @override
  Widget build(NewAccountScreenWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(titleText: LocaleKeys.newAccount.tr()),
      body: wm.isError
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              child: NewAccountTypeWidget(
                publicKey: PublicKey(publicKey: wm.publicKey!),
                password: wm.password,
              ),
            ),
    );
  }
}
