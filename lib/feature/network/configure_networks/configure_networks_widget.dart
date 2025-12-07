import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ConfigureNetworksWidget
    extends InjectedElementaryWidget<ConfigureNetworksWidgetModel> {
  const ConfigureNetworksWidget({super.key});

  @override
  Widget build(ConfigureNetworksWidgetModel wm) {
    return SeparatedColumn(
      spacing: DimensSize.d16,
      children: [
        StateNotifierBuilder(
          listenableState: wm.connectionsState,
          builder: (_, connections) => Flexible(
            child: ListView.separated(
              itemCount: connections?.length ?? 0,
              itemBuilder: (_, index) {
                final item = connections?[index];
                return item?.let(
                  (data) => NetworkItem(
                    padding: const EdgeInsets.symmetric(
                      vertical: DimensSize.d8,
                    ),
                    data: data,
                    trailing: const Icon(
                      LucideIcons.chevronRight,
                      size: DimensSize.d20,
                    ),
                    onTap: () => wm.onItemTap(data),
                  ),
                );
              },
              separatorBuilder: (_, __) =>
                  const SizedBox(height: DimensSize.d16),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: DimensSize.d12),
          child: AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.addCustomNetwork.tr(),
            onPressed: wm.onAddNetwork,
          ),
        ),
      ],
    );
  }
}
