import 'package:flag_secure/flag_secure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

class ProtectedContent extends StatefulWidget {
  const ProtectedContent({required this.child, super.key});

  final Widget child;

  @override
  State<ProtectedContent> createState() => _ProtectedContentState();
}

class _ProtectedContentState extends State<ProtectedContent> {
  _ProtectedContentState() {
    _isFlagSecureSet = _checkFlagSecure();
  }

  static final _logger = Logger('ProtectedContent');

  late Future<bool> _isFlagSecureSet;

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
  Widget build(BuildContext context) => kDebugMode
      ? widget.child
      : SensitiveContent(
          sensitivity: ContentSensitivity.sensitive,
          child: widget.child,
        );

  Future<bool> _checkFlagSecure() async {
    if (kDebugMode) return false;

    try {
      final isSet = await FlagSecure.isSet;
      return isSet ?? false;
    } catch (e, st) {
      _logger.warning('Failed to check secure flag', e, st);
      return false;
    }
  }

  Future<void> _enableFlagSecure() async {
    if (kDebugMode) return;
    if (await _isFlagSecureSet) return;

    try {
      await FlagSecure.set();
    } catch (e, st) {
      _logger.warning('Failed to enable secure flag', e, st);
    }
  }

  Future<void> _disableFlagSecure() async {
    if (kDebugMode) return;
    if (await _isFlagSecureSet) return;

    try {
      await FlagSecure.unset();
    } catch (e, st) {
      _logger.warning('Failed to disable secure flag', e, st);
    }
  }
}
