import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/new_account/select_seed/select_seed_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/bottom_space.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/components/common/common.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SelectSeedWidget extends InjectedElementaryWidget<SelectSeedWidgetModel> {
  const SelectSeedWidget({super.key});

  @override
  Widget build(SelectSeedWidgetModel wm) {
    final theme = wm.theme;
    return DoubleSourceBuilder(
      firstSource: wm.listState,
      secondSource: wm.currentAccountState,
      builder: (context, list, currentSeed) {
        if (list?.isNotEmpty ?? false) {
          return Column(
            children: [
              Flexible(
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                      CommonDivider(color: theme.colors.border0),
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    final seed = list[index];
                    final isFirst = index == 0;
                    final isLast = index == list.length - 1;
                    return GestureDetector(
                      onTap: () => wm.selectSeed(seed),
                      child: _SeedItem(
                        name: seed.name,
                        isSelected: seed == currentSeed,
                        isFirst: isFirst,
                        isLast: isLast,
                      ),
                    );
                  },
                ),
              ),
              AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.selectWord.tr(),
                onPressed: wm.onSelect,
              ),
              const BottomSpace(),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _SeedItem extends StatelessWidget {
  const _SeedItem({
    required this.name,
    required this.isSelected,
    required this.isFirst,
    required this.isLast,
  });

  final String name;
  final bool isSelected;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d24),
      decoration: BoxDecoration(
        color: isSelected ? theme.colors.background3 : theme.colors.background2,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(16) : Radius.zero,
          bottom: isLast ? const Radius.circular(16) : Radius.zero,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: DimensSizeV2.d16),
          Icon(
            LucideIcons.lockKeyhole,
            color: theme.colors.content0,
            size: DimensSizeV2.d20,
          ),
          const SizedBox(width: DimensSizeV2.d12),
          Expanded(
            child: Text(
              name,
              style: theme.textStyles.labelMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isSelected)
            Icon(
              LucideIcons.check,
              color: theme.colors.content0,
              size: DimensSizeV2.d20,
            ),
          const SizedBox(width: DimensSizeV2.d16),
        ],
      ),
    );
  }
}
