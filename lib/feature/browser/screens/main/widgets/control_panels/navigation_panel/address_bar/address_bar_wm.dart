import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/core/wm/not_null_safe_notifier.dart';
import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:app/feature/browser/screens/main/widgets/control_panels/navigation_panel/address_bar/address_bar.dart';
import 'package:app/feature/browser/screens/main/widgets/control_panels/navigation_panel/address_bar/address_bar_model.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// [WidgetModel] for [BrowserAddressBar]
@injectable
class BrowserAddressBarWidgetModel
    extends CustomWidgetModel<BrowserAddressBar, BrowserAddressBarModel> {
  BrowserAddressBarWidgetModel(super.model);

  late final controller = createTextEditingController(_url.toString());
  late final focusNode = createFocusNode();
  final link = LayerLink();

  late final urlVisibleTextState = createNotifier<bool>(true);
  late final closeVisibleState = createNotifier<bool>(
    controller.text.isNotEmpty,
  );

  late final _textNotifier = NotNullNotifier<String>(controller.text);
  late final _listenable = widget.listenable;
  late final _viewVisibleState = widget.viewVisibleState;
  final tipsOverlayController = OverlayPortalController();

  late final _tipsState = NotNullNotifier(TipType.none);

  AppLifecycleListener? _listener;

  NotNullListenableState<String> get textNotifier => _textNotifier;

  NotNullListenableState<TipType> get tipsState => _tipsState;

  BrowserTab get _tab => _listenable.value;

  Uri get _url => _tab.url;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    _listener = AppLifecycleListener(onStateChange: _onStateChanged);
    focusNode.addListener(_onFocusChange);
    controller.addListener(_onChangeText);
    _listenable.addListener(_handleTab);
    _viewVisibleState.addListener(_updateTips);
    _tipsState.addListener(() => _toggleTips(_tipsState.value != TipType.none));

    urlVisibleTextState.addListener(_handleVisibleText);
    model.activeTabIdState.addListener(() {
      _updateTips();
      resetFocus();
    });
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _tipsState.dispose();
    _listenable.removeListener(_handleTab);
    _viewVisibleState.removeListener(_updateTips);
    _listener?.dispose();
    model.activeTabIdState.removeListener(_updateTips);
    super.dispose();
  }

  void onPressedBackground() => _textNotifier.accept('');

  void onPressedMenu() => widget.onPressedCurrentUrlMenu(_tab.id);

  void onPressedRefresh() => widget.onPressedRefresh(_tab.id);

  void onEditingComplete() {
    resetFocus(context);
    widget.onEditingComplete(_tab.id, controller.text);
  }

  void onPressedTip() {
    urlVisibleTextState.accept(true);
    resetFocus();
  }

  void onPressedClear() {
    controller.clear();
  }

  void onPressedText() {
    urlVisibleTextState.accept(false);
    Future(focusNode.requestFocus);
  }

  Future<void> onPastGoPressed() async {
    final text = await getClipBoardText();
    if (text == null) {
      return;
    }

    model.requestUrlActiveTabSafe(text);
  }

  void _onFocusChange() {
    _updateTips();
    if (focusNode.hasFocus) {
      return;
    }
    urlVisibleTextState.accept(true);
  }

  void _onChangeText() {
    _textNotifier.accept(controller.text);
    closeVisibleState.accept(controller.text.isNotEmpty);
    _updateTips();
  }

  void _handleVisibleText() {
    _updateTips();
  }

  void _toggleTips(bool isShow) {
    Future(() {
      if (isShow && !tipsOverlayController.isShowing) {
        tipsOverlayController.show();
      } else if (!isShow && tipsOverlayController.isShowing) {
        tipsOverlayController.hide();
      }
    });
  }

  void _handleTab() {
    final urlText = _url.toString();
    if (controller.text == urlText) {
      return;
    } else if (urlText == 'about:blank') {
      controller.text = '';
      return;
    }
    controller.text = urlText;
  }

  Future<void> _updateTips() async {
    if (!(_viewVisibleState.value ?? false)) {
      _tipsState.accept(TipType.none);
    } else if (model.isEmptyActiveTabUri &&
        controller.text.isEmpty &&
        await checkExistClipBoardData()) {
      _tipsState.accept(TipType.pastGo);
    } else if (controller.text.isNotEmpty && focusNode.hasFocus) {
      _tipsState.accept(TipType.pages);
    } else {
      _tipsState.accept(TipType.none);
    }
  }

  void _onStateChanged(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      return;
    }

    _updateTips();
  }
}

enum TipType { pastGo, pages, none }
