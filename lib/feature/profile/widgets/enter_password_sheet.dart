import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows [EnterPasswordWidgetV2]
/// with [publicKey] and returns the entered password
/// or null if the user canceled the action.
Future<String?> showEnterPasswordSheet({
  required BuildContext context,
  required PublicKey publicKey,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.enterYourPassword.tr(),
    centerTitle: true,
    body: (_, __) => _EnterPassword(
      publicKey: publicKey,
    ),
  );
}

class _EnterPassword extends StatelessWidget {
  const _EnterPassword({
    required this.publicKey,
  });

  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) => EnterPasswordWidgetV2(
        publicKey: publicKey,
        title: LocaleKeys.confirm.tr(),
        onPasswordEntered: (String password) =>
            Navigator.of(context).pop(password),
      );
}
