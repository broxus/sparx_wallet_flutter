import 'package:app/core/wm/custom_wm.dart';
import 'package:app/extensions/webview_extension.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/permission_bottom_sheet/browser_permission_bottom_sheet.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/permission_bottom_sheet/browser_permission_bottom_sheet_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';

/// [WidgetModel] for [BrowserPermissionBottomSheet]
@injectable
class BrowserPermissionBottomSheetWidgetModel
    extends CustomWidgetModelParametrized<BrowserPermissionBottomSheet,
        BrowserPermissionBottomSheetModel, BrowserPermissionParam> {
  BrowserPermissionBottomSheetWidgetModel(
    super.model,
  );

  late final _permissionsState = createNotifier<String>();

  ListenableState<String> get permissionsState => _permissionsState;

  TextStylesV2 get textStyles => _theme.textStyles;

  String get host => wmParams.value.uri.host;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    final names = <String>[];

    for (final resource in wmParams.value.resources) {
      final name = resource.name;
      if (name.isEmpty) continue;
      names.add(name);
    }

    _permissionsState.accept(names.join(', '));
  }

  void onPressedAllow() {
    model.saveBrowserCameraPermission(
      wmParams.value.uri,
      wmParams.value.resources,
    );
    model.requestCameraPermission();
  }

  void onPressedCancel() => _close();

  void _close() {
    Navigator.of(context).pop();
  }
}

class BrowserPermissionParam {
  BrowserPermissionParam({
    required this.uri,
    required this.resources,
  });

  final WebUri uri;
  final List<PermissionResourceType> resources;
}
