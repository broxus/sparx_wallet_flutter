// ignore_for_file: inference_failure_on_function_return_type
import 'package:app/feature/wallet/widgets/select_account/select_account_wm.dart';
import 'package:app/feature/wallet/widgets/select_account/widgets/seed_item_sliver_section.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SelectAccountWidgetDefaultLayout extends StatelessWidget {
  const SelectAccountWidgetDefaultLayout(
    this._wm, {
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;

  final SelectAccountWidgetModel _wm;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _wm.onTapDown,
      child: Column(
        children: [
          PrimaryTextField(
            textEditingController: _wm.searchController,
            hintText: LocaleKeys.searchWord.tr(),
            onChanged: (_) => _wm.onSearch(),
            onSubmit: (_) => _wm.onSearch(),
          ),
          const SizedBox(height: DimensSize.d24),
          Expanded(
            child: DoubleSourceBuilder(
              firstSource: _wm.listState,
              secondSource: _wm.currentAccountState,
              builder: (context, list, currentAccount) {
                if (list == null) return const SizedBox.shrink();

                final slivers = <Widget>[];

                for (var index = 0; index < list.length; index++) {
                  final data = list[index];
                  final shouldAutoExpand = data.hasCurrentAccount(
                    currentAccount,
                  );

                  // Add each seed as a sticky section
                  slivers.add(
                    SeedItemSliverSection(
                      data: data,
                      shouldAutoExpand: shouldAutoExpand,
                      currentAccount: currentAccount,
                      onTapAccount: _wm.onSelect,
                      getBalanceEntity: _wm.getBalanceEntity,
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
          const SizedBox(height: DimensSize.d16),
          SeparatedColumn(
            children: [
              AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.addAccount.tr(),
                postfixIcon: LucideIcons.plus,
                onPressed: _wm.onAddAccount,
              ),
              PrimaryButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.manageSeedsAndAccounts.tr(),
                onPressed: _wm.onManageSeedsAndAccounts,
              ),
            ],
          ),
          const SizedBox(height: DimensSize.d8),
        ],
      ),
    );
  }
}
