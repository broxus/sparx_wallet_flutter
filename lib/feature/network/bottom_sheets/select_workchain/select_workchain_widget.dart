import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/bottom_sheets/select_workchain/select_workchain_wm.dart';
import 'package:app/feature/network/view/network_item.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SelectWorkchainWidget
    extends InjectedElementaryWidget<SelectWorkchainWidgetModel> {
  const SelectWorkchainWidget({super.key});

  @override
  Widget build(SelectWorkchainWidgetModel wm) {
    return SeparatedColumn(
      spacing: DimensSizeV2.d16,
      mainAxisSize: MainAxisSize.min,
      children: [
        DoubleSourceBuilder(
          firstSource: wm.currentConnectionState,
          secondSource: wm.currentWorkchainState,
          builder: (_, currentConnection, currentWorkchain) => Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: currentConnection?.workchains.length ?? 0,
              itemBuilder: (_, index) {
                return currentConnection?.workchains[index].let(
                  (workchain) => NetworkItem.formWorkchain(
                    data: workchain,
                    trailing: workchain.id == currentWorkchain?.id
                        ? const Icon(LucideIcons.check, size: DimensSizeV2.d20)
                        : null,
                    onTap: () => wm.onItemTap(workchain),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
