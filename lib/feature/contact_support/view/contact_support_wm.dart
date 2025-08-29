import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/contact_support/data/contact_support_mode.dart';
import 'package:app/feature/contact_support/view/contact_support_model.dart';
import 'package:app/feature/contact_support/view/contact_support_sheet.dart';
import 'package:app/feature/qa/qa.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ContactSupportWidgetModel extends CustomWidgetModelParametrized<
    ContactSupportSheet, ContactSupportModel, ContactSupportMode> {
  ContactSupportWidgetModel(super.model);

  late final _busyState = createNotifier(false);

  ListenableState<bool> get busyState => _busyState;

  bool get isQaEnabled => model.isQaEnabled;

  ContactSupportMode get mode => wmParams.value;

  Future<void> onSendEmail() async {
    _busyState.accept(true);
    try {
      await model.sendEmail(mode);
    } finally {
      _busyState.accept(false);
    }
    if (contextSafe != null) {
      Navigator.of(contextSafe!).pop();
    }
  }

  Future<void> onOpenQa() async {
    await showQaSheet(context: context);
  }
}
