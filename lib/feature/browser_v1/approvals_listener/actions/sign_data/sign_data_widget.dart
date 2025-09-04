import 'package:app/feature/browser_v1/browser.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SignDataWidget extends ElementaryWidget<SignDataWidgetModel> {
  const SignDataWidget({
    required this.origin,
    required this.account,
    required this.publicKey,
    required this.data,
    required this.signInputAuthLedger,
    required this.scrollController,
    Key? key,
    WidgetModelFactory wmFactory = defaultSignDataWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Uri origin;
  final Address account;
  final PublicKey publicKey;
  final String data;
  final SignInputAuthLedger signInputAuthLedger;
  final ScrollController scrollController;

  @override
  Widget build(SignDataWidgetModel wm) {
    return SeparatedColumn(
      spacing: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: SeparatedColumn(
              spacing: DimensSizeV2.d12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AccountInfoWidget(account: account),
                WebsiteInfoWidget(uri: origin),
                DataCard(data: data),
              ],
            ),
          ),
        ),
        EnterPasswordWidget.auth(
          getLedgerAuthInput: () => signInputAuthLedger,
          publicKey: publicKey,
          title: LocaleKeys.sign.tr(),
          onConfirmed: wm.onConfirmed,
        ),
      ],
    );
  }
}
