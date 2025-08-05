import 'package:app/feature/browser_v1/browser.dart';
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
    body: (_, controller) => SignDataWidget(
      origin: origin,
      account: account,
      publicKey: publicKey,
      data: data,
      signInputAuthLedger: signInputAuthLedger,
      scrollController: controller,
    ),
  );
}
