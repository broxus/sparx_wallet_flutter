import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

sealed class BaseHttpClient {
  BaseHttpClient(this.dio);

  final Dio dio;

  void dispose() {}
}

class JrpcHttpClient extends BaseHttpClient
    implements JrpcConnectionHttpClient {
  JrpcHttpClient(super.dio);

  @override
  Future<String> post({
    required String endpoint,
    required Map<String, String> headers,
    required String data,
  }) async {
    final response = await dio.post<String>(
      endpoint,
      data: data,
      options: Options(headers: headers, responseType: ResponseType.plain),
    );

    return response.data ?? '';
  }
}

class ProtoHttpClient extends BaseHttpClient
    implements ProtoConnectionHttpClient {
  ProtoHttpClient(super.dio);

  @override
  Future<Uint8List> post({
    required String endpoint,
    required Map<String, String> headers,
    required Uint8List dataBytes,
  }) async {
    final response = await dio.post<List<int>>(
      endpoint,
      data: dataBytes,
      options: Options(headers: headers, responseType: ResponseType.bytes),
    );

    return Uint8List.fromList(response.data ?? []);
  }
}

class GqlHttpClient extends BaseHttpClient implements GqlConnectionHttpClient {
  GqlHttpClient(super.dio);

  @override
  Future<String> get(String endpoint) async {
    final response = await dio.get<String>(
      endpoint,
      options: Options(responseType: ResponseType.plain),
    );
    return response.data ?? '';
  }

  @override
  Future<String> post({
    required String endpoint,
    required Map<String, String> headers,
    required String data,
  }) async {
    final response = await dio.post<String>(
      endpoint,
      data: data,
      options: Options(
        responseType: ResponseType.plain,
        validateStatus: (status) => status == 200,
      ),
    );

    return response.data ?? '';
  }
}
