import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/rename_bookmark/browser_bookmark_rename_bottom_sheet.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/rename_bookmark/browser_bookmark_rename_bottom_sheet_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] для [BrowserBookmarkRenameBottomSheet]
@injectable
class BrowserBookmarkRenameBottomSheetWidgetModel
    extends
        CustomWidgetModelParametrized<
          BrowserBookmarkRenameBottomSheet,
          BrowserBookmarkRenameBottomSheetModel,
          BrowserBookmarkItem
        > {
  BrowserBookmarkRenameBottomSheetWidgetModel(super.model);

  late final nameController = createTextEditingController(wmParams.value.title);
  late final _isCanEditedState = createNotifier<bool>(false);

  ListenableState<bool> get isCanEditedState => _isCanEditedState;

  String get _name => nameController.text.trim();

  bool get _isNewName => _name != wmParams.value.title;

  bool get _isCanRename => _name.isNotEmpty && _isNewName;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    nameController.addListener(() => _isCanEditedState.accept(_isCanRename));
  }

  void onRename() {
    if (!_isCanRename) {
      return;
    }
    model.renameBookmark(wmParams.value.id, _name);
    Navigator.of(context).pop();
  }
}
