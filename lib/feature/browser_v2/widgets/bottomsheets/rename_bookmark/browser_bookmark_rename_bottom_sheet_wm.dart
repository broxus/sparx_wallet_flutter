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
class BrowserBookmarkRenameBottomSheetWidgetModel extends CustomWidgetModel<
    BrowserBookmarkRenameBottomSheet, BrowserBookmarkRenameBottomSheetModel> {
  BrowserBookmarkRenameBottomSheetWidgetModel(
    super.model,
    @factoryParam this._item,
  );

  late final nameController = createTextEditingController(_item.title);
  late final _isCanEditedState = createNotifier<bool>(false);

  final BrowserBookmarkItem _item;

  ListenableState<bool> get isCanEditedState => _isCanEditedState;

  String get _name => nameController.text.trim();

  bool get _isNewName => _name != _item.title;

  bool get _isCanRename => _name.isNotEmpty && _isNewName;

  @override
  void initWidgetModel() {
    nameController.addListener(() => _isCanEditedState.accept(_isCanRename));
    super.initWidgetModel();
  }

  void onRename() {
    if (!_isCanRename) {
      return;
    }
    model.renameBookmark(_item.id, _name);
    Navigator.of(context).pop();
  }
}
