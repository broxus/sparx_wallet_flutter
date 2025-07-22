import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/value_notifier_merge.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header/physic.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header/tab_list_header.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header/tab_list_header_model.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header/ui_models.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/browser_book.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

////// [WidgetModel] для [TabListHeader]
@injectable
class TabListHeaderWidgetModel extends InjectedWidgetModel<TabListHeader,
    TabListHeaderModel, ValueListenable<String?>> {
  TabListHeaderWidgetModel(
    super.model,
  );

  late final ValueListenable<String?> selectedGroupIdState =
      createWmParamsNotifier((it) => it).asMerged();

  final _bookmarksUiModel = TabListHeaderBookmarksUiModel();
  final _newGroupUiModel = TabListHeaderNewGroupUiModel();

  late final _uiState = createNotNullNotifier<List<TabListHeaderUiModel>>([]);
  late final scrollController = createScrollController();

  CenterSnapScrollPhysics? _physic;
  double? _itemWidth;

  ListenableState<List<TabListHeaderUiModel>> get uiState => _uiState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.groupsIdsState.addListener(_handleGroupsIds);
    selectedGroupIdState.addListener(_handleSelectedId);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToGroup());
  }

  @override
  void dispose() {
    model.groupsIdsState.removeListener(_handleGroupsIds);
    super.dispose();
  }

  CenterSnapScrollPhysics getPhysic(double itemWidth) {
    return _physic ??= CenterSnapScrollPhysics(itemWidth: itemWidth);
  }

  void onPressedBookmarks() => showBookModal(context);

  //ignore: use_setters_to_change_properties
  void updateItemWidth(double itemWidth) {
    _itemWidth = itemWidth;
  }

  void _handleGroupsIds() {
    final groupsIds = model.groupsIdsState.value;

    final result = <TabListHeaderUiModel>[_bookmarksUiModel];

    for (final id in groupsIds) {
      final listenable = model.getGroupListenable(id);
      if (listenable == null) {
        continue;
      }
      result.add(
        TabListHeaderGroupUiModel(listenable),
      );
    }

    _uiState.accept(result..add(_newGroupUiModel));
  }

  void _handleSelectedId() {
    _scrollToGroup();
  }

  void _scrollToGroup() {
    final selectedId = selectedGroupIdState.value;

    if (_itemWidth == null || selectedId == null) {
      return;
    }

    final index = _uiState.value.indexWhere(
      (item) => item is TabListHeaderGroupUiModel && item.id == selectedId,
    );

    if (index == -1 || !scrollController.hasClients) {
      return;
    }

    scrollController.animateTo(
      _itemWidth! * index - _itemWidth!,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}
