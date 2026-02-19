import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:root_checker_plus/root_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class RootDeviceDelegate {
  static const userKnowsRootKey = 'user_know_root';

  Future<bool> get isShowRootScreen async {
    return await _isRootDevice && !(await _isUserKnowRoot);
  }

  Future<bool> get _isRootDevice async {
    if (Platform.isAndroid) {
      return (await RootCheckerPlus.isRootChecker()) ?? false;
    } else if (Platform.isIOS) {
      return (await RootCheckerPlus.isJailbreak()) ?? false;
    }

    return true;
  }

  Future<bool> get _isUserKnowRoot async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(userKnowsRootKey) ?? false;
  }

  Future<bool> setUserKnowRoot() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setBool(userKnowsRootKey, true);
  }
}
