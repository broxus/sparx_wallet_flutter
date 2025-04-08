import 'package:app/core/app_build_type.dart';
import 'package:app/runner.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio getDio() {
    const timeoutMinutes = 3;

    final dio = Dio()
      ..options.connectTimeout = const Duration(minutes: timeoutMinutes)
      ..options.sendTimeout = const Duration(minutes: timeoutMinutes)
      ..options.receiveTimeout = const Duration(minutes: timeoutMinutes)
      ..interceptors.addAll([
        LogInterceptor(
          requestHeader: false,
          responseHeader: false,
        ),
      ])
      ..httpClientAdapter = NativeAdapter(
        createCronetEngine: () {
          final isTestingBuild = currentAppBuildType != AppBuildType.production;

          return CronetEngine.build(
            enablePublicKeyPinningBypassForLocalTrustAnchors: isTestingBuild,
          );
        },
      );

    return dio;
  }
}
