import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';

sealed class TabListHeaderUiModel {}

class TabListHeaderBookmarksUiModel extends TabListHeaderUiModel {}

class TabListHeaderNewGroupUiModel extends TabListHeaderUiModel {}

class TabListHeaderGroupUiModel extends TabListHeaderUiModel {
  TabListHeaderGroupUiModel(this.listenable);

  final NotNullListenableState<BrowserGroup> listenable;

  String get id => listenable.value.id;
}
