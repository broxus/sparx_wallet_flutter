import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SelectNetworkWidget
    extends
        InjectedElementaryParametrizedWidget<SelectNetworkWidgetModel, bool> {
  const SelectNetworkWidget({
    bool needPopAfterAction = true,
    this.scrollController,
    super.key,
  }) : super(wmFactoryParam: needPopAfterAction);

  final ScrollController? scrollController;

  @override
  Widget build(SelectNetworkWidgetModel wm) {
    return SeparatedColumn(
      spacing: DimensSizeV2.d16,
      mainAxisSize: MainAxisSize.min,
      children: [
        DoubleSourceBuilder(
          firstSource: wm.currentConnectionIdState,
          secondSource: wm.connectionsState,
          builder: (_, currentConnectionId, connections) => Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              controller: scrollController,
              itemCount: connections?.length ?? 0,
              itemBuilder: (_, index) {
                final item = connections?[index];
                return item?.let(
                  (data) => NetworkItem.formConnection(
                    data: data,
                    trailing: data.id == currentConnectionId?.$1
                        ? const Icon(LucideIcons.check, size: DimensSizeV2.d20)
                        : null,
                    onTap: () => wm.onItemTap(data),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: DimensSizeV2.d12),
          child: PrimaryButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.configureNetworks.tr(),
            onPressed: wm.onConfigure,
          ),
        ),
      ],
    );
  }
}
