import 'package:app/feature/wallet/widgets/select_account/select_account_data.dart';
import 'package:app/feature/wallet/widgets/select_account/widgets/private_key_item_widget.dart';
import 'package:app/feature/wallet/widgets/select_account/widgets/seed_phrase_item_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SeedItemSliverSection extends StatefulWidget {
  const SeedItemSliverSection({
    required this.data,
    required this.shouldAutoExpand,
    required this.currentAccount,
    required this.onTapAccount,
    required this.getBalanceEntity,
    required this.scrollController,
    super.key,
  });

  final SelectAccountData data;
  final bool shouldAutoExpand;
  final KeyAccount? currentAccount;
  final ValueChanged<KeyAccount> onTapAccount;
  final ListenableState<Money?> Function(KeyAccount) getBalanceEntity;
  final ScrollController scrollController;

  @override
  State<SeedItemSliverSection> createState() => _SeedItemSliverSectionState();
}

class _SeedItemSliverSectionState extends State<SeedItemSliverSection>
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
  void didUpdateWidget(SeedItemSliverSection oldWidget) {
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
          SliverToBoxAdapter(child: _getExpandedContent(context)),
        if (!_isExpanded) const SliverToBoxAdapter(child: SizedBox(height: 8)),
      ],
    );
  }

  Widget _getExpandedContent(BuildContext context) {
    _cachedExpandedContent ??= Container(
      margin: const EdgeInsets.only(
        bottom: DimensSize.d8,
        left: DimensSize.d8,
        right: DimensSize.d8,
      ),
      decoration: BoxDecoration(
        color: context.themeStyleV2.colors.background2,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(DimensRadius.radius12),
          bottomRight: Radius.circular(DimensRadius.radius12),
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
  final ValueChanged<KeyAccount> onTapAccount;
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
          borderRadius: BorderRadius.circular(DimensRadius.radius12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: DimensSize.d16),
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
  double get maxExtent => 52;

  @override
  double get minExtent => 52;

  @override
  bool shouldRebuild(_SeedItemStickyDelegate oldDelegate) {
    return data != oldDelegate.data ||
        isExpanded != oldDelegate.isExpanded ||
        currentAccount != oldDelegate.currentAccount;
  }
}
