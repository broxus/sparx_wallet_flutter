// ignore_for_file: use_build_context_synchronously

import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:app/feature/choose_network/choose_network_screen_const.dart';
import 'package:app/feature/choose_network/choose_network_screen_model.dart';
import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [ChooseNetworkScreenWidgetModel]
ChooseNetworkScreenWidgetModel defaultChooseNetworkScreenWidgetModelFactory(
  BuildContext context,
) {
  return ChooseNetworkScreenWidgetModel(
    ChooseNetworkScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      inject(),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [ChooseNetworkScreen]
class ChooseNetworkScreenWidgetModel
    extends CustomWidgetModel<ChooseNetworkScreen, ChooseNetworkScreenModel> {
  ChooseNetworkScreenWidgetModel(
    super.model,
  );

  late final _loadingItemId = createNotifier<String?>();

  late final scrollController = createScrollController()
    ..addListener(_handleScroll);

  late final searchController = createTextEditingController()
    ..addListener(_handleSearchInput);

  late final _showAppBarTitle = createNotifier<bool>(false);

  late final _showSearchBar = createNotifier<bool>(false);

  late final _connectionsState =
      createNotifier<List<ChooseNetworkItemData>>([]);

  StateNotifier<bool> get showAppBarTitle => _showAppBarTitle;

  StateNotifier<bool> get showSearchBar => _showSearchBar;

  StateNotifier<List<ChooseNetworkItemData>> get connectionsState =>
      _connectionsState;

  StateNotifier<String?> get loadingItemId => _loadingItemId;

  Size get screenSize => MediaQuery.sizeOf(context);

  ThemeStyleV2 get themeStyleV2 => context.themeStyleV2;

  double get windowHeight => MediaQuery.of(context).size.height;

  @override
  void initWidgetModel() {
    _connectionsState.accept(model.fetchNetworksData());
    _showSearchBar.accept(model.shouldShowSearch());

    super.initWidgetModel();
  }

  Future<void> onPressedType(String id) async {
    if (_loadingItemId.value != null) return;

    try {
      _loadingItemId.accept(id);

      final context = contextSafe;
      if (context == null) return;

      if (!await model.checkConnection(context)) {
        return;
      }

      final isSuccess = await model.selectType(id);

      final isCanPop = context.canPop();

      final nextPath = widget.nextStep;

      if (nextPath != null) {
        context.goFurther(
          nextPath,
          preserveQueryParams: true,
        );
      } else if (isCanPop) {
        context.pop(isSuccess);
      }
    } finally {
      _loadingItemId.accept(null);
    }
  }

  void onBackPressed() {
    contextSafe?.pop();
  }

  void _handleScroll() {
    final threshold = screenSize.shortestSide * widthPercentToShowTitle;

    if (scrollController.hasClients) {
      final scrollOffset = scrollController.offset;
      final shouldShowTitle = scrollOffset > threshold;

      _showAppBarTitle.accept(shouldShowTitle);
    }
  }

  void _handleSearchInput() {
    final query = searchController.text;
    final filteredNetowrks = model.fetchNetworksData(query);

    _connectionsState.accept(filteredNetowrks);
  }
}
