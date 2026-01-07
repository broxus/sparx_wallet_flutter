import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
import 'package:app/utils/common_utils.dart';
import 'package:app/widgets/network_vector_icon.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ChooseNetworkItem extends StatelessWidget {
  const ChooseNetworkItem(
    this.data, {
    required this.onPressed,
    required this.isLoading,
    required this.isDisabled,
    super.key,
  });

  final ChooseNetworkItemData data;
  final bool isLoading;
  final bool isDisabled;
  final ValueChanged<String> onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onNetworkPressed.takeIf((_) => !isDisabled),
      child: PrimaryCard(
        borderRadius: BorderRadius.circular(DimensSize.d12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: DimensSize.d12),
                    child: _Icon(data.icon),
                  ),
                  Flexible(child: _Name(data.title)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: DimensSize.d24),
              child: isLoading
                  ? ProgressIndicatorWidget(
                      size: DimensSize.d20,
                      color: context.themeStyleV2.colors.primaryA,
                    )
                  : Icon(
                      LucideIcons.chevronRight,
                      size: DimensSize.d20,
                      color: context.themeStyleV2.colors.primaryA,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _onNetworkPressed() {
    onPressed(data.id);
  }
}

class _Icon extends StatelessWidget {
  const _Icon(this.icon);

  final String? icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeStyleV2.colors.background2,
        borderRadius: BorderRadius.circular(DimensRadius.radius32),
      ),
      child: NetworkVectorIcon(icon),
    );
  }
}

class _Name extends StatelessWidget {
  const _Name(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return PrimaryText(
      title,
      type: PrimaryTextType.titleSmall,
      textAlign: TextAlign.start,
    );
  }
}
