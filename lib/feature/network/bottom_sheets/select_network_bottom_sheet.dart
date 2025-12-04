import 'package:app/feature/network/bottom_sheets/select_network/select_network_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [SelectNetworkWidget].
/// Returns selected connection id or null if none selected.
Future<String?> showSelectNetworkSheet({
  required BuildContext context,
  bool showConfigureButton = true,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.selectNetwork.tr(),
    centerTitle: true,
    body: (_, __) =>
        SelectNetworkWidget(showConfigureButton: showConfigureButton),
  );
}
