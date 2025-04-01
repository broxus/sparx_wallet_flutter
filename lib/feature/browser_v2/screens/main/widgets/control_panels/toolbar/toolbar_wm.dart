import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/toolbar/toolbar.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/toolbar/toolbar_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/browser_book.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/browser_main_menu/browser_main_menu.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';

/// Factory method for creating [ToolbarWidgetModel]
ToolbarWidgetModel defaultToolbarWidgetModelFactory(
  BuildContext context,
) {
  return ToolbarWidgetModel(
    ToolbarModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [Toolbar]
class ToolbarWidgetModel extends CustomWidgetModel<Toolbar, ToolbarModel> {
  ToolbarWidgetModel(
    super.model,
  );

  late final _backState = createNotifier(true);
  late final _forwardState = createNotifier(true);

  ListenableState<bool> get backState => _backState;

  ListenableState<bool> get forwardState => _forwardState;

  @override
  void initWidgetModel() {
    model.controlState.addListener(_handleControlData);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    model.controlState.removeListener(_handleControlData);
    super.dispose();
  }

  void onPressedBackPressed() {
    model.back();
  }

  void onPressedForwardPressed() {
    model.forward();
  }

  void onPressedDotsPressed() {
    showBrowserMainMenu(context);
  }

  void onPressedBook() {
    showBookModal(context);
  }

  void _handleControlData() {
    final data = model.controlState.value;

    if (data == null) {
      return;
    }

    _backState.accept(data.isCanGoBack);
    _forwardState.accept(data.isCanGoForward);
  }
}
