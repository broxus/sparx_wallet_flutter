import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/staking/staking.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class StakingService {
  StakingService(
    this._nekotonRepository,
    this._dio,
    this._abiProvider,
    this._gasPriceService,
  );

  final NekotonRepository _nekotonRepository;
  final Dio _dio;
  final StakingAbiProvider _abiProvider;
  final GasPriceService _gasPriceService;

  // TODO(komarov): use CachedContractStateProvider instead of this field
  Future<FullContractState?>? _vaultStateCache;

  Future<void> init() async {}

  /// Withdraw request that was cancelled and mustn't be displayed when
  /// [userAvailableWithdraw] returns uncompleted list of blockchain messages.
  final _cancelledWithdraw = <String>[];

  /// key - address of TonWallet that was lisneted to get information about
  /// withdraws
  /// value - list of withdraw requests for this account
  final _withdrawSubject =
      BehaviorSubject<Map<Address, List<StEverWithdrawRequest>>>.seeded({});

  /// If we are calling any method of staking, then current transport has this
  /// data.
  StakingInformation get stakingInformation =>
      _nekotonRepository.currentTransport.stakeInformation!;

  NetworkType get _networkType =>
      _nekotonRepository.currentTransport.networkType;

  /// Get all possible withdraw requests for [accountAddress].
  /// To update withdraws, call [tryUpdateWithdraws].
  Stream<List<StEverWithdrawRequest>> withdrawRequestsStream(
    Address accountAddress,
  ) =>
      _withdrawSubject.stream
          .map((withdraws) => withdraws[accountAddress] ?? []);

  /// This method must be called from AccountCard manually every time when
  /// [TonWallet.fieldUpdatesStream] emits new data.
  Future<void> tryUpdateWithdraws(Address accountAddress) async {
    try {
      final withdraws = await userAvailableWithdraw(accountAddress);
      final existed = _withdrawSubject.value;
      existed[accountAddress] = withdraws;
      _withdrawSubject.add(existed);
    } catch (_) {
      // ignore error
    }
  }

  /// Returns body/comment for TonWalletSendWidget, all other fields should be
  /// put manually.
  Future<String> depositEverBodyPayload(BigInt depositAmount) async {
    final payload = FunctionCall(
      method: 'deposit',
      abi: await _abiProvider.getVaultAbi(_networkType),
      params: {
        '_nonce': NtpTime.now().millisecondsSinceEpoch,
        '_amount': depositAmount.toString(),
      },
    );

    return encodeInternalInput(
      contractAbi: payload.abi,
      method: payload.method,
      input: payload.params,
    );
  }

  /// Returns body/comment to unstake stever via TokenWalletSendPage
  Future<String> withdrawStEverPayload() async {
    final contract = await getVaultContractState();
    final result = await runLocal(
      accountStuffBoc: contract.boc,
      contractAbi: await _abiProvider.getVaultAbi(_networkType),
      methodId: 'encodeDepositPayload',
      input: {
        '_nonce': NtpTime.now().millisecondsSinceEpoch,
      },
      responsible: false,
    );

    return result.output?['depositPayload'] as String? ?? '';
  }

  /// Cancel withdraw request.
  /// Returns body/comment that should be handled via TonWalletSendWidget
  Future<String> removeWithdrawPayload(String nonce) async {
    final payload = FunctionCall(
      method: 'removePendingWithdraw',
      abi: await _abiProvider.getVaultAbi(_networkType),
      params: {
        '_nonce': nonce,
      },
    );

    return encodeInternalInput(
      contractAbi: payload.abi,
      method: payload.method,
      input: payload.params,
    );
  }

  /// Returns unstake requests that in progress
  Future<List<StEverWithdrawRequest>> userAvailableWithdraw(
    Address account,
  ) async {
    final vaultState = await getVaultContractState();
    final result = await runLocal(
      accountStuffBoc: vaultState.boc,
      contractAbi: await _abiProvider.getVaultAbi(_networkType),
      methodId: 'getAccountAddress',
      input: {'answerId': 0, '_user': account.toRaw()},
      responsible: true,
    );
    final address = result.output?.values.firstOrNull as String?;
    if (address == null) return [];

    try {
      // This method can drop exception if there were no any transactions with
      // stever and we ignore it
      final userState = await getUserContractState(Address(address: address));
      final requestsResult = await runLocal(
        accountStuffBoc: userState.boc,
        contractAbi: await _abiProvider.getAccountAbi(_networkType),
        methodId: 'withdrawRequests',
        input: {},
        responsible: false,
      );
      final items = (requestsResult.output?['withdrawRequests'] as List? ?? [])
          .cast<List<dynamic>>();

      return items
          // ignore cancelled withdraws
          .where((e) => !_cancelledWithdraw.contains(e[0] as String))
          .map(
            (e) => StEverWithdrawRequest(
              accountAddress: account,
              nonce: e[0] as String,
              data: StEverWithdrawRequestData.fromJson(
                e[1] as Map<String, dynamic>,
              ),
            ),
          )
          .sortedBy((e) => e.data.timestamp)
          .reversed
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// How many stevers receive for evers
  Future<BigInt> getDepositStEverAmount(BigInt evers) async {
    final contractState = await getVaultContractState();
    final result = await runLocal(
      accountStuffBoc: contractState.boc,
      contractAbi: await _abiProvider.getVaultAbi(_networkType),
      methodId: 'getDepositStEverAmount',
      input: {'_amount': evers.toString()},
      responsible: false,
    );
    final amount = result.output?.values.firstOrNull as String?;

    return BigInt.parse(amount ?? '0');
  }

  /// How many evers receive for stevers
  Future<BigInt> getWithdrawEverAmount(BigInt stEvers) async {
    final contractState = await getVaultContractState();
    final result = await runLocal(
      accountStuffBoc: contractState.boc,
      contractAbi: await _abiProvider.getVaultAbi(_networkType),
      methodId: 'getWithdrawEverAmount',
      input: {'_amount': stEvers.toString()},
      responsible: false,
    );
    final amount = result.output?.values.firstOrNull as String?;

    return BigInt.parse(amount ?? '0');
  }

  /// Information about current staking state in blockchain
  Future<StEverDetails> getStEverDetails() async {
    final contractState = await getVaultContractState();
    final result = await runLocal(
      accountStuffBoc: contractState.boc,
      contractAbi: await _abiProvider.getVaultAbi(_networkType),
      methodId: 'getDetails',
      input: {'answerId': 0},
      responsible: true,
    );
    final detailsJson =
        result.output?.values.firstOrNull as Map<String, dynamic>?;
    if (detailsJson == null) throw Exception('StEver details not provided');

    return StEverDetails.fromJson(detailsJson);
  }

  /// Get contract state for staking valut, can be used to call [runLocal]
  /// methods with this contract.
  Future<FullContractState> getVaultContractState() async {
    final state = await (_vaultStateCache ??= _nekotonRepository
        .currentTransport.transport
        .getFullContractState(stakingInformation.stakingValutAddress));

    if (state == null) {
      throw Exception('StEver contract state not provided');
    }

    return state;
  }

  /// Get contract state for user staking, that can be used to call [runLocal]
  /// methods to get information about user staking.
  Future<FullContractState> getUserContractState(
    Address accountVault,
  ) async {
    final contractState = await _nekotonRepository.currentTransport.transport
        .getFullContractState(accountVault);
    if (contractState == null) {
      throw Exception('User StEver contract state not provided');
    }

    return contractState;
  }

  /// Remember cancelled withdraw request and don't show it in
  /// [userAvailableWithdraw]
  void acceptCancelledWithdraw(StEverWithdrawRequest request) {
    _cancelledWithdraw.add(request.nonce);
    tryUpdateWithdraws(request.accountAddress);
  }

  /// Load average apy from stever website.
  /// This returns value from 0 to 100.
  Future<double> getAverageAPYPercent() async {
    final response = await _dio.get<Map<String, dynamic>>(
      stakingInformation.stakingAPYLink.toString(),
    );
    final data = response.data ?? {};

    // ignore: avoid_dynamic_calls, no-magic-number
    return double.parse(data['data']?['apy'] as String? ?? '0.0') * 100;
  }

  void resetCache() => _vaultStateCache = null;

  Future<StakingFees> computeFees() async {
    final info = _nekotonRepository.currentTransport.stakeInformation;
    if (info == null) return StakingFees.empty();

    if (_networkType == 'tycho') {
      final price = await _gasPriceService.getGasPriceParams();

      return StakingFees(
        depositAttachedFee: await _gasPriceService.computeGas(
          dynamicGas: info.stakeDepositAttachedFee,
          params: price,
        ),
        removePendingWithdrawAttachedFee: await _gasPriceService.computeGas(
          dynamicGas: info.stakeRemovePendingWithdrawAttachedFee,
          params: price,
        ),
        withdrawAttachedFee: await _gasPriceService.computeGas(
          dynamicGas: info.stakeWithdrawAttachedFee,
          params: price,
        ),
      );
    }

    return StakingFees(
      depositAttachedFee: info.stakeDepositAttachedFee,
      removePendingWithdrawAttachedFee:
          info.stakeRemovePendingWithdrawAttachedFee,
      withdrawAttachedFee: info.stakeWithdrawAttachedFee,
    );
  }
}
