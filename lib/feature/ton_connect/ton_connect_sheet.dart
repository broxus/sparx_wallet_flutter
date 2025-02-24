import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<List<ConnectItemReply>?> showTonConnectSheet({
  required BuildContext context,
  required ConnectRequest request,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.selectAccount.tr(),
    centerTitle: true,
    body: (_, scrollController) => TonConnectWidget(
      request: request,
      scrollController: scrollController,
    ),
  );
}
