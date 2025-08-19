import 'package:app/app/router/router.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:flutter/widgets.dart';

// Delay after app start to show contact support sheet
const _showContactSupportSheetDelay = Duration(seconds: 5);

class CrashDetectorWidget extends StatefulWidget {
  const CrashDetectorWidget({
    required this.child,
    required this.checkCrashDetected,
    super.key,
  });

  final Widget child;
  final Future<bool> Function() checkCrashDetected;

  @override
  State<CrashDetectorWidget> createState() =>
      _CrashDetectorServiceWidgetState();
}

class _CrashDetectorServiceWidgetState extends State<CrashDetectorWidget> {
  bool crashDetected = false;
  late final _checkCrashDetected = widget.checkCrashDetected;

  @override
  void initState() {
    super.initState();

    _detectCrash();
  }

  Future<void> _detectCrash() async {
    Future.delayed(_showContactSupportSheetDelay, _detectCrashDelayed);
  }

  Future<void> _detectCrashDelayed() async {
    crashDetected = await _checkCrashDetected();

    if (crashDetected) {
      setState(() {
        crashDetected = false;
      });

      // We can't use current context here because it's not contains Navigator
      final ctx = CompassRouter.navigatorKey.currentState?.context;
      if (ctx == null) {
        return;
      }

      await showContactSupportSheet(
        // ignore: use_build_context_synchronously
        context: ctx,
        mode: ContactSupportMode.initiatedByCrash,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
