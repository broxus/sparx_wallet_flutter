// ignore_for_file: avoid_redundant_argument_values

import 'package:app/core/app_build_type.dart';
import 'package:app/http/interceptors/app_lifecycle_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio getDio(
    AppLifecycleInterceptor appLifecycleInterceptor,
    AppBuildType appBuildType,
  ) {
    final dio = Dio()
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.sendTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..interceptors.addAll([
        appLifecycleInterceptor,
        PrettyDioLogger(
          // Log only errors in release mode
          requestHeader: !kReleaseMode,
          requestBody: !kReleaseMode,
          responseHeader: !kReleaseMode,
          responseBody: !kReleaseMode,
          filter: (options, args) {
            // don't print requests/responses with unit8 list data
            return !args.hasUint8ListData;
          },
        ),
      ])
      ..httpClientAdapter = NativeAdapter(
        createCronetEngine: () {
          final isTestingBuild = appBuildType != AppBuildType.production;

          return CronetEngine.build(
            enablePublicKeyPinningBypassForLocalTrustAnchors: isTestingBuild,
          );
        },
      );

    return dio;
  }
}
