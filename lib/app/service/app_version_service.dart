import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@singleton
class AppVersionService {
  late final Future<PackageInfo> _info = PackageInfo.fromPlatform();

  Future<String> appVersion() async {
    final info = await _info;
    return info.version;
  }

  Future<String> buildNumber() async {
    final info = await _info;
    return info.buildNumber;
  }

  Future<String> packageName() async {
    final info = await _info;
    return info.packageName;
  }
}
