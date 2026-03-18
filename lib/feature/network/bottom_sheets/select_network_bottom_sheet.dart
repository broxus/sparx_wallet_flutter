import 'package:app/feature/network/bottom_sheets/select_network/select_network_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [SelectNetworkWidget].
/// Returns selected connection id or null if none selected.
Future<String?> showSelectNetworkSheet({
  required BuildContext context,
  bool showConfigureButton = true,
}) {
  // Use Flutter's native modal sheet here to isolate an iOS accessibility
  // issue that reproduces when opening the shared modal_bottom_sheet-based
  // implementation.
  return showModalBottomSheet<String>(
    context: context,
    useRootNavigator: true,
    useSafeArea: true,
    isScrollControlled: true,
    showDragHandle: false,
    backgroundColor: context.themeStyleV2.colors.background1,
    barrierColor: Colors.black.withAlpha(Opac.large.toByteInt()),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(DimensRadius.large),
      ),
    ),
    builder: (_) {
      final theme = context.themeStyleV2;

      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: DimensSize.d6),
              child: SheetDraggableLine(
                height: DimensSize.d4,
                verticalMargin: DimensSize.d6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                DimensSize.d16,
                DimensSize.d20,
                DimensSize.d16,
                DimensSize.d8,
              ),
              child: Text(
                LocaleKeys.selectNetwork.tr(),
                style: theme.textStyles.headingLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: DimensSize.d20,
                  left: DimensSize.d16,
                  right: DimensSize.d16,
                ),
                child: SelectNetworkWidget(
                  showConfigureButton: showConfigureButton,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
