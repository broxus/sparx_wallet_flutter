import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/widgets.dart';

Future<bool?> showDappDisconnectConfirmationSheet({
  required BuildContext context,
  TonAppConnection? connection,
}) => showConfirmationSheet(
  context: context,
  confirmationText: connection == null
      ? LocaleKeys.disconnectAllText.tr()
      : LocaleKeys.disconnectDappText.tr(),
  confirmButtonTitle: connection == null
      ? LocaleKeys.disconnectAll.tr()
      : LocaleKeys.disconnectDapp.tr(),
);
