import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] для [BrowserTabsList]
@injectable
class BrowserTabsListWidgetModel
    extends CustomWidgetModel<BrowserTabsList, BrowserTabsListModel> {
  BrowserTabsListWidgetModel(
    super.model,
    @factoryParam this.selectedGroupIdState,
  );

  final ListenableState<String?> selectedGroupIdState;

  late final _selectedTabsState =
      createNotifier<List<NotNullListenableState<BrowserTab>>?>();

  ListenableState<List<NotNullListenableState<BrowserTab>>?>
      get selectedTabsState => _selectedTabsState;

  @override
  void initWidgetModel() {
    selectedGroupIdState.addListener(_handleSelectedGroup);
    model.allTabsIdsState.addListener(_handleAllTabs);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    selectedGroupIdState.removeListener(_handleSelectedGroup);
    model.allTabsIdsState.removeListener(_handleAllTabs);
    super.dispose();
  }

  void onCloseTab(String tabId) {
    final id = selectedGroupIdState.value;
    if (id == null) {
      return;
    }

    model.removeBrowserTab(
      groupId: id,
      tabId: tabId,
    );
  }

  void _handleSelectedGroup() {
    final groupId = selectedGroupIdState.value;

    if (groupId == null) {
      return;
    }

    _selectedTabsState.accept(model.getGroupTabs(groupId));
  }

  void _handleAllTabs() {
    Future(() {
      final groupId = selectedGroupIdState.value;

      if (groupId == null) {
        return;
      }

      final list = model.getTabIds(groupId);

      if (_selectedTabsState.value?.length == list?.length) {
        return;
      }

      _selectedTabsState.accept(model.getGroupTabs(groupId));
    });
  }
}
