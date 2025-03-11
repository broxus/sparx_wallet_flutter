import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/nav_panel/nav_panel.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/nav_panel/nav_panel_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';

/// Factory method for creating [BrowserTabViewMenuNavPanelWidgetModel]
BrowserTabViewMenuNavPanelWidgetModel
    defaultBrowserTabViewMenuNavPanelWidgetModelFactory(
  BuildContext context,
) {
  return BrowserTabViewMenuNavPanelWidgetModel(
    BrowserTabViewMenuNavPanelModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserTabViewMenuNavPanel]
class BrowserTabViewMenuNavPanelWidgetModel extends CustomWidgetModel<
    BrowserTabViewMenuNavPanel, BrowserTabViewMenuNavPanelModel> {
  BrowserTabViewMenuNavPanelWidgetModel(
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
    // TODO(knightforce): create logic
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
