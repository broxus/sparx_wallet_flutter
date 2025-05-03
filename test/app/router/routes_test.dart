import 'package:app/feature/wallet/token_wallet_send/route.dart';
import 'package:app/feature/wallet/ton_wallet_send/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart' as test;

import '../../helpers/mock_routes.dart';

void main() {
  late TonWalletSendRoute tonWalletSendRoute;
  late TokenWalletSendRoute tokenWalletSendRoute;
  
  setUp(() {
    tonWalletSendRoute = MockRoutes.mockTonWalletSendRoute();
    tokenWalletSendRoute = MockRoutes.mockTokenWalletSendRoute();
  });
  
  group('TonWalletSendRoute', () {
    test.test('should push with correct route data', () async {
      // Arrange
      final address = Address(address: '0:example_address');
      final destination = Address(address: '0:destination_address');
      final publicKey = PublicKey(publicKey: 'example_key');
      final amount = BigInt.from(1000000000);
      
      // Act
      await tonWalletSendRoute.push(
        // context is not used in tests due to mocking
        null as BuildContext, 
        TonWalletSendRouteData(
          address: address,
          destination: destination,
          publicKey: publicKey,
          amount: amount,
          popOnComplete: true,
        ),
      );
      
      // Assert
      MockRoutes.verifyTonWalletSendNavigation(
        tonWalletSendRoute,
        address,
        destination,
        amount,
      );
    });
  });
  
  group('TokenWalletSendRoute', () {
    test.test('should navigate with correct route data', () async {
      // Arrange
      final owner = Address(address: '0:owner_address');
      final rootContract = Address(address: '0:root_contract');
      final destination = Address(address: '0:destination_address');
      final publicKey = PublicKey(publicKey: 'example_key');
      final amount = BigInt.from(1000000000);
      
      // Act
      await tokenWalletSendRoute.push(
        // context is not used in tests due to mocking
        null as BuildContext, 
        TokenWalletSendRouteData(
          owner: owner,
          rootTokenContract: rootContract,
          destination: destination,
          publicKey: publicKey,
          amount: amount,
        ),
      );
      
      // Assert
      MockRoutes.verifyTokenWalletSendNavigation(
        tokenWalletSendRoute,
        owner,
        rootContract,
        destination,
        amount,
      );
    });
  });
}