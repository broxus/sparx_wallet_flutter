import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows sheet to sign data.
///
/// Returns [SignInputAuth] if user confirmed action
/// with password/ledger or null.
Future<SignInputAuth?> showSignDataSheet({
  required BuildContext context,
  required Uri origin,
  required Address account,
  required PublicKey publicKey,
  required String data,
  required SignInputAuthLedger signInputAuthLedger,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.signData.tr(),
    centerTitle: true,
    body: (_, controller) => _SignData(
      origin: origin,
      account: account,
      publicKey: publicKey,
      data: data,
      signInputAuthLedger: signInputAuthLedger,
      scrollController: controller,
    ),
  );
}

class _SignData extends StatelessWidget {
  const _SignData({
    required this.origin,
    required this.account,
    required this.publicKey,
    required this.data,
    required this.signInputAuthLedger,
    required this.scrollController,
  });

  final Uri origin;
  final Address account;
  final PublicKey publicKey;
  final String data;
  final SignInputAuthLedger signInputAuthLedger;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => SeparatedColumn(
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
            onConfirmed: (auth) => Navigator.of(context).pop(auth),
          ),
        ],
      );
}
