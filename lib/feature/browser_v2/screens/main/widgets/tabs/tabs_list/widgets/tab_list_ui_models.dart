sealed class TabListHeaderUiModel {}

class TabListHeaderBookmarksUiModel extends TabListHeaderUiModel {}

class TabListHeaderNewGroupUiModel extends TabListHeaderUiModel {}

class TabListHeaderGroupUiModel extends TabListHeaderUiModel {
  TabListHeaderGroupUiModel({
    required this.id,
    required this.tabsCountText,
    required this.isSelected,
    this.title,
  });

  final String id;
  final String? title;
  final String tabsCountText;
  final bool isSelected;
}
