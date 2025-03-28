import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<(KeyAccount, List<ConnectItemReply>)?> showTCConnectSheet({
  required BuildContext context,
  required ConnectRequest request,
  required DappManifest manifest,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.selectAccount.tr(),
    centerTitle: true,
    body: (_, scrollController) => TCConnectWidget(
      request: request,
      manifest: manifest,
      scrollController: scrollController,
    ),
  );
}
