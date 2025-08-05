import 'package:app/feature/ledger/ledger.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show PublicKey;
import 'package:ui_components_lib/ui_components_lib.dart';

Future<PublicKey?> showImportLedgerSheet({
  required BuildContext context,
  String? name,
}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, __) => ImportLedgerWidget(name: name),
  );
}
