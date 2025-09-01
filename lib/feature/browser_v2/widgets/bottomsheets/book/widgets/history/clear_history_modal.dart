import 'package:app/feature/browser_v2/data/history_type.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/ui_models/type_history_ui.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history/type_history_item.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

typedef ClearHistoryType = (TimePeriod, Set<TypeHistory>);

Future<ClearHistoryType?> showClearHistoryModal(BuildContext context) {
  return showPrimaryBottomSheet(
    context: context,
    content: const ClearHistoryModalContent(TimePeriod.allHistory),
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
  final _typeHistory = TypeHistory.values;
  late final _timePeriod = widget.timePeriod;
  late final Set<TypeHistory> _selectedTypes = _typeHistory.toSet();

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d8),
      child: Column(
        children: [
          // TODO(knightforce): come back after refactor
          // DecoratedBox(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(DimensSizeV2.d16),
          //     color: theme.colors.background2,
          //   ),
          //   child: ListView.separated(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     separatorBuilder: (_, __) => const CommonDivider(),
          //     itemCount: _periods.length,
          //     itemBuilder: (context, index) {
          //       return HistoryCheckboxItem(
          //         title: _periods[index].displayName,
          //         isSelected: _periods[index] == _timePeriod,
          //         onChanged: (bool? value) {
          //           if (value ?? false) {
          //             setState(() {
          //               _timePeriod = _periods[index];
          //             });
          //           }
          //         },
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: DimensSizeV2.d16),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DimensSizeV2.d16),
              color: theme.colors.background2,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const CommonDivider(),
              itemCount: _typeHistory.length,
              itemBuilder: (context, index) {
                final item = _typeHistory[index];
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
          CustomButton(
            //D92346
            buttonShape: ButtonShape.rectangle,
            title: LocaleKeys.clearWord.tr(),
            backgroundColor: ColorsResV2.raspberryRed,
            onPressed: () {
              Navigator.of(context).pop((_timePeriod, _selectedTypes));
            },
          ),
        ],
      ),
    );
  }
}
