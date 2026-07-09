import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';

Future<bool?> showDeleteNetworkConfirmationSheet({
  required BuildContext context,
  required String networkName,
}) => showConfirmationSheet(
  context: context,
  confirmationText: LocaleKeys.networkDeleteTitle.tr(args: [networkName]),
  confirmButtonTitle: LocaleKeys.networkDelete.tr(),
  backButtonTitle: LocaleKeys.backToSettings.tr(),
);
