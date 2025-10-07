import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/custodians_settings/custodian_data.dart';
import 'package:app/feature/wallet/custodians_settings/custodians_settings_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class CustodiansSettingsView extends InjectedElementaryParametrizedWidget<
    CustodianSettingsWidgetModel, Address> {
  const CustodiansSettingsView({
    required Address address,
    super.key,
  }) : super(wmFactoryParam: address);

  @override
  Widget build(CustodianSettingsWidgetModel wm) {
    final theme = wm.theme;

    return SingleChildScrollView(
      child: Column(
        children: [
          DoubleSourceBuilder(
            firstSource: wm.custodiansState,
            secondSource: wm.requiredState,
            builder: (_, custodians, requiredConfirmations) {
              if (custodians == null || requiredConfirmations == null) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: DimensSizeV2.d24),
                    child: ProgressIndicatorWidget(
                      size: DimensSizeV2.d40,
                    ),
                  ),
                );
              }

              return Text(
                LocaleKeys.custodiansSettingsLabel.tr(
                  args: [
                    requiredConfirmations.toString(),
                    custodians.length.toString(),
                  ],
                ),
                style: theme.textStyles.paragraphMedium,
              );
            },
          ),
          const SizedBox(height: DimensSizeV2.d24),
          StateNotifierBuilder<List<CustodianData>>(
            listenableState: wm.custodiansState,
            builder: (_, custodians) {
              if (custodians == null) return const SizedBox.shrink();

              return Container(
                decoration: BoxDecoration(
                  color: theme.colors.background2,
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
                ),
                child: SeparatedColumn(
                  separator: const CommonDivider(),
                  children: [
                    for (final item in custodians)
                      _CustodianItem(
                        item: item,
                        onTap: () => wm.renameCustodian(item.key),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CustodianItem extends StatelessWidget {
  const _CustodianItem({
    required this.item,
    required this.onTap,
  });

  final CustodianData item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSizeV2.d24,
          vertical: DimensSizeV2.d12,
        ),
        child: Row(
          children: [
            Icon(LucideIcons.usersRound, color: theme.colors.content0),
            const SizedBox(width: DimensSizeV2.d12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: theme.textStyles.labelMedium),
                  const SizedBox(height: DimensSizeV2.d4),
                  Text(
                    item.key.toEllipseString(),
                    style: theme.textStyles.labelSmall.copyWith(
                      color: theme.colors.content3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: DimensSizeV2.d12,
            ),
            Icon(LucideIcons.pencilLine, color: theme.colors.content0),
          ],
        ),
      ),
    );
  }
}
