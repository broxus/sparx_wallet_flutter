import 'dart:io';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen_model.dart';
import 'package:app/utils/common_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/v2/colors_v2.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

/// [WidgetModel] для [CreateBrowserGroupScreen]
@injectable
class CreateBrowserGroupScreenWidgetModel extends CustomWidgetModelParametrized<
    CreateBrowserGroupScreen, CreateBrowserGroupScreenModel, String?> {
  CreateBrowserGroupScreenWidgetModel(
    super.model,
  );

  late final screenHeight = MediaQuery.of(context).size.height;

  final int _maxLength = 24;
  String? _lastFilePath;

  late final _screenShotState = createNotifier<File?>();
  late final _errorState = createNotifier<bool>(false);

  ColorsPaletteV2 get colors => _themeStyleV2.colors;

  ThemeStyleV2 get _themeStyleV2 => context.themeStyleV2;

  late final NotNullListenableState<BrowserTab>? tabNotifier =
      wmParams.value?.let(model.getTabById);

  ListenableState<File?> get screenShotState => _screenShotState;

  ListenableState<bool> get errorState => _errorState;

  int get maxLength => _maxLength;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    if (tabNotifier?.value != null) {
      model.screenshotsState.addListener(_handleScreenShots);
    }
  }

  @override
  void dispose() {
    if (tabNotifier?.value != null) {
      model.screenshotsState.removeListener(_handleScreenShots);
    }
    super.dispose();
  }

  void onPressedBack() {
    context.compassBack();
  }

  void onChangeText(String text) {
    _errorState.accept(text.length > _maxLength);
  }

  void onEditingComplete(String text) {
    final result = text.trim();

    if (result.isEmpty) {
      context.compassBack();
      return;
    }

    context.compassBack<String>(text);
  }

  void onOverflowLength() => _errorState.accept(true);

  void _handleScreenShots() {
    final tabListenable = tabNotifier?.value;
    if (tabListenable == null) {
      return;
    }

    final filePath = model.screenshotsState.value?[tabListenable.id];

    if (filePath == null) {
      return;
    }

    if (filePath != _lastFilePath) {
      final file = File(filePath);

      if (file.existsSync()) {
        _screenShotState.accept(file);
      } else {
        _screenShotState.accept(null);
      }
    }

    _lastFilePath = filePath;
  }
}
