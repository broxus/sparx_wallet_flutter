import 'package:app/app/service/service.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/domain/wallet_deployment_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class MockNekotonRepository extends Mock implements NekotonRepository {}
class MockCurrenciesService extends Mock implements CurrenciesService {}
class MockLedgerService extends Mock implements LedgerService {}
class MockMessengerService extends Mock implements MessengerService {}
class MockAppPermissionsService extends Mock implements AppPermissionsService {}
class MockTransportStrategy extends Mock implements TransportStrategy {}
class MockSeedList extends Mock implements SeedList {}
class MockCustomCurrency extends Mock implements CustomCurrency {}
class MockUnsignedMessage extends Mock implements UnsignedMessage {}
class MockTransaction extends Mock implements Transaction {}
class MockAddress extends Mock implements Address {}
class MockPublicKey extends Mock implements PublicKey {}

void main() {
  late WalletDeploymentService service;
  late MockNekotonRepository mockNekotonRepository;
  late MockCurrenciesService mockCurrenciesService;
  late MockLedgerService mockLedgerService;
  late MockMessengerService mockMessengerService;
  late MockAppPermissionsService mockPermissionsService;
  late MockTransportStrategy mockTransportStrategy;
  late MockSeedList mockSeedList;
  
  final testAddress = MockAddress();
  final testPublicKey = MockPublicKey();
  final testCustodians = [MockPublicKey(), MockPublicKey()];

  setUp(() {
    mockNekotonRepository = MockNekotonRepository();
    mockCurrenciesService = MockCurrenciesService();
    mockLedgerService = MockLedgerService();
    mockMessengerService = MockMessengerService();
    mockPermissionsService = MockAppPermissionsService();
    mockTransportStrategy = MockTransportStrategy();
    mockSeedList = MockSeedList();

    when(() => mockNekotonRepository.currentTransport).thenReturn(mockTransportStrategy);
    when(() => mockNekotonRepository.seedList).thenReturn(mockSeedList);

    service = WalletDeploymentService(
      mockNekotonRepository,
      mockCurrenciesService,
      mockLedgerService,
      mockMessengerService,
      mockPermissionsService,
    );
  });

  group('WalletDeploymentService', () {
    group('initializeDeployment', () {
      test('should initialize deployment with address and public key', () {
        // Act
        service.initializeDeployment(testAddress, testPublicKey);

        // Assert
        expect(service.address, equals(testAddress));
        expect(service.publicKey, equals(testPublicKey));
        expect(service.fee, isNull);
        expect(service.balance, isNull);
        expect(service.unsignedMessage, isNull);
        expect(service.transaction, isNull);
      });
    });

    group('setDeploymentType', () {
      test('should set standard deployment type', () {
        // Act
        service.setDeploymentType(WalletDeployType.standard);

        // Assert
        expect(service.deployType, equals(WalletDeployType.standard));
        expect(service.custodians, isNull);
        expect(service.requireConfirmations, isNull);
        expect(service.hours, isNull);
      });

      test('should set multisig deployment type', () {
        // Arrange
        service.setMultisigConfig(testCustodians, 2, 24);

        // Act
        service.setDeploymentType(WalletDeployType.multisig);

        // Assert
        expect(service.deployType, equals(WalletDeployType.multisig));
      });

      test('should clear multisig data when switching to standard', () {
        // Arrange
        service.setMultisigConfig(testCustodians, 2, 24);

        // Act
        service.setDeploymentType(WalletDeployType.standard);

        // Assert
        expect(service.deployType, equals(WalletDeployType.standard));
        expect(service.custodians, isNull);
        expect(service.requireConfirmations, isNull);
        expect(service.hours, isNull);
      });
    });

    group('setMultisigConfig', () {
      test('should set multisig configuration', () {
        // Act
        service.setMultisigConfig(testCustodians, 2, 24);

        // Assert
        expect(service.custodians, equals(testCustodians));
        expect(service.requireConfirmations, equals(2));
        expect(service.hours, equals(24));
      });
    });

    group('clearDeploymentData', () {
      test('should clear all deployment data', () {
        // Arrange
        service.initializeDeployment(testAddress, testPublicKey);
        service.setDeploymentType(WalletDeployType.multisig);
        service.setMultisigConfig(testCustodians, 2, 24);

        // Act
        service.clearDeploymentData();

        // Assert
        expect(service.address, isNull);
        expect(service.publicKey, isNull);
        expect(service.deployType, isNull);
        expect(service.custodians, isNull);
        expect(service.requireConfirmations, isNull);
        expect(service.hours, isNull);
        expect(service.fee, isNull);
        expect(service.balance, isNull);
        expect(service.unsignedMessage, isNull);
        expect(service.transaction, isNull);
      });
    });

    group('getOrFetchNativeCurrency', () {
      test('should return native currency from currencies service', () async {
        // Arrange
        final mockCurrency = MockCustomCurrency();
        when(() => mockCurrenciesService.getOrFetchNativeCurrency(mockTransportStrategy))
            .thenAnswer((_) async => mockCurrency);

        // Act
        final result = await service.getOrFetchNativeCurrency();

        // Assert
        expect(result, equals(mockCurrency));
        verify(() => mockCurrenciesService.getOrFetchNativeCurrency(mockTransportStrategy)).called(1);
      });
    });
  });
}