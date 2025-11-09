import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/approvals_listener/actions/sign_data/sign_data_model.dart';
import 'package:app/feature/browser_v2/approvals_listener/actions/sign_data/sign_data_widget.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

SignDataWidgetModel defaultSignDataWidgetModelFactory(BuildContext context) =>
    SignDataWidgetModel(
      SignDataModel(createPrimaryErrorHandler(context), inject()),
    );

class SignDataWidgetModel
    extends CustomWidgetModel<SignDataWidget, SignDataModel>
    with BleAvailabilityWmMixin {
  SignDataWidgetModel(super.model);

  Future<void> onConfirmed(SignInputAuth signInputAuth) async {
    if (signInputAuth.isLedger) {
      final isAvailable = await checkBluetoothAvailability();
      if (!isAvailable) return;
    }

    contextSafe?.let((context) => Navigator.of(context).pop(signInputAuth));
  }
}
