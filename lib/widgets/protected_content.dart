import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:no_screenshot/no_screenshot.dart';

class ProtectedContent extends StatefulWidget {
  const ProtectedContent({required this.child, super.key});

  final Widget child;

  @override
  State<ProtectedContent> createState() => _ProtectedContentState();
}

class _ProtectedContentState extends State<ProtectedContent> {
  static final _logger = Logger('ProtectedContent');

  static var _isNoScreenshotEnabled = false;

  late var _shouldDisableOnDispose = false;

  @override
  void initState() {
    super.initState();
    _enableFlagSecure();
  }

  @override
  void dispose() {
    _disableFlagSecure();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  Future<void> _enableFlagSecure() async {
    if (kDebugMode) return;
    if (_isNoScreenshotEnabled) return;

    _isNoScreenshotEnabled = true;
    _shouldDisableOnDispose = true;

    try {
      final result = await NoScreenshot.instance.screenshotOff();

      if (!result) {
        _isNoScreenshotEnabled = false;
        _shouldDisableOnDispose = false;
        _logger.warning('Failed to disable screenshot');
      }
    } catch (e, st) {
      _logger.warning('Failed to disable screenshot', e, st);
      _isNoScreenshotEnabled = false;
      _shouldDisableOnDispose = false;
    }
  }

  Future<void> _disableFlagSecure() async {
    if (kDebugMode) return;
    if (!_shouldDisableOnDispose) return;

    _isNoScreenshotEnabled = false;
    _shouldDisableOnDispose = false;

    try {
      await NoScreenshot.instance.screenshotOn();
    } catch (e, st) {
      _logger.warning('Failed to enable screenshot', e, st);
    }
  }
}
