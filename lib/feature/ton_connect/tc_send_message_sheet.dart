import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<SignedMessage?> showTCSendMessageSheet({
  required BuildContext context,
  required TonAppConnection connection,
  required TransactionPayload payload,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.sendMessage.tr(),
    centerTitle: true,
    body: (_, scrollController) => TCSendMessageWidget(
      connection: connection,
      payload: payload,
      scrollController: scrollController,
    ),
  );
}
