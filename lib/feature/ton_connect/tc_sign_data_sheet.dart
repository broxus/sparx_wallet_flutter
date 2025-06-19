import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<SignDataResult?> showTCSignDataSheet({
  required BuildContext context,
  required TonAppConnection connection,
  required SignDataPayload payload,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.signData.tr(),
    centerTitle: true,
    body: (_, scrollController) => TCSignDataWidget(
      connection: connection,
      payload: payload,
      scrollController: scrollController,
    ),
  );
}
