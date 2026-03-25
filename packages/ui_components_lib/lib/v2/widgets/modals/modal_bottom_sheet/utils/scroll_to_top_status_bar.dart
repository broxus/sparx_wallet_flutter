// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

typedef StatusBarGestureDetectorCallback = void Function(BuildContext context);

class StatusBarGestureDetector extends StatefulWidget {
  const StatusBarGestureDetector({
    required this.child,
    required this.onTap,
    super.key,
  });

  final Widget child;
  final StatusBarGestureDetectorCallback onTap;

  @override
  State<StatusBarGestureDetector> createState() =>
      _StatusBarGestureDetectorState();
}

class _StatusBarGestureDetectorState extends State<StatusBarGestureDetector> {
  final OverlayPortalController controller = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    controller.show();
  }

  @override
  void dispose() {
    controller.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final view = View.of(context);
    return OverlayPortal.targetsRootOverlay(
      controller: controller,
      overlayChildBuilder: (context) {
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: view.padding.top / view.devicePixelRatio,
            width: double.infinity,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => widget.onTap(context),
              excludeFromSemantics: true,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
