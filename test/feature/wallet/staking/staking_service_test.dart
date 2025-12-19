import 'dart:convert';

import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/transport_strategies/common_transport_strategy.dart';
import 'package:app/app/service/nekoton_related/gas_price_service.dart';
import 'package:app/app/service/ntp_service.dart';
import 'package:app/data/models/gas_price_params.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/staking/staking.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Symbol;
import 'package:test/test.dart';

class _MockNekotonRepository extends Mock implements NekotonRepository {}

class _MockTransportStrategy extends Mock implements CommonTransportStrategy {}

class _MockTransport extends Mock implements Transport {}

class _MockStakingAbiProvider extends Mock implements StakingAbiProvider {}

class _MockGasPriceService extends Mock implements GasPriceService {}

class _MockNtpService extends Mock implements NtpService {}

class _MockDio extends Mock implements Dio {}

class _MockBridge extends Mock implements NekotonBridgeApi {}

void main() {
  final bridge = _MockBridge();

  setUpAll(() {
    registerFallbackValue(
      const Address(
        address: 'EQC2vKG4Xz7uZf8U5Fw6g4zUMIqFZ3VAb9/T/jGj33jjCu1F',
      ),
    );

    registerFallbackValue(BigInt.zero);

    NekotonBridge.initMock(api: bridge);
  });

  late _MockNekotonRepository repository;
  late _MockTransportStrategy transportStrategy;
  late _MockTransport transport;
  late _MockStakingAbiProvider abiProvider;
  late _MockGasPriceService gasPriceService;
  late _MockNtpService ntpService;
  late _MockDio dio;
  late StakingService service;
  late StakingInformation stakingInformation;
  late FullContractState vaultState;
  final now = DateTime.fromMillisecondsSinceEpoch(1);

  const vaultAddress = Address(address: '0:vault');
  const rootAddress = Address(address: '0:root');
  const accountAddress = Address(address: '0:account');

  setUp(() {
    reset(bridge);

    repository = _MockNekotonRepository();
    transportStrategy = _MockTransportStrategy();
    transport = _MockTransport();
    abiProvider = _MockStakingAbiProvider();
    gasPriceService = _MockGasPriceService();
    ntpService = _MockNtpService();
    dio = _MockDio();

    stakingInformation = StakingInformation(
      stakingAPYLink: Uri.parse('https://apy.test'),
      stakingRootContractAddress: rootAddress,
      stakingValutAddress: vaultAddress,
      stakeDepositAttachedFee: BigInt.from(11),
      stakeRemovePendingWithdrawAttachedFee: BigInt.from(22),
      stakeWithdrawAttachedFee: BigInt.from(33),
    );

    vaultState = FullContractState(
      balance: BigInt.zero,
      genTimings: const GenTimings(genLt: '0', genUtime: 0),
      isDeployed: true,
      boc: 'vault-boc',
    );

    when(() => repository.currentTransport).thenReturn(transportStrategy);
    when(() => transportStrategy.networkType).thenReturn(NetworkType.ever);
    when(
      () => transportStrategy.stakeInformation,
    ).thenReturn(stakingInformation);
    when(() => transportStrategy.transport).thenReturn(transport);
    when(() => transport.networkId).thenReturn(1);
    when(
      () => transport.getFullContractState(vaultAddress),
    ).thenAnswer((_) async => vaultState);
    when(
      () => abiProvider.getVaultAbi(any()),
    ).thenAnswer((_) async => 'vault-abi');
    when(
      () => abiProvider.getAccountAbi(any()),
    ).thenAnswer((_) async => 'account-abi');
    when(() => ntpService.now()).thenReturn(now);

    when(
      () => bridge.crateApiMergedNtRunLocal(
        accountStuffBoc: any(named: 'accountStuffBoc'),
        contractAbi: any(named: 'contractAbi'),
        methodId: any(named: 'methodId'),
        input: any(named: 'input'),
        responsible: any(named: 'responsible'),
        signatureId: any(named: 'signatureId'),
        libraries: any(named: 'libraries'),
      ),
    ).thenAnswer((_) async => _executionOutput());

    when(
      () => bridge.crateApiMergedNtEncodeInternalInput(
        contractAbi: any(named: 'contractAbi'),
        method: any(named: 'method'),
        input: any(named: 'input'),
      ),
    ).thenAnswer((_) async => 'encoded-body');

    when(() => dio.get<Map<String, dynamic>>(any())).thenAnswer(
      (_) async => Response<Map<String, dynamic>>(
        data: {},
        requestOptions: RequestOptions(),
      ),
    );

    service = StakingService(
      repository,
      dio,
      abiProvider,
      gasPriceService,
      ntpService,
    );
  });

  group('StakingService', () {
    test('depositEverBodyPayload encodes amount and nonce', () async {
      // Arrange
      final depositAmount = BigInt.from(123);
      String? capturedInput;
      String? capturedMethod;
      String? capturedAbi;

      when(
        () => bridge.crateApiMergedNtEncodeInternalInput(
          contractAbi: any(named: 'contractAbi'),
          method: any(named: 'method'),
          input: any(named: 'input'),
        ),
      ).thenAnswer((invocation) async {
        capturedInput =
            invocation.namedArguments[const Symbol('input')] as String;
        capturedMethod =
            invocation.namedArguments[const Symbol('method')] as String;
        capturedAbi =
            invocation.namedArguments[const Symbol('contractAbi')] as String;
        return 'body';
      });

      // Act
      final body = await service.depositEverBodyPayload(depositAmount);

      // Assert
      final decoded = jsonDecode(capturedInput!) as Map<String, dynamic>;
      expect(body, 'body');
      expect(capturedAbi, 'vault-abi');
      expect(capturedMethod, 'deposit');
      expect(decoded['_amount'], depositAmount.toString());
      expect(decoded['_nonce'], now.millisecondsSinceEpoch);
    });

    test(
      'withdrawStEverPayload returns encoded payload from runLocal',
      () async {
        // Arrange
        when(
          () => bridge.crateApiMergedNtRunLocal(
            accountStuffBoc: any(named: 'accountStuffBoc'),
            contractAbi: any(named: 'contractAbi'),
            methodId: 'encodeDepositPayload',
            input: any(named: 'input'),
            responsible: false,
            signatureId: any(named: 'signatureId'),
            libraries: any(named: 'libraries'),
          ),
        ).thenAnswer(
          (_) async => _executionOutput({'depositPayload': 'payload'}),
        );

        // Act
        final payload = await service.withdrawStEverPayload();

        // Assert
        expect(payload, 'payload');
      },
    );

    test('removeWithdrawPayload builds comment with nonce', () async {
      // Arrange
      String? capturedInput;
      when(
        () => bridge.crateApiMergedNtEncodeInternalInput(
          contractAbi: any(named: 'contractAbi'),
          method: any(named: 'method'),
          input: any(named: 'input'),
        ),
      ).thenAnswer((invocation) async {
        capturedInput =
            invocation.namedArguments[const Symbol('input')] as String;
        return 'remove-body';
      });

      // Act
      final body = await service.removeWithdrawPayload('42');

      // Assert
      final decoded = jsonDecode(capturedInput!) as Map<String, dynamic>;
      expect(body, 'remove-body');
      expect(decoded['_nonce'], '42');
    });

    test(
      'userAvailableWithdraw sorts and filters cancelled requests',
      () async {
        // Arrange
        const userContract = Address(address: '0:user-contract');
        final userState = FullContractState(
          balance: BigInt.one,
          genTimings: const GenTimings(genLt: '0', genUtime: 0),
          isDeployed: true,
          boc: 'user-boc',
        );
        when(
          () => transport.getFullContractState(userContract),
        ).thenAnswer((_) async => userState);
        when(
          () => bridge.crateApiMergedNtRunLocal(
            accountStuffBoc: any(named: 'accountStuffBoc'),
            contractAbi: any(named: 'contractAbi'),
            methodId: any(named: 'methodId'),
            input: any(named: 'input'),
            responsible: any(named: 'responsible'),
            signatureId: any(named: 'signatureId'),
            libraries: any(named: 'libraries'),
          ),
        ).thenAnswer((invocation) async {
          final methodId =
              invocation.namedArguments[const Symbol('methodId')] as String;
          if (methodId == 'getAccountAddress') {
            return _executionOutput({'value': userContract.address});
          }

          final withdrawRequests = [
            [
              'first',
              {'amount': '5', 'timestamp': '1700000000'},
            ],
            [
              'second',
              {'amount': '10', 'timestamp': '1800000000'},
            ],
          ];

          return _executionOutput({'withdrawRequests': withdrawRequests});
        });

        // Act
        final result = await service.userAvailableWithdraw(accountAddress);
        service.acceptCancelledWithdraw(result.first);
        final filtered = await service.userAvailableWithdraw(accountAddress);

        // Assert
        expect(result.map((e) => e.nonce).toList(), ['second', 'first']);
        expect(filtered.map((e) => e.nonce).toList(), ['first']);
      },
    );

    test(
      'userAvailableWithdraw returns empty when account address missing',
      () async {
        // Arrange
        when(
          () => bridge.crateApiMergedNtRunLocal(
            accountStuffBoc: any(named: 'accountStuffBoc'),
            contractAbi: any(named: 'contractAbi'),
            methodId: any(named: 'methodId'),
            input: any(named: 'input'),
            responsible: any(named: 'responsible'),
            signatureId: any(named: 'signatureId'),
            libraries: any(named: 'libraries'),
          ),
        ).thenAnswer((_) async => _executionOutput());

        // Act
        final result = await service.userAvailableWithdraw(accountAddress);

        // Assert
        expect(result, isEmpty);
      },
    );

    test('getDepositStEverAmount parses result', () async {
      // Arrange
      when(
        () => bridge.crateApiMergedNtRunLocal(
          accountStuffBoc: any(named: 'accountStuffBoc'),
          contractAbi: any(named: 'contractAbi'),
          methodId: 'getDepositStEverAmount',
          input: any(named: 'input'),
          responsible: false,
          signatureId: any(named: 'signatureId'),
          libraries: any(named: 'libraries'),
        ),
      ).thenAnswer((_) async => _executionOutput({'value': '1234'}));

      // Act
      final amount = await service.getDepositStEverAmount(BigInt.one);

      // Assert
      expect(amount, BigInt.from(1234));
    });

    test('getWithdrawEverAmount parses result', () async {
      // Arrange
      when(
        () => bridge.crateApiMergedNtRunLocal(
          accountStuffBoc: any(named: 'accountStuffBoc'),
          contractAbi: any(named: 'contractAbi'),
          methodId: 'getWithdrawEverAmount',
          input: any(named: 'input'),
          responsible: false,
          signatureId: any(named: 'signatureId'),
          libraries: any(named: 'libraries'),
        ),
      ).thenAnswer((_) async => _executionOutput({'value': '321'}));

      // Act
      final amount = await service.getWithdrawEverAmount(BigInt.one);

      // Assert
      expect(amount, BigInt.from(321));
    });

    test('getStEverDetails returns model when output is present', () async {
      // Arrange
      final detailsJson = {
        'stEverSupply': '10',
        'totalAssets': '20',
        'withdrawHoldTime': '3600',
      };
      when(
        () => bridge.crateApiMergedNtRunLocal(
          accountStuffBoc: any(named: 'accountStuffBoc'),
          contractAbi: any(named: 'contractAbi'),
          methodId: 'getDetails',
          input: any(named: 'input'),
          responsible: true,
          signatureId: any(named: 'signatureId'),
          libraries: any(named: 'libraries'),
        ),
      ).thenAnswer((_) async => _executionOutput({'details': detailsJson}));

      // Act
      final details = await service.getStEverDetails();

      // Assert
      expect(details.stEverSupply, BigInt.from(10));
      expect(details.totalAssets, BigInt.from(20));
      expect(details.withdrawHoldTime, '3600');
    });

    test('getStEverDetails throws when output missing', () async {
      // Arrange
      when(
        () => bridge.crateApiMergedNtRunLocal(
          accountStuffBoc: any(named: 'accountStuffBoc'),
          contractAbi: any(named: 'contractAbi'),
          methodId: 'getDetails',
          input: any(named: 'input'),
          responsible: true,
          signatureId: any(named: 'signatureId'),
          libraries: any(named: 'libraries'),
        ),
      ).thenAnswer((_) async => _executionOutput());

      // Act & Assert
      expect(service.getStEverDetails, throwsException);
    });

    test('getVaultContractState caches by address', () async {
      // Act
      await service.getVaultContractState();
      await service.getVaultContractState();

      // Assert
      verify(() => transport.getFullContractState(vaultAddress)).called(1);
    });

    test('getUserContractState throws when contract is missing', () async {
      // Arrange
      when(
        () => transport.getFullContractState(accountAddress),
      ).thenAnswer((_) async => null);

      // Act & Assert
      expect(
        () => service.getUserContractState(accountAddress),
        throwsException,
      );
    });

    test('getAverageAPYPercent multiplies value by 100', () async {
      // Arrange
      when(() => dio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: {
            'data': {'apy': '0.05'},
          },
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      // Act
      final apy = await service.getAverageAPYPercent();

      // Assert
      expect(apy, closeTo(5.0, 0.001));
    });

    test('computeFees returns empty when stake info is null', () async {
      // Arrange
      when(() => transportStrategy.stakeInformation).thenReturn(null);

      // Act
      final fees = await service.computeFees();

      // Assert
      expect(fees.depositAttachedFee, BigInt.zero);
      expect(fees.removePendingWithdrawAttachedFee, BigInt.zero);
      expect(fees.withdrawAttachedFee, BigInt.zero);
    });

    test('computeFees uses gas price service for tycho network', () async {
      // Arrange
      when(() => transportStrategy.networkType).thenReturn(NetworkType.tycho);

      final info = StakingInformation(
        stakingAPYLink: Uri.parse('https://apy.test'),
        stakingRootContractAddress: rootAddress,
        stakingValutAddress: vaultAddress,
        stakeDepositAttachedFee: BigInt.from(10),
        stakeRemovePendingWithdrawAttachedFee: BigInt.from(20),
        stakeWithdrawAttachedFee: BigInt.from(30),
      );
      when(() => transportStrategy.stakeInformation).thenReturn(info);

      final params = GasPriceParams(
        tag1: '1',
        tag2: '2',
        gasPrice: BigInt.one,
        gasLimit: BigInt.one,
        specialGasLimit: BigInt.one,
        gasCredit: BigInt.one,
        blockGasLimit: BigInt.one,
        freezeDueLimit: BigInt.one,
        deleteDueLimit: BigInt.one,
        flatGasLimit: BigInt.one,
        flatGasPrice: BigInt.one,
      );
      when(
        () => gasPriceService.getGasPriceParams(),
      ).thenAnswer((_) async => params);
      when(
        () => gasPriceService.computeGas(
          dynamicGas: any(named: 'dynamicGas'),
          params: params,
        ),
      ).thenAnswer((invocation) async {
        final dynamicGas =
            invocation.namedArguments[const Symbol('dynamicGas')] as BigInt;
        return dynamicGas + BigInt.from(100);
      });

      // Act
      final fees = await service.computeFees();

      // Assert
      expect(fees.depositAttachedFee, BigInt.from(110));
      expect(fees.removePendingWithdrawAttachedFee, BigInt.from(120));
      expect(fees.withdrawAttachedFee, BigInt.from(130));
    });

    test('computeFees returns static values for non-tycho network', () async {
      // Arrange
      when(() => transportStrategy.networkType).thenReturn(NetworkType.venom);

      // Act
      final fees = await service.computeFees();

      // Assert
      expect(
        fees.depositAttachedFee,
        stakingInformation.stakeDepositAttachedFee,
      );
      expect(
        fees.removePendingWithdrawAttachedFee,
        stakingInformation.stakeRemovePendingWithdrawAttachedFee,
      );
      expect(
        fees.withdrawAttachedFee,
        stakingInformation.stakeWithdrawAttachedFee,
      );
    });
  });
}

String _executionOutput([Map<String, dynamic>? output]) {
  return jsonEncode({'output': output, 'code': 0});
}
