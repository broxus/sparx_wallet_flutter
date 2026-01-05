import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SelectNetworkWidget
    extends
        InjectedElementaryParametrizedWidget<SelectNetworkWidgetModel, bool> {
  const SelectNetworkWidget({
    required this.showConfigureButton,
    bool needPopAfterAction = true,
    super.key,
  }) : super(wmFactoryParam: needPopAfterAction);

  final bool showConfigureButton;

  @override
  Widget build(SelectNetworkWidgetModel wm) {
    return SeparatedColumn(
      spacing: DimensSize.d16,
      mainAxisSize: MainAxisSize.min,
      children: [
        DoubleSourceBuilder(
          firstSource: wm.currentConnectionIdState,
          secondSource: wm.connectionsState,
          builder: (_, currentConnectionId, connections) => Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: connections?.length ?? 0,
              itemBuilder: (_, index) {
                final item = connections?[index];
                return item?.let(
                  (data) => NetworkItem.formConnection(
                    data: data,
                    trailing: data.id == currentConnectionId?.$1
                        ? const Icon(LucideIcons.check, size: DimensSize.d20)
                        : null,
                    onTap: () => wm.onItemTap(data),
                  ),
                );
              },
            ),
          ),
        ),
        if (showConfigureButton)
          Padding(
            padding: const EdgeInsets.only(top: DimensSize.d12),
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
