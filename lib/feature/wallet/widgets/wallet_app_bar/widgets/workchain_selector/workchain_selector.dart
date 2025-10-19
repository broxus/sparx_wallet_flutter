import 'package:app/app/service/connection/data/connection/connection.dart';
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
    return DoubleSourceBuilder<Connection?, ConnectionWorkchain?>(
      firstSource: wm.currentConnectionState,
      secondSource: wm.currentWorkchainState,
      builder: (
        _,
        Connection? currentConnection,
        ConnectionWorkchain? currentWorkchain,
      ) {
        if (!wm.isShowWorkchainSelector ||
            currentWorkchain == null ||
            currentConnection == null ||
            currentConnection.workchains.length <= 1) {
          return const SizedBox.shrink();
        }

        return Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: wm.onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: DimensSizeV2.d8,
                horizontal: DimensSizeV2.d22
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('W: ${currentWorkchain.id}'),
                  const Icon(
                    LucideIcons.chevronDown,
                    size: DimensSizeV2.d20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
