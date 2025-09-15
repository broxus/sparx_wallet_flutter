import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/widgets/switch_to_seed_sheet/switch_to_seed_widget.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/displayable/bottom_sheet/bottom_sheet.dart';

/// Shows bottom sheet that allows user to switch to seed account
///
/// Returns [CompassRouteData] if user wants to switch
Future<CompassRouteData?> showSwitchToSeedSheet({
  required BuildContext context,
  required PublicKey publicKey,
}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, scrollController) => SwitchToSeedWidget(
      publicKey: publicKey,
    ),
  );
}
