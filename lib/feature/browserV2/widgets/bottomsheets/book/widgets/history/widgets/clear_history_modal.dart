import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/history/ui_models/time_period.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/history/ui_models/type_history.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/history/widgets/history_checkbox_item.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/history/widgets/type_history_item.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

void showClearHistoryModal(BuildContext context, TimePeriod timePeriod) {
  showPrimaryBottomSheet(
    context: context,
    content: ClearHistoryModalContent(timePeriod),
  );
}

class ClearHistoryModalContent extends StatefulWidget {
  const ClearHistoryModalContent(this.timePeriod, {super.key});

  final TimePeriod timePeriod;

  @override
  State<ClearHistoryModalContent> createState() =>
      _ClearHistoryModalContentState();
}

class _ClearHistoryModalContentState extends State<ClearHistoryModalContent> {
  final periods = TimePeriod.values;
  final typeHistory = TypeHistory.values;
  late TimePeriod _timePeriod;
  final Set<TypeHistory> _selectedTypes = {};

  @override
  void initState() {
    super.initState();
    _timePeriod = widget.timePeriod;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d8),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DimensSizeV2.d16),
              color: theme.colors.background2,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const CommonDivider(),
              itemCount: periods.length,
              itemBuilder: (context, index) {
                return HistoryCheckboxItem(
                  title: periods[index].displayName,
                  isSelected: periods[index] == _timePeriod,
                  onChanged: (bool? value) {
                    if (value ?? false) {
                      setState(() {
                        _timePeriod = periods[index];
                      });
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: DimensSizeV2.d16),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DimensSizeV2.d16),
              color: theme.colors.background2,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const CommonDivider(),
              itemCount: typeHistory.length,
              itemBuilder: (context, index) {
                final item = typeHistory[index];
                return TypeHistoryItem(
                  title: item.displayName,
                  isSelected: _selectedTypes.contains(item),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value ?? false) {
                        _selectedTypes.add(item);
                      } else {
                        _selectedTypes.remove(item);
                      }
                    });
                  },
                  description: item.description,
                  icon: item.icon,
                );
              },
            ),
          ),
          const SizedBox(height: DimensSizeV2.d16),
          DestructiveButton(
            buttonShape: ButtonShape.rectangle,
            title: 'Clear history',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
