import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

VerifyLedgerWidgetModel defaultVerifyLedgerWidgetModelFactory(
  BuildContext context,
) =>
    VerifyLedgerWidgetModel(
      VerifyLedgerModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
        inject(),
      ),
    );

class VerifyLedgerWidgetModel
    extends CustomWidgetModel<VerifyLedgerWidget, VerifyLedgerModel>
    with BleAvailabilityMixin {
  VerifyLedgerWidgetModel(super.model);

  late final _verifyState = createNotifier(false);
  late final _interactionState = createNotifierFromStream(
    model.interactionStream.switchMap((e) => e.stateStream),
  );

  ListenableState<bool> get isVerifying => _verifyState;

  ListenableState<LedgerInteractionState> get interactionState =>
      _interactionState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  void onCopy() {
    Clipboard.setData(
      ClipboardData(text: widget.account.address.address),
    );
    model.showMessage(
      Message.successful(
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [widget.account.address.toEllipseString()],
        ),
      ),
    );
  }

  Future<void> onVerify() async {
    final isAvailable = await checkBluetoothAvailability();
    if (!isAvailable) return;

    try {
      _verifyState.accept(true);

      await model.verify(widget.account);
    } catch (_) {
      _verifyState.accept(false);
    }
  }
}
