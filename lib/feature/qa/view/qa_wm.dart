import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/qa/view/qa_model.dart';
import 'package:app/feature/qa/view/qa_page.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

@injectable
class QaWidgetModel extends CustomWidgetModel<QaSheet, QaModel> {
  QaWidgetModel(super.model);

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
    model.showSuccessMessage('Db dropped');
  }

  Future<void> clearEncryptedKeys() async {
    await model.clearEncryptedKeys();
    model.showSuccessMessage('Keys dropped');
  }
}
