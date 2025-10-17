import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<void> showTCManageDappsSheet(BuildContext context) {
  return showCommonBottomSheet(
    context: context,
    body: (_, scrollController) =>
        TCManageDappsWidget(scrollController: scrollController),
  );
}
