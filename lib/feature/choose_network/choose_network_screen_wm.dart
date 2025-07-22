// ignore_for_file: use_build_context_synchronously

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/add_existing_wallet/route.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:app/feature/choose_network/choose_network_screen_const.dart';
import 'package:app/feature/choose_network/choose_network_screen_model.dart';
import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
import 'package:app/feature/choose_network/route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// [WidgetModel] для [ChooseNetworkScreen]
@injectable
class ChooseNetworkScreenWidgetModel extends CustomWidgetModelParametrized<
    ChooseNetworkScreen, ChooseNetworkScreenModel, ChooseNetworkNextStep> {
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

  double get bottomPadding => MediaQuery.of(context).padding.bottom;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _connectionsState.accept(model.fetchNetworksData());
    _showSearchBar.accept(model.shouldShowSearch());
  }

  Future<void> onPressedType(String id) async {
    if (_loadingItemId.value != null) return;

    try {
      final nextStep = wmParams.value;

      _loadingItemId.accept(id);

      final context = contextSafe;
      if (context == null) return;

      if (!await model.checkConnection(context)) {
        return;
      }

      await model.selectType(id);

      if (!isMounted) return;

      switch (nextStep) {
        case ChooseNetworkNextStep.createSeedPassword:
          context.compassContinue(
            const CreateSeedOnboardingPasswordRouteData(),
          );
        case ChooseNetworkNextStep.addExistingWallet:
          context.compassContinue(
            const AddExistingWalletRouteData(),
          );
      }
    } finally {
      _loadingItemId.accept(null);
    }
  }

  void onBackPressed() {
    contextSafe?.compassBack();
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
