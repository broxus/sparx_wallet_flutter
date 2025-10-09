import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/widgets/workchain_selector/workchain_selector_wm.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

class WorkchainSelector
    extends InjectedElementaryWidget<WorkchainSelectorWidgetModel> {
  const WorkchainSelector({
    super.key,
  });

  @override
  Widget build(WorkchainSelectorWidgetModel wm) {
    return StateNotifierBuilder<ConnectionWorkchain?>(
      listenableState: wm.currentWorkchainState,
      builder: (
        _,
        ConnectionWorkchain? currentWorkchain,
      ) {
        if (currentWorkchain == null) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: wm.onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d8),
            child: Row(
              children: [
                Text('W: ${currentWorkchain.id}'),
                const Icon(
                  LucideIcons.chevronDown,
                  size: DimensSizeV2.d20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
