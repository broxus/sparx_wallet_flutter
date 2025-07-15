import 'package:app/app/service/service.dart';
import 'package:app/feature/network/edit_network/widgets/network_form_field.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NetworkTypeField extends StatelessWidget {
  const NetworkTypeField({
    required this.types,
    required this.selectedNetworkTypeState,
    required this.onChanged,
    super.key,
  });

  final List<NetworkType> types;
  final ListenableState<NetworkType?> selectedNetworkTypeState;
  final ValueChanged<NetworkType> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return NetworkFormField(
      label: LocaleKeys.networkTypeWord.tr(),
      child: StateNotifierBuilder(
        listenableState: selectedNetworkTypeState,
        builder: (_, selectedValue) {
          return Wrap(
            spacing: DimensSize.d16,
            runSpacing: DimensSize.d16,
            children: [
              for (final type in types)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(type),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IgnorePointer(
                        child: CommonRadioInput(
                          value: type,
                          groupValue: selectedValue,
                          onChanged: (_) {},
                        ),
                      ),
                      const SizedBox(width: DimensSize.d8),
                      Text(
                        type.name,
                        style: theme.textStyles.labelSmall,
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
