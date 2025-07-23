import 'package:app/feature/ledger/ledger.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show PublicKey;
import 'package:ui_components_lib/ui_components_lib.dart';

Future<PublicKey?> showImportLedgerSheet(BuildContext context) {
  return showCommonBottomSheet(
    context: context,
    body: (_, __) => const ImportLedgerWidget(),
  );
}
