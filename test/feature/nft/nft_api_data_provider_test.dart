// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:app/feature/nft/domain/nft_api_data_provider.dart';
import 'package:dio/dio.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _RecordingAdapter implements HttpClientAdapter {
  _RecordingAdapter(this.responseBody);

  final Map<String, dynamic> responseBody;

  RequestOptions? lastRequest;
  dynamic lastRequestData;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<dynamic>? cancelFuture,
  ) async {
    lastRequest = options;

    final buffer = <int>[];

    if (requestStream != null) {
      await for (final chunk in requestStream) {
        buffer.addAll(chunk);
      }
    }

    if (buffer.isNotEmpty) {
      lastRequestData = jsonDecode(utf8.decode(buffer));
    }

    return ResponseBody.fromString(
      jsonEncode(responseBody),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('NftApiDataProvider', () {
    test('getNftList maps dto to domain and builds continuation', () async {
      // Arrange
      final adapter = _RecordingAdapter({
        'totalCount': 1,
        'items': [
          {
            'address': '0:item',
            'collection': '0:collection',
            'owner': '0:owner',
            'manager': null,
            'name': 'Item One',
            'description': 'Test description',
            'nftId': 'id-1',
            'image': 'https://img.png',
            'mimetype': 'image/png',
            'fullImage': 'https://full.png',
            'fullImageMimetype': 'image/png',
          },
        ],
      });

      final dio = Dio(BaseOptions(baseUrl: 'https://api.test'))
        ..httpClientAdapter = adapter;
      final provider = NftApiDataProvider(dio);

      const owner = Address(address: '0:owner');
      const collection = Address(address: '0:collection');

      // Act
      final result = await provider.getNftList(
        apiBaseUrl: 'https://api.test',
        collection: collection,
        owner: owner,
        limit: 10,
        offset: 5,
      );

      // Assert
      expect(result.items, hasLength(1));
      expect(result.continuation, '6');

      final nft = result.items.first.nft;
      expect(nft.address.toJson(), '0:item');
      expect(nft.info.collection, equals(collection));
      expect(nft.info.owner, equals(owner));
      expect(nft.info.manager, equals(owner));
      expect(nft.info.id, 'id-1');
      expect(nft.json.name, 'Item One');
      expect(nft.json.description, 'Test description');
      expect(nft.json.files, hasLength(2));

      expect(adapter.lastRequest?.path, '/nfts');
      expect(adapter.lastRequestData, isA<Map<String, dynamic>>());
      expect(adapter.lastRequestData['owners'], equals(['0:owner']));
      expect(adapter.lastRequestData['collections'], equals(['0:collection']));
      expect(adapter.lastRequestData['limit'], equals(10));
      expect(adapter.lastRequestData['offset'], equals(5));
      expect(adapter.lastRequestData['verified'], isFalse);
    });

    test('getNftList returns null continuation when no items', () async {
      // Arrange
      // ignore: inference_failure_on_collection_literal
      final adapter = _RecordingAdapter({'totalCount': 0, 'items': []});
      final dio = Dio(BaseOptions(baseUrl: 'https://api.test'))
        ..httpClientAdapter = adapter;
      final provider = NftApiDataProvider(dio);

      const owner = Address(address: '0:owner');
      const collection = Address(address: '0:collection');

      // Act
      final result = await provider.getNftList(
        apiBaseUrl: 'https://api.test',
        collection: collection,
        owner: owner,
        limit: 2,
      );

      // Assert
      expect(result.items, isEmpty);
      expect(result.continuation, isNull);
      expect(adapter.lastRequestData['offset'], equals(0));
    });
  });
}
