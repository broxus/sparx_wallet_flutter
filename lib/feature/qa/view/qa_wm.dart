import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/qa/view/qa_model.dart';
import 'package:app/feature/qa/view/qa_page.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

QaWidgetModel defaultQaWidgetModelFactory(BuildContext context) {
  final model = QaModel(
    storage: inject<EncryptedStorage>(),
  );
  return QaWidgetModel(model, messengerService: inject());
}

class QaWidgetModel extends CustomWidgetModel<QaSheet, QaModel> {
  QaWidgetModel(
    super.model, {
    required MessengerService messengerService,
  }) : _messengerService = messengerService;

  final MessengerService _messengerService;

  late final _key = createNotifier('');
  late final _iv = createNotifier('');

  ThemeStyleV2 get theme => context.themeStyleV2;

  ListenableState<String> get iv => _iv;
  ListenableState<String> get key => _key;

  @override
  Future<void> initWidgetModel() async {
    _iv.accept(await model.readIv());
    _key.accept(await model.readKey());

    super.initWidgetModel();
  }

  Future<void> clearEncryptedDb() async {
    await model.clearEncryptedDb();
    _messengerService.show(
      Message.successful(message: 'Db dropped'),
    );
  }

  Future<void> clearEncryptedKeys() async {
    await model.clearEncryptedKeys();
    _messengerService.show(
      Message.successful(message: 'Keys dropped'),
    );
  }
}
