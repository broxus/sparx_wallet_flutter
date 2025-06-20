import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/data/tabs_data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/header/tab_list_header.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/header/tab_list_header_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] для [TabListHeader]
@injectable
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
