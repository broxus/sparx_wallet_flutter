import 'package:app/feature/nft/nft.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class DisplayModeSwitch extends StatelessWidget {
  const DisplayModeSwitch({
    required this.displayModeState,
    required this.onModeChanged,
    super.key,
  });

  final ListenableState<NftDisplayMode?> displayModeState;
  final ValueChanged<NftDisplayMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
      listenableState: displayModeState,
      builder: (_, displayMode) {
        return SwitcherSegmentControls(
          fullWidth: false,
          currentValue: displayMode ?? NftDisplayMode.grid,
          values: const [
            PrimarySegmentControl(
              value: NftDisplayMode.grid,
              size: SegmentControlSize.xsmall,
              state: SegmentControlState.normal,
              icon: LucideIcons.grid2x2,
            ),
            PrimarySegmentControl(
              value: NftDisplayMode.list,
              size: SegmentControlSize.xsmall,
              state: SegmentControlState.normal,
              icon: LucideIcons.list,
            ),
          ],
          onTabChanged: onModeChanged,
        );
      },
    );
  }
}
