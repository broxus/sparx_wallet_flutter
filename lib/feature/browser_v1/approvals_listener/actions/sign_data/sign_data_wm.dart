import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v1/browser.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

SignDataWidgetModel defaultSignDataWidgetModelFactory(
  BuildContext context,
) =>
    SignDataWidgetModel(
      SignDataModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class SignDataWidgetModel
    extends CustomWidgetModel<SignDataWidget, SignDataModel>
    with BleAvailabilityMixin {
  SignDataWidgetModel(super.model);

  Future<void> onConfirmed(SignInputAuth signInputAuth) async {
    if (signInputAuth.isLedger) {
      final isAvailable = await checkBluetoothAvailability();
      if (!isAvailable) return;
    }

    contextSafe?.let((context) => Navigator.of(context).pop(signInputAuth));
  }
}
