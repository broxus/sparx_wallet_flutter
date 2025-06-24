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
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const chooseNetworkScreenNextStepQuery = 'chooseNetworkNextStep';

class ChooseNetworkScreen
    extends InjectedElementaryWidget<ChooseNetworkScreenWidgetModel> {
  const ChooseNetworkScreen({
    required ChooseNetworkNextStep nextStep,
    super.key,
  }) : super(wmFactoryParam: nextStep);

  @override
  Widget build(ChooseNetworkScreenWidgetModel wm) {
    final theme = wm.themeStyleV2;
    final expandedHeight = wm.screenSize.shortestSide;

    return Scaffold(
      backgroundColor: theme.colors.background0,
      body: RawScrollbar(
        controller: wm.scrollController,
        thumbVisibility: true,
        thumbColor: theme.colors.border1,
        thickness: DimensSizeV2.d3,
        minThumbLength: DimensSizeV2.d60,
        radius: const Radius.circular(DimensSizeV2.d3),
        // Emulate scrollbar over networks list
        padding: EdgeInsets.only(
          top: expandedHeight +
              SearchBarHeaderDelegate.headerHeight +
              DimensSizeV2.d16,
          right: DimensSizeV2.d4,
        ),
        child: CustomScrollView(
          controller: wm.scrollController,
          slivers: [
            _AppBar(
              showAppBarTitle: wm.showAppBarTitle,
              onBackPressed: wm.onBackPressed,
              expandedHeight: expandedHeight,
            ),
            _SearchBar(
              showSearchBar: wm.showSearchBar,
              searchController: wm.searchController,
            ),
            _NetworksListContent(
              connectionsState: wm.connectionsState,
              loadingItemId: wm.loadingItemId,
              onNetworkPressed: wm.onPressedType,
              scrollController: wm.scrollController,
            ),
          ],
        ),
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
            child: SizedBox(
              height: DimensSizeV2.d8,
            ),
          );
        }

        return SliverPersistentHeader(
          pinned: true,
          delegate: SearchBarHeaderDelegate(
            controller: searchController,
          ),
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.showAppBarTitle,
    required this.onBackPressed,
    required this.expandedHeight,
  });

  final StateNotifier<bool> showAppBarTitle;
  final VoidCallback onBackPressed;
  final double expandedHeight;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SliverAppBar(
      pinned: true,
      backgroundColor: theme.colors.background0,
      elevation: 0,
      surfaceTintColor: theme.colors.background0,
      toolbarHeight: defaultAppBarHeight,
      leadingWidth: DimensSize.d64,
      titleSpacing: DimensSize.d8,
      leading: Padding(
        padding: const EdgeInsets.only(
          top: DimensSize.d12,
          bottom: DimensSize.d12,
          left: DimensSize.d16,
        ),
        child: AppBarBackButton(
          onPressed: onBackPressed,
        ),
      ),
      centerTitle: true,
      title: StateNotifierBuilder<bool>(
        listenableState: showAppBarTitle,
        builder: (context, showTitle) {
          return AnimatedOpacity(
            opacity: (showTitle ?? false) ? 1.0 : 0.0,
            duration: fadeInFadeOutTitleDuration,
            child: Text(
              LocaleKeys.chooseNetwork.tr(),
              textAlign: TextAlign.center,
              style: theme.textStyles.headingMedium,
            ),
          );
        },
      ),
      expandedHeight: expandedHeight,
      flexibleSpace: const FlexibleSpaceBar(
        background: _ExpandedTitle(),
      ),
    );
  }
}

class _ExpandedTitle extends StatelessWidget {
  const _ExpandedTitle();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Assets.images.networkEarth.image(
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Container(
          padding: const EdgeInsets.only(bottom: DimensSize.d24),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryText(
                LocaleKeys.chooseNetwork.tr(),
                type: PrimaryTextType.titleLarge,
              ),
              SizedBox(height: DimensAdaptiveSize.d8.hp),
              PrimaryText(
                LocaleKeys.selectNetworkNewWalletDescription.tr(),
              ),
            ],
          ),
        ),
      ],
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
          return const SliverToBoxAdapter(
            child: Center(
              child: NothingFound(),
            ),
          );
        }

        return SliverList.separated(
          itemCount: items.length,
          separatorBuilder: (context, _) {
            return const SizedBox(height: DimensSizeV2.d8);
          },
          itemBuilder: (context, index) {
            final item = items[index];

            return Padding(
              padding: EdgeInsets.only(
                left: DimensSizeV2.d16,
                right: DimensSizeV2.d16,
                bottom: (index == items.length - 1)
                    ? DimensSizeV2.d32
                    : DimensSizeV2.d0,
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
