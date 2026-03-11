import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/choose_network/choose_network_screen_const.dart';
import 'package:app/feature/choose_network/choose_network_screen_wm.dart';
import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
import 'package:app/feature/choose_network/route.dart';
import 'package:app/feature/choose_network/widgets/choose_network_item.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/search/nothing_found.dart';
import 'package:app/widgets/search/search_bar_header_delegate.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/button/app_bar_back_button.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const chooseNetworkScreenNextStepQuery = 'chooseNetworkNextStep';

class ChooseNetworkScreen
    extends
        InjectedElementaryParametrizedWidget<
          ChooseNetworkScreenWidgetModel,
          ChooseNetworkNextStep
        > {
  const ChooseNetworkScreen({
    required ChooseNetworkNextStep nextStep,
    super.key,
  }) : super(wmFactoryParam: nextStep);

  @override
  Widget build(ChooseNetworkScreenWidgetModel wm) {
    final theme = wm.themeStyleV2;

    return Scaffold(
      backgroundColor: theme.colors.background0,
      body: CustomScrollView(
        controller: wm.scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const DefaultAppBar(),
                SizedBox(height: DimensAdaptiveSize.d48.hp),
                PrimaryText(
                  LocaleKeys.chooseNetwork.tr(),
                  type: PrimaryTextType.titleLarge,
                ),
                SizedBox(height: DimensAdaptiveSize.d8.hp),
                PrimaryText(LocaleKeys.selectNetworkNewWalletDescription.tr()),
                SizedBox(height: DimensAdaptiveSize.d48.hp),
              ],
            ),
          ),

          _SearchBar(
            showSearchBar: wm.showSearchBarState,
            searchController: wm.searchController,
          ),
          _NetworksListContent(
            connectionsState: wm.connectionsState,
            loadingItemId: wm.loadingItemIdState,
            onNetworkPressed: wm.onPressedType,
            scrollController: wm.scrollController,
          ),
          SliverToBoxAdapter(child: SizedBox(height: wm.bottomPadding)),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.showSearchBar,
    required this.searchController,
  });

  final StateNotifier<bool> showSearchBar;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<bool>(
      listenableState: showSearchBar,
      builder: (context, showSearchBar) {
        if (!(showSearchBar ?? false)) {
          return const SliverToBoxAdapter(
            child: SizedBox(height: DimensSize.d16),
          );
        }

        return SliverPersistentHeader(
          pinned: true,
          delegate: SearchBarHeaderDelegate(controller: searchController),
        );
      },
    );
  }
}

class _NetworksListContent extends StatelessWidget {
  const _NetworksListContent({
    required this.connectionsState,
    required this.loadingItemId,
    required this.onNetworkPressed,
    required this.scrollController,
  });

  final ValueChanged<String> onNetworkPressed;
  final StateNotifier<List<ChooseNetworkItemData>> connectionsState;
  final StateNotifier<String?> loadingItemId;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return DoubleSourceBuilder(
      firstSource: connectionsState,
      secondSource: loadingItemId,
      builder: (context, items, loadingItemId) {
        if (items == null) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        if (items.isEmpty) {
          return const SliverToBoxAdapter(child: Center(child: NothingFound()));
        }

        return SliverList.separated(
          itemCount: items.length,
          separatorBuilder: (context, _) {
            return const SizedBox(height: DimensSize.d8);
          },
          itemBuilder: (context, index) {
            final item = items[index];

            return Padding(
              padding: EdgeInsets.only(
                left: DimensSize.d16,
                right: DimensSize.d16,
                bottom: (index == items.length - 1)
                    ? DimensSize.d32
                    : DimensSize.d0,
              ),
              child: ChooseNetworkItem(
                item,
                isLoading: item.id == loadingItemId,
                isDisabled: loadingItemId != null,
                onPressed: onNetworkPressed,
              ),
            );
          },
        );
      },
    );
  }
}
