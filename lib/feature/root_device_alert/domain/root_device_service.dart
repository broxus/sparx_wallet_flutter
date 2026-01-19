import 'package:injectable/injectable.dart';
import 'package:root_checker_plus/root_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class RootDeviceDelegate {
  static const userKnowRootKey = 'user_know_root';

  Future<bool> get isShowRootAlert async {
    return await _isRootDevice && !(await _isUserKnowRoot);
  }

  Future<bool> get _isRootDevice async =>
      (await RootCheckerPlus.isRootChecker()) ?? false;

  Future<bool> get _isUserKnowRoot async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(userKnowRootKey) ?? false;
  }

  Future<bool> setUserKnowRoot() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setBool(userKnowRootKey, true);
  }
}
