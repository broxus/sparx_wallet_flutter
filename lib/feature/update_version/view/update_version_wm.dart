import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/update_version/data/update_request.dart';
import 'package:app/feature/update_version/view/update_version_model.dart';
import 'package:app/feature/update_version/view/update_version_screen.dart';
import 'package:app/utils/common_utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget model for the [UpdateVersionScreen]
@injectable
class UpdateVersionWidgetModel
    extends CustomWidgetModel<UpdateVersionScreen, UpdateVersionModel> {
  UpdateVersionWidgetModel(super.model);

  late final _updateRequestsState = createNotifierFromStream(
    model.updateRequests.whereNotNull(),
  );

  ListenableState<UpdateRequest?> get updateRequestsState =>
      _updateRequestsState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  MediaQueryData get mediaQuery => MediaQuery.of(context);

  void onUpdateButtonPressed() {
    model.openAppStore();
    if (model.isCloseAvailable) contextSafe?.let(Navigator.of).pop();
  }

  void onCancelButtonPressed() {
    if (model.isCloseAvailable) {
      model.dismissWarning();
      contextSafe?.let(Navigator.of).pop();
    }
  }
}
