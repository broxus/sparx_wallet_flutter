import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/feature/browser/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nekoton_webview/nekoton_webview.dart';

void main() {
  group('AddNetworkExtension.getConnection', () {
    test('builds custom connection from graphql params', () {
      const input = AddNetwork(
        'Custom GraphQL',
        42,
        <String, dynamic>{
          'type': 'graphql',
          'data': <String, dynamic>{
            'endpoints': <String>['https://gql-1.test', 'https://gql-2.test'],
            'local': false,
            'latencyDetectionInterval': 15,
            'maxLatency': 30,
          },
        },
        NetworkConfig('TST', 9, 'https://explorer.test', 'https://tokens.test'),
      );

      final connection = input.getConnection();
      final workchain = connection.defaultWorkchain;

      expect(connection.networkName, 'Custom GraphQL');
      expect(connection.defaultWorkchainId, 0);
      expect(connection.isPreset, isFalse);
      expect(connection.canBeEdited, isTrue);
      expect(workchain.parentConnectionId, connection.id);
      expect(workchain.networkType, NetworkType.custom);
      expect(workchain.networkGroup, 'custom-Custom GraphQL');
      expect(workchain.networkName, 'Custom GraphQL');
      expect(workchain.endpoints, ['https://gql-1.test', 'https://gql-2.test']);
      expect(workchain.blockExplorerUrl, 'https://explorer.test');
      expect(workchain.manifestUrl, 'https://tokens.test');
      expect(workchain.isLocal, isFalse);
      expect(workchain.latencyDetectionInterval, 15);
      expect(workchain.maxLatency, 30);
      expect(workchain.nativeTokenTicker.name, 'TST');
      expect(workchain.defaultNativeCurrencyDecimal, 9);
    });

    test('builds custom connection from proto params', () {
      const input = AddNetwork('Custom Proto', 1, <String, dynamic>{
        'type': 'proto',
        'data': <String, dynamic>{'endpoint': 'https://proto.test'},
      }, null);

      final connection = input.getConnection();

      expect(connection.defaultWorkchain.endpoints, ['https://proto.test']);
      expect(connection.defaultWorkchain.isLocal, isTrue);
      expect(connection.defaultWorkchain.blockExplorerUrl, isEmpty);
      expect(connection.defaultWorkchain.manifestUrl, isEmpty);
    });

    test('throws for invalid connection type', () {
      const input = AddNetwork('Broken', 1, <String, dynamic>{
        'type': 'invalid',
        'data': <String, dynamic>{},
      }, null);

      expect(input.getConnection, throwsException);
    });
  });
}
