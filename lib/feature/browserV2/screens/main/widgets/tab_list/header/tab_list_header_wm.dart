import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_list/header/tab_list_header.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_list/header/tab_list_header_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [TabListHeaderWidgetModel]
TabListHeaderWidgetModel defaultTabListHeaderWidgetModelFactory(
  BuildContext context,
) {
  return TabListHeaderWidgetModel(
    TabListHeaderModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [TabListHeader]
class TabListHeaderWidgetModel
    extends CustomWidgetModel<TabListHeader, TabListHeaderModel> {
  TabListHeaderWidgetModel(
    super.model,
  );

  // TODO(knightforce): temp. Refacrtor in group task
  ListenableState<BrowserTabsCollection> get tabsState => model.tabsState;

  void onPressedBookmarks() {
    // TODO(knightforce): create logic
  }

  void onPressedCreateNewGroup() {
    // TODO(knightforce): create logic
  }
}
