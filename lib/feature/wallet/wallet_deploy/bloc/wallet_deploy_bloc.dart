// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

part 'wallet_deploy_bloc.freezed.dart';
part 'wallet_deploy_event.dart';
part 'wallet_deploy_state.dart';

enum WalletDeployType { standard, multisig }

const defaultRequireConfirmations = 3;
const defaultHoursConfirmations = 24;

/// Bloc that allows select type of wallet (standard/multisig) and deploy it.
/// All custodians must be entered in UI.
///
/// This bloc has 2 big steps:
/// 1) Preparing for deploy (selecting deploy type/entering custodians data)
/// 2) Sending transaction to blockchain
class WalletDeployBloc extends Bloc<WalletDeployEvent, WalletDeployState>
    with BlocBaseMixin {
  WalletDeployBloc({
    required this.context,
    required this.nekotonRepository,
    required this.currenciesService,
    required this.address,
    required this.publicKey,
  }) : super(const WalletDeployState.standard()) {
    _registerHandlers();
    _init();
  }

  final _logger = Logger('WalletDeployBloc');
  final BuildContext context;
  final NekotonRepository nekotonRepository;
  final CurrenciesService currenciesService;

  final Address address;
  final PublicKey publicKey;

  /// Fee for transaction after calculating it in [_handlePrepareDeploy]
  BigInt? fees;
  BigInt? balance;
  String? tonIconPath;
  String? ticker;
  CustomCurrency? tokenCustomCurrency;
  WalletType? walletType;
  UnsignedMessage? unsignedMessage;

  /// Last selected type of deploying.
  /// For [WalletDeployType.multisig] [_cachedRequireConfirmations] and
  /// [_cachedCustodians] will be provided.
  WalletDeployType _type = WalletDeployType.standard;

  /// Cached values for ui for [WalletDeployType.multisig], values will be
  /// updated in [_DeployMultisig] or [_UpdateMultisigData] events.
  List<PublicKey> _cachedCustodians = [];
  int _cachedRequireConfirmations = defaultRequireConfirmations;
  int _cachedHoursConfirmation = defaultHoursConfirmations;

  Future<void> _init() async {
    tonIconPath = nekotonRepository.currentTransport.nativeTokenIcon;
    ticker = nekotonRepository.currentTransport.nativeTokenTicker;
    tokenCustomCurrency = await currenciesService
        .getOrFetchNativeCurrency(nekotonRepository.currentTransport);
    walletType = nekotonRepository.seedList
        .findAccountByAddress(address)
        ?.account
        .tonWallet
        .contract;
  }

  // ignore: long-method
  void _registerHandlers() {
    on<_PrevStep>((_, emit) {
      fees = null;
      emitSafe(
        switch (_type) {
          WalletDeployType.standard => const WalletDeployState.standard(),
          WalletDeployType.multisig => WalletDeployState.multisig(
              _cachedCustodians,
              _cachedRequireConfirmations,
              _cachedHoursConfirmation,
              walletType ?? const WalletType.multisig(MultisigType.multisig2_1),
            ),
        },
      );
    });
    on<_ChangeType>((event, emit) {
      if (event.type == _type) return;

      _type = event.type;
      emitSafe(
        switch (event.type) {
          WalletDeployType.standard => const WalletDeployState.standard(),
          WalletDeployType.multisig => WalletDeployState.multisig(
              _cachedCustodians,
              _cachedRequireConfirmations,
              _cachedHoursConfirmation,
              walletType ?? const WalletType.multisig(MultisigType.multisig2_1),
            ),
        },
      );
    });
    on<_UpdateMultisigData>((event, _) {
      _cachedCustodians = event.custodians;
      _cachedRequireConfirmations = event.requireConfirmations;
      _cachedHoursConfirmation = event.hours ?? defaultHoursConfirmations;
    });
    on<_DeployStandard>((event, emit) => _handlePrepareStandard(emit));
    on<_DeployMultisig>(
      (event, emit) => _handlePrepareMultisig(
        emit,
        event.custodians,
        event.requireConfirmations,
        event.hours,
      ),
    );
    on<_ConfirmDeploy>((event, emit) => _handleSend(emit, event.password));
    on<_AllowCloseDeploy>(
      (event, emit) =>
          emitSafe(const WalletDeployState.deploying(canClose: true)),
    );
    on<_CompleteDeploy>(
      (event, emit) => emitSafe(
        WalletDeployState.deployed(
          fee: fees!,
          balance: balance!,
          transaction: event.transaction,
          custodians:
              _type == WalletDeployType.standard ? null : _cachedCustodians,
          requireConfirmations: _type == WalletDeployType.standard
              ? null
              : _cachedRequireConfirmations,
          tonIconPath: tonIconPath,
        ),
      ),
    );
  }

  Future<void> _handlePrepareStandard(
    Emitter<WalletDeployState> emit,
  ) async {
    _cachedCustodians = [];
    _cachedRequireConfirmations = defaultRequireConfirmations;

    try {
      await _handlePrepareDeploy(emit);
    } on Exception catch (e, t) {
      _logger.severe('_handlePrepareStandard', e, t);
      inject<MessengerService>().show(
        Message.error(message: e.toString()),
      );
    }
  }

  Future<void> _handlePrepareMultisig(
    Emitter<WalletDeployState> emit,
    List<PublicKey> custodians,
    int requireConfirmations,
    int? hours,
  ) async {
    _cachedCustodians = custodians;
    _cachedRequireConfirmations = requireConfirmations;
    _cachedHoursConfirmation = hours ?? defaultHoursConfirmations;

    try {
      await _handlePrepareDeploy(emit, custodians, requireConfirmations);
    } on Exception catch (e, t) {
      _logger.severe('_handlePrepareMultisig', e, t);
      inject<MessengerService>().show(Message.error(message: e.toString()));
    }
  }

  // ignore: long-method
  Future<void> _handlePrepareDeploy(
    Emitter<WalletDeployState> emit, [
    List<PublicKey>? custodians,
    int? requireConfirmations,
  ]) async {
    try {
      final account = nekotonRepository.seedList.findAccountByAddress(address);
      final wallet = await nekotonRepository.walletsMapStream
          .mapNotNull((wallets) => wallets[address])
          .first;

      if (wallet.hasError) {
        emitSafe(WalletDeployState.subscribeError(wallet.error!));

        return;
      }

      balance = wallet.wallet!.contractState.balance;
      unsignedMessage = await _prepareDeploy();
      fees = await estimateFees(unsignedMessage!);

      final isPossibleToSendMessage = balance! > fees!;

      if (!isPossibleToSendMessage) {
        emitSafe(
          WalletDeployState.calculatingError(
            error: LocaleKeys.insufficientFunds.tr(),
            fee: fees,
            balance: balance,
            requireConfirmations: requireConfirmations,
            custodians: custodians,
            tonIconPath: tonIconPath,
            ticker: ticker,
            currency: tokenCustomCurrency,
          ),
        );

        return;
      }

      emitSafe(
        WalletDeployState.readyToDeploy(
          fee: fees!,
          balance: balance!,
          requireConfirmations: requireConfirmations,
          custodians: custodians,
          tonIconPath: tonIconPath,
          ticker: ticker,
          currency: tokenCustomCurrency,
          account: account,
          hours: _cachedHoursConfirmation,
        ),
      );
    } on Exception catch (e, t) {
      _logger.severe('_handlePrepareDeploy', e, t);
      emitSafe(
        WalletDeployState.calculatingError(
          error: e.toString(),
          fee: fees,
          balance: balance,
          requireConfirmations: requireConfirmations,
          custodians: custodians,
          tonIconPath: tonIconPath,
          ticker: ticker,
          currency: tokenCustomCurrency,
        ),
      );
    }
  }

  // ignore: long-method
  Future<void> _handleSend(
    Emitter<WalletDeployState> emit,
    String password,
  ) async {
    final unsigned = unsignedMessage;
    if (unsigned == null) return;

    try {
      emitSafe(const WalletDeployState.deploying(canClose: false));
      await unsigned.refreshTimeout();

      final hash = unsigned.hash;
      final transport = nekotonRepository.currentTransport.transport;

      final signature = await nekotonRepository.seedList.sign(
        data: hash,
        publicKey: publicKey,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await unsigned.sign(signature: signature);

      add(const WalletDeployEvent.allowCloseDeploy());

      final transaction = await nekotonRepository.send(
        address: address,
        signedMessage: signedMessage,
        amount: fees!,
        destination: address,
      );

      inject<MessengerService>().show(
        Message.successful(
          message: LocaleKeys.walletDeployedSuccessfully.tr(),
        ),
      );
      if (!isClosed) {
        add(WalletDeployEvent.completeDeploy(transaction));
      }
    } on OperationCanceledException catch (_) {
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      inject<MessengerService>().show(
        Message.error(
          message: e.toString(),
        ),
      );
      emitSafe(
        WalletDeployState.readyToDeploy(
          fee: fees!,
          balance: balance!,
          custodians:
              _type == WalletDeployType.standard ? null : _cachedCustodians,
          requireConfirmations: _type == WalletDeployType.standard
              ? null
              : _cachedRequireConfirmations,
          tonIconPath: tonIconPath,
          ticker: ticker,
          currency: tokenCustomCurrency,
          hours: _cachedHoursConfirmation,
        ),
      );
    }
  }

  Future<UnsignedMessage> _prepareDeploy() async => _cachedCustodians.isEmpty
      ? nekotonRepository.prepareDeploy(address, defaultSendTimeout)
      : nekotonRepository.prepareDeployWithMultipleOwners(
          address: address,
          custodians: _cachedCustodians,
          reqConfirms: _cachedRequireConfirmations,
          expiration: defaultSendTimeout,
          expirationTime:
              walletType == const WalletType.multisig(MultisigType.multisig2_1)
                  ? _cachedHoursConfirmation * 3600
                  : null, // hours to seconds
        );

  Future<BigInt> estimateFees(UnsignedMessage message) async {
    try {
      return await nekotonRepository.estimateDeploymentFees(
        address: address,
        message: message,
      );
    } on Exception catch (e, t) {
      _logger.severe('estimateFees', e, t);
      return BigInt.zero;
    }
  }

  @override
  Future<void> close() {
    unsignedMessage?.dispose();
    return super.close();
  }
}
