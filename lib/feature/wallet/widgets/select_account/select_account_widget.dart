// ignore_for_file: inference_failure_on_function_return_type
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_data.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_wm.dart';
import 'package:app/feature/wallet/widgets/select_account/widgets/private_key_item_widget.dart';
import 'package:app/feature/wallet/widgets/select_account/widgets/seed_phrase_item_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SelectAccountWidget
    extends InjectedElementaryWidget<SelectAccountWidgetModel> {
  const SelectAccountWidget({
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;

  @override
  Widget build(SelectAccountWidgetModel wm) {
    return Column(
      children: [
        PrimaryTextField(
          textEditingController: wm.searchController,
          hintText: LocaleKeys.searchWord.tr(),
          onChanged: (_) => wm.onSearch(),
          onSubmit: (_) => wm.onSearch(),
        ),
        const SizedBox(height: DimensSizeV2.d24),
        Expanded(
          child: DoubleSourceBuilder(
            firstSource: wm.listState,
            secondSource: wm.currentAccountState,
            builder: (context, list, currentAccount) {
              if (list == null) return const SizedBox.shrink();

              final slivers = <Widget>[];

              for (var index = 0; index < list.length; index++) {
                final data = list[index];
                final shouldAutoExpand = data.hasCurrentAccount(currentAccount);

                // Add each seed as a sticky section
                slivers.add(
                  _SeedItemSliverSection(
                    data: data,
                    shouldAutoExpand: shouldAutoExpand,
                    currentAccount: currentAccount,
                    onTapAccount: (item) => wm.onSelect(item),
                    getBalanceEntity: wm.getBalanceEntity,
                    scrollController: scrollController,
                  ),
                );
              }

              return CustomScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                slivers: slivers,
              );
            },
          ),
        ),
        const SizedBox(height: DimensSizeV2.d16),
        SeparatedColumn(
          children: [
            AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.addAccount.tr(),
              postfixIcon: LucideIcons.plus,
              onPressed: wm.onAddAccount,
            ),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.manageSeedsAndAccounts.tr(),
              onPressed: wm.onManageSeedsAndAccounts,
            ),
          ],
        ),
        const SizedBox(height: DimensSizeV2.d8),
      ],
    );
  }
}

class _SeedItemStickyDelegate extends SliverPersistentHeaderDelegate {
  const _SeedItemStickyDelegate({
    required this.data,
    required this.isExpanded,
    required this.isLedger,
    required this.currentAccount,
    required this.onTapAccount,
    required this.getBalanceEntity,
    required this.scrollController,
    required this.onToggleExpand,
  });

  final SelectAccountData data;
  final bool isExpanded;
  final bool isLedger;
  final KeyAccount? currentAccount;
  final Function(KeyAccount) onTapAccount;
  final ListenableState<Money?> Function(KeyAccount) getBalanceEntity;
  final ScrollController scrollController;
  final VoidCallback onToggleExpand;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = context.themeStyleV2;
    return GestureDetector(
      onTap: onToggleExpand,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colors.background2,
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d16),
          child: SeedPhraseItemWidget(
            name: data.name,
            isExpanded: isExpanded,
            isLedger: isLedger,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(_SeedItemStickyDelegate oldDelegate) {
    return data != oldDelegate.data ||
        isExpanded != oldDelegate.isExpanded ||
        currentAccount != oldDelegate.currentAccount;
  }
}

class _SeedItemSliverSection extends StatefulWidget {
  const _SeedItemSliverSection({
    required this.data,
    required this.shouldAutoExpand,
    required this.currentAccount,
    required this.onTapAccount,
    required this.getBalanceEntity,
    required this.scrollController,
  });

  final SelectAccountData data;
  final bool shouldAutoExpand;
  final KeyAccount? currentAccount;
  final Function(KeyAccount) onTapAccount;
  final ListenableState<Money?> Function(KeyAccount) getBalanceEntity;
  final ScrollController scrollController;

  @override
  State<_SeedItemSliverSection> createState() => _SeedItemSliverSectionState();
}

class _SeedItemSliverSectionState extends State<_SeedItemSliverSection>
    with AutomaticKeepAliveClientMixin {
  bool _isExpanded = false;
  Widget? _cachedExpandedContent;

  @override
  bool get wantKeepAlive => _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.shouldAutoExpand;
  }

  @override
  void didUpdateWidget(_SeedItemSliverSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldAutoExpand && !_isExpanded) {
      setState(() {
        _isExpanded = true;
      });
    }
    if (widget.data != oldWidget.data ||
        widget.currentAccount != oldWidget.currentAccount) {
      _cachedExpandedContent = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _SeedItemStickyDelegate(
            data: widget.data,
            isExpanded: _isExpanded,
            isLedger: widget.data.isLedger,
            currentAccount: widget.currentAccount,
            onTapAccount: widget.onTapAccount,
            getBalanceEntity: widget.getBalanceEntity,
            scrollController: widget.scrollController,
            onToggleExpand: _toggleExpand,
          ),
        ),
        if (_isExpanded)
          SliverToBoxAdapter(
            child: _getExpandedContent(context),
          ),
        if (!_isExpanded)
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 8,
            ),
          ),
      ],
    );
  }

  Widget _getExpandedContent(BuildContext context) {
    _cachedExpandedContent ??= Container(
      margin: const EdgeInsets.only(
        bottom: DimensSizeV2.d8,
        left: DimensSizeV2.d8,
        right: DimensSizeV2.d8,
      ),
      decoration: BoxDecoration(
        color: context.themeStyleV2.colors.background2,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(DimensRadiusV2.radius12),
          bottomRight: Radius.circular(DimensRadiusV2.radius12),
        ),
      ),
      child: Column(
        children: [
          const CommonDivider(),
          PrivateKeyItemWidget(
            seedWithInfo: widget.data.privateKeys,
            currentAccount: widget.currentAccount,
            onTap: widget.onTapAccount,
            getBalanceEntity: widget.getBalanceEntity,
            scrollController: widget.scrollController,
            isScrollToAccount: widget.shouldAutoExpand && _isExpanded,
          ),
        ],
      ),
    );
    return _cachedExpandedContent!;
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (!_isExpanded) {
        _cachedExpandedContent = null;
      }
    });
  }
}
