import 'package:app/feature/network/bottom_sheets/select_workchain/select_workchain_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [SelectWorkchainWidget].
Future<void> showSelectWorkchainSheet({required BuildContext context}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.selectWorkchain.tr(),
    centerTitle: true,
    body: (_, __) => const SelectWorkchainWidget(),
  );
}
