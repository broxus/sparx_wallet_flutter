import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_main_menu/browser_main_menu.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/main_control_panel/main_control_panel.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/main_control_panel/main_control_panel_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';

/// Factory method for creating [BrowserMainControlPanelWidgetModel]
BrowserMainControlPanelWidgetModel
    defaultBrowserMainControlPanelWidgetModelFactory(
  BuildContext context,
) {
  return BrowserMainControlPanelWidgetModel(
    BrowserMainControlPanelModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserMainControlPanel]
class BrowserMainControlPanelWidgetModel extends CustomWidgetModel<
    BrowserMainControlPanel, BrowserMainControlPanelModel> {
  BrowserMainControlPanelWidgetModel(
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
    BrowserMainMenu.show(context);
  }

  void onPressedBook() {
    // TODO(knightforce): create logic
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
