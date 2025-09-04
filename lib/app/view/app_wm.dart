import 'package:app/app/view/app.dart';
import 'package:app/app/view/app_model.dart';
import 'package:app/app/view/message_viewer.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] для [App]
@injectable
class AppWidgetModel extends CustomWidgetModel<App, AppModel> {
  AppWidgetModel(
    super.model,
  );

  late final _messageViewer = MessageViewer(
    messagesExistStream: model.messagesExistStream,
    getRootContext: () => model.navContext,
    getMessage: model.getMessage,
  );

  late final router = model.router;

  List<LocalizationsDelegate<dynamic>> get localizationDelegates =>
      context.localizationDelegates;

  List<Locale> get supportedLocales => context.supportedLocales;

  Locale get locale => context.locale;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _messageViewer.init();
  }

  @override
  void dispose() {
    _messageViewer.dispose();
    super.dispose();
  }

  Future<bool> checkCrashDetected() => model.checkCrashDetected();
}
