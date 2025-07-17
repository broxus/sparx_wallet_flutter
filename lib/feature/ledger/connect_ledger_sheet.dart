import 'package:app/feature/ledger/ledger.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<bool?> showConnectLedgerSheet(BuildContext context) {
  return showCommonBottomSheet(
    context: context,
    body: (_, __) => const ConnectLedgerWidget(),
  );
}
