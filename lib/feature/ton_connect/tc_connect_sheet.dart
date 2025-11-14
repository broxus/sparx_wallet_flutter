import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<TonConnectUiEventResult<(KeyAccount, List<ConnectItemReply>)>>
showTCConnectSheet({
  required BuildContext context,
  required ConnectRequest request,
  required DappManifest manifest,
}) async {
  final result =
      await showCommonBottomSheet<
        TonConnectUiEventResult<(KeyAccount, List<ConnectItemReply>)>
      >(
        context: context,
        title: LocaleKeys.selectAccount.tr(),
        centerTitle: true,
        body: (_, scrollController) => TCConnectWidget(
          request: request,
          manifest: manifest,
          scrollController: scrollController,
        ),
      );

  return result ?? const TonConnectUiEventResult.canceled();
}
