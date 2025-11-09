import 'package:app/feature/browser_v2/approvals_listener/actions/send_message/send_message.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that allows show sheet to ask user password and initiator
/// publicKey to make [TonWallet.send] action.
Future<(PublicKey, SignInputAuth)?> showSendMessageSheet({
  required BuildContext context,
  required Uri origin,
  required Address sender,
  required Address recipient,
  required BigInt amount,
  required bool bounce,
  required FunctionCall? payload,
  required KnownPayload? knownPayload,
  List<IgnoreTransactionTreeSimulationError>? ignoredComputePhaseCodes,
  List<IgnoreTransactionTreeSimulationError>? ignoredActionPhaseCodes,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.sendMessage.tr(),
    centerTitle: true,
    body: (_, controller) => SendMessageWidget(
      origin: origin,
      sender: sender,
      recipient: recipient,
      amount: amount,
      bounce: bounce,
      payload: payload,
      knownPayload: knownPayload,
      ignoredComputePhaseCodes: ignoredComputePhaseCodes,
      ignoredActionPhaseCodes: ignoredActionPhaseCodes,
      scrollController: controller,
    ),
  );
}
