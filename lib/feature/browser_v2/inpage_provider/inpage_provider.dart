import 'dart:async';

import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/service.dart' as s;
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' as nr;
import 'package:nekoton_webview/nekoton_webview.dart' hide Message;

const providerVersion = '0.3.36';
const providerNumericVersion = 3036;

class InpageProvider extends ProviderApi {
  InpageProvider({
    required this.tabId,
    required this.approvalsService,
    required this.permissionsService,
    required this.nekotonRepository,
    required this.messengerService,
    required this.assetsService,
    required this.connectionsStorageService,
    required this.connectionService,
  });

  final _logger = Logger('InpageProvider');

  CustomWebViewController? controller;
  final String tabId;
  final s.BrowserApprovalsService approvalsService;
  final s.PermissionsService permissionsService;
  final nr.NekotonRepository nekotonRepository;
  final MessengerService messengerService;
  final s.AssetsService assetsService;
  final s.ConnectionsStorageService connectionsStorageService;
  final s.ConnectionService connectionService;

  Uri? url;

  Uri? get origin => url == null ? null : Uri.parse(url!.origin);

  /// Checks if the basic permissions are granted.
  ///
  /// This method verifies whether the necessary basic permissions
  /// required for the application to function properly are granted.
  void _checkBasicPermission() {
    final permissions = permissionsService.getPermissions(origin);

    if (permissions == null) {
      throw s.ApprovalsHandleException(LocaleKeys.permissionsNotGranted.tr());
    }
    if (permissions.basic != true) {
      throw s.ApprovalsHandleException(
        LocaleKeys.basicInteractionNotPermitted.tr(),
      );
    }
  }

  /// Checks if the account interaction permission is granted.
  ///
  /// Returns an [AccountInteraction] object that indicates the permission
  /// status.
  AccountInteraction _checkAccountInteractionPermission({
    nr.Address? account,
    nr.PublicKey? publicKey,
  }) {
    final permissions = permissionsService.getPermissions(origin);
    final accountInteraction = permissions?.accountInteraction;

    if (permissions == null) {
      throw s.ApprovalsHandleException(LocaleKeys.permissionsNotGranted.tr());
    }
    if (permissions.basic != true) {
      throw s.ApprovalsHandleException(
        LocaleKeys.basicInteractionNotPermitted.tr(),
      );
    }
    if (accountInteraction == null) {
      throw s.ApprovalsHandleException(
        LocaleKeys.accountInteractionNotPermitted.tr(),
      );
    }
    if (account != null && accountInteraction.address != account) {
      throw s.ApprovalsHandleException(
        LocaleKeys.specifiedAccountInteractionNotPermitted.tr(),
      );
    }
    if (publicKey != null && accountInteraction.publicKey != publicKey) {
      throw s.ApprovalsHandleException(
        LocaleKeys.specifiedSignerIsNotPermitted.tr(),
      );
    }

    return accountInteraction;
  }

  @override
  Future<AddAssetOutput> addAsset(AddAssetInput input) async {
    final accountAddress = nr.Address(address: input.account);
    _checkAccountInteractionPermission(
      account: accountAddress,
    );

    final type = assetTypeMap[input.type];
    final contract = input.params?.rootContract;
    final account =
        nekotonRepository.seedList.findAccountByAddress(accountAddress);
    if (contract == null) {
      throw Exception(LocaleKeys.invalidRootTokenContract.tr());
    }
    if (account == null) {
      throw Exception(
        LocaleKeys.accountNotFound.tr(args: [accountAddress.address]),
      );
    }
    if (type == null) throw Exception(LocaleKeys.typeIsWrong.tr());

    bool newAsset;

    switch (type) {
      case AssetType.tip3Token:
        final rootTokenContract = nr.repackAddress(
          nr.Address(address: contract),
        );
        final transport = nekotonRepository.currentTransport;

        final hasTokenWallet = account
                .additionalAssets[transport.transport.group]?.tokenWallets
                .any((e) => e.rootTokenContract == rootTokenContract) ??
            false;

        if (hasTokenWallet) {
          newAsset = false;
          break;
        }

        final details = await assetsService.getTokenContractAsset(
          rootTokenContract,
          transport,
        );
        if (details == null) {
          throw Exception(LocaleKeys.invalidRootTokenContract.tr());
        }

        await approvalsService.addTip3Token(
          origin: origin!,
          accountAddress: accountAddress,
          details: details,
        );

        await account.addTokenWallet(rootTokenContract);

        newAsset = true;
    }

    return AddAssetOutput(newAsset);
  }

  @override
  Future<PermissionsPartial> changeAccount() async {
    final existingPermissions = permissionsService.getPermissions(origin);
    _checkAccountInteractionPermission();

    final existingPermissionsList = [
      if (existingPermissions?.basic ?? false) Permission.basic,
      if (existingPermissions?.accountInteraction != null)
        Permission.accountInteraction,
    ];

    final permissions = await approvalsService.changeAccount(
      origin: origin!,
      permissions: existingPermissionsList,
      previousSelectedAccount: existingPermissions?.accountInteraction?.address,
    );

    _logger.finest('changeAccount', permissions.toJson());

    final partial = permissions.toPartial();
    await controller?.permissionsChanged(PermissionsChangedEvent(partial));

    return partial;
  }

  @override
  Future<CodeToTvcOutput> codeToTvc(CodeToTvcInput input) async {
    _checkBasicPermission();
    final (tvc, hash) = nr.codeToTvc(input.code);

    return CodeToTvcOutput(tvc, hash);
  }

  @override
  Future<DecodeEventOutput?> decodeEvent(DecodeEventInput input) async {
    _checkBasicPermission();

    final event = await nr.decodeEvent(
      messageBody: input.body,
      contractAbi: input.abi,
      event: input.event,
    );

    return event == null ? null : DecodeEventOutput(event.event, event.data);
  }

  @override
  Future<DecodeInputOutput?> decodeInput(DecodeInputInput input) async {
    _checkBasicPermission();
    final output = await nr.decodeInput(
      messageBody: input.body,
      contractAbi: input.abi,
      method: input.method,
      internal: input.internal,
    );

    return output == null
        ? null
        : DecodeInputOutput(output.method, output.input);
  }

  @override
  Future<DecodeOutputOutput?> decodeOutput(DecodeOutputInput input) async {
    _checkBasicPermission();
    final output = await nr.decodeOutput(
      messageBody: input.body,
      contractAbi: input.abi,
      method: input.method,
    );

    return output == null
        ? null
        : DecodeOutputOutput(output.method, output.output);
  }

  @override
  Future<DecodeTransactionOutput?> decodeTransaction(
    DecodeTransactionInput input,
  ) async {
    _checkBasicPermission();
    final output = await nr.decodeTransaction(
      transaction: nr.Transaction.fromJson(input.transaction.toJson()),
      contractAbi: input.abi,
      method: input.method,
    );

    return output == null
        ? null
        : DecodeTransactionOutput(output.method, output.input, output.output);
  }

  @override
  Future<DecodeTransactionEventsOutput> decodeTransactionEvents(
    DecodeTransactionEventsInput input,
  ) async {
    _checkBasicPermission();
    final events = await nr.decodeTransactionEvents(
      transaction: nr.Transaction.fromJson(input.transaction.toJson()),
      contractAbi: input.abi,
    );

    return DecodeTransactionEventsOutput(
      events
          .map((e) => DecodeTransactionEventsOutputEvents(e.event, e.data))
          .toList(),
    );
  }

  @override
  Future<DecryptDataOutput> decryptData(DecryptDataInput input) async {
    final publicKey = nr.PublicKey(
      publicKey: input.encryptedData.recipientPublicKey,
    );
    final sourceKey = nr.PublicKey(
      publicKey: input.encryptedData.sourcePublicKey,
    );
    final accountInteraction = _checkAccountInteractionPermission(
      publicKey: publicKey,
    );

    final password = await approvalsService.decryptData(
      origin: origin!,
      account: accountInteraction.address,
      recipientPublicKey: publicKey,
      sourcePublicKey: sourceKey,
    );
    final algorithm = nr.EncryptionAlgorithm.values.firstWhereOrNull(
      (alg) => alg.toString() == input.encryptedData.algorithm,
    );

    if (algorithm == null) {
      throw s.ApprovalsHandleException(LocaleKeys.unsupportedAlgorithm.tr());
    }

    final decryptedData = await nekotonRepository.seedList.decrypt(
      publicKey: publicKey,
      password: password,
      data: nr.EncryptedData(
        algorithm: algorithm,
        data: input.encryptedData.data,
        nonce: input.encryptedData.nonce,
        sourcePublicKey: sourceKey,
        recipientPublicKey: publicKey,
      ),
    );

    return DecryptDataOutput(decryptedData);
  }

  @override
  Future<void> disconnect() async {
    permissionsService.deletePermissionsForOrigin(origin!);
    nekotonRepository.unsubscribeContractsTab(tabId);

    await controller?.permissionsChanged(
      const PermissionsChangedEvent(PermissionsPartial(null, null)),
    );
  }

  @override
  Future<EncodeInternalInputOutput> encodeInternalInput(
    FunctionCall input,
  ) async {
    _checkBasicPermission();
    final boc = await nr.encodeInternalInput(
      contractAbi: input.abi,
      method: input.method,
      input: input.params,
    );

    return EncodeInternalInputOutput(boc);
  }

  @override
  Future<EncryptDataOutput> encryptData(EncryptDataInput input) async {
    final publicKey = nr.PublicKey(publicKey: input.publicKey);
    final accountInteraction = _checkAccountInteractionPermission(
      publicKey: publicKey,
    );

    final password = await approvalsService.encryptData(
      origin: origin!,
      account: accountInteraction.address,
      publicKey: publicKey,
      data: input.data,
    );
    final algorithm = nr.EncryptionAlgorithm.values
        .firstWhereOrNull((alg) => alg.toString() == input.algorithm);

    if (algorithm == null) {
      throw s.ApprovalsHandleException(LocaleKeys.unsupportedAlgorithm.tr());
    }

    final encryptedData = await nekotonRepository.seedList.encrypt(
      data: input.data,
      publicKey: publicKey,
      password: password,
      algorithm: algorithm,
      publicKeys: input.recipientPublicKeys
          .map((e) => nr.PublicKey(publicKey: e))
          .toList(),
    );

    return EncryptDataOutput(
      encryptedData
          .map(
            (e) => EncryptedData(
              e.algorithm.toString(),
              e.sourcePublicKey.publicKey,
              e.recipientPublicKey.publicKey,
              e.data,
              e.nonce,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<EstimateFeesOutput> estimateFees(EstimateFeesInput input) async {
    final sender = nr.Address(address: input.sender);
    final amount = input.amount;
    _checkAccountInteractionPermission(account: sender);
    if (amount == null) {
      throw s.ApprovalsHandleException(LocaleKeys.amountIsWrong.tr());
    }
    final repackedRecipient =
        nr.repackAddress(nr.Address(address: input.recipient));

    String? body;

    if (input.payload != null) {
      body = await nr.encodeInternalInput(
        contractAbi: input.payload!.abi,
        method: input.payload!.method,
        input: input.payload!.params,
      );
    }

    var subscribedNew = false;

    try {
      if (nekotonRepository.walletsMap[sender] == null) {
        await nekotonRepository.subscribeByAddress(sender);
        subscribedNew = true;
      }

      final unsignedMessage = await nekotonRepository.prepareTransfer(
        address: sender,
        expiration: defaultSendTimeout,
        params: [
          nr.TonWalletTransferParams(
            destination: repackedRecipient,
            amount: amount,
            body: body,
            bounce: defaultMessageBounce,
          ),
        ],
      );

      final fees = await nekotonRepository.estimateFees(
        address: sender,
        message: unsignedMessage,
      );

      unsignedMessage.dispose();

      return EstimateFeesOutput(fees.toString());
    } finally {
      if (subscribedNew) {
        nekotonRepository.unsubscribe(sender);
      }
    }
  }

  @override
  // ignore: long-method
  Future<ExecuteLocalOutput> executeLocal(ExecuteLocalInput input) async {
    final contract = nr.Address(address: input.address);
    final header = input.messageHeader as Map<String, dynamic>;
    final repackedAddress = nr.repackAddress(contract);
    final payload = input.payload;

    String message;

    if (header['type'] == 'external') {
      if (payload == null || payload is String) {
        message = (await nr.createRawExternalMessage(
          dst: repackedAddress,
          stateInit: input.stateInit,
          body: payload as String?,
          timeout: defaultSendTimeoutDuration,
        ))
            .boc;
      } else if (header['withoutSignature'] == true) {
        final call = FunctionCall.fromJson(payload as Map<String, dynamic>);
        message = (await nr.createExternalMessageWithoutSignature(
          dst: repackedAddress,
          contractAbi: call.abi,
          method: call.method,
          input: call.params,
          timeout: defaultSendTimeoutDuration,
        ))
            .boc;
      } else {
        final publicKey =
            nr.PublicKey(publicKey: header['publicKey']! as String);
        final call = FunctionCall.fromJson(payload as Map<String, dynamic>);
        final accountInteraction = _checkAccountInteractionPermission(
          publicKey: publicKey,
        );

        final unsignedMessage = await nr.createExternalMessage(
          dst: repackedAddress.address,
          publicKey: publicKey,
          contractAbi: call.abi,
          method: call.method,
          input: call.params,
          timeout: defaultSendTimeoutDuration,
          stateInit: input.stateInit,
        );

        try {
          if (input.executorParams?.disableSignatureCheck ?? false) {
            message = (await unsignedMessage.signFake()).boc;
          } else {
            final password = await approvalsService.callContractMethod(
              origin: origin!,
              payload: nr.FunctionCall.fromJson(call.toJson()),
              publicKey: publicKey,
              recipient: repackedAddress,
              account: accountInteraction.address,
            );
            final transport = nekotonRepository.currentTransport.transport;

            await unsignedMessage.refreshTimeout();

            final signature = await nekotonRepository.seedList.sign(
              data: unsignedMessage.hash,
              publicKey: publicKey,
              password: password,
              signatureId: await transport.getSignatureId(),
            );

            final signedMessage =
                await unsignedMessage.sign(signature: signature);
            message = signedMessage.boc;
          }
        } finally {
          unsignedMessage.dispose();
        }
      }
    } else if (header['type'] == 'internal') {
      final sender = nr.Address(address: header['sender']! as String);
      final amount = BigInt.parse(header['amount']! as String);
      final bounce = header['bounce']! as bool;
      final bounced = header['bounced'] as bool?;
      final body = input.payload == null
          ? null
          : input.payload is String
              ? input.payload! as String
              : await (FunctionCall call) async {
                  await nr.encodeInternalInput(
                    contractAbi: call.abi,
                    method: call.method,
                    input: call.params,
                  );
                }(
                  FunctionCall.fromJson(input.payload! as Map<String, dynamic>),
                );
      message = await nr.encodeInternalMessage(
        src: sender,
        dst: repackedAddress,
        bounce: bounce,
        stateInit: input.stateInit,
        body: body,
        amount: amount,
        bounced: bounced,
      );
    } else {
      throw s.ApprovalsHandleException(LocaleKeys.unknownMessageType.tr());
    }

    final transport = nekotonRepository.currentTransport.transport;
    final state = await transport.getFullContractState(repackedAddress);
    final config = await transport.getBlockchainConfig();

    final account = await nr.makeFullAccountBoc(state?.boc);
    final overrideBalance = input.executorParams?.overrideBalance;

    final (accountRes, transaction) = await nr.executeLocal(
      account: account,
      config: config.config,
      disableSignatureCheck:
          input.executorParams?.disableSignatureCheck ?? false,
      message: message,
      utime: NtpTime.now(),
      globalId: config.globalId,
      overwriteBalance: overrideBalance == null
          ? null
          : BigInt.parse(overrideBalance as String),
    );
    final newState = await nr.parseFullAccountBoc(accountRes);

    Map<String, Object?>? output;
    if (payload != null && payload is Map<String, dynamic>) {
      final call = FunctionCall.fromJson(payload);
      output = (await nr.decodeTransaction(
        transaction: transaction,
        contractAbi: call.abi,
      ))
          ?.output;
    }

    return ExecuteLocalOutput(
      Transaction.fromJson(transaction.toJson()),
      newState == null ? null : FullContractState.fromJson(newState.toJson()),
      output,
    );
  }

  @override
  Future<ExtractPublicKeyOutput> extractPublicKey(
    ExtractPublicKeyInput input,
  ) async {
    _checkBasicPermission();
    final output = nr.extractPublicKey(input.boc);

    return ExtractPublicKeyOutput(output.publicKey);
  }

  @override
  Future<FindTransactionOutput> findTransaction(
    FindTransactionInput input,
  ) async {
    _checkBasicPermission();
    final hash = input.inMessageHash;
    if (hash == null) {
      throw s.ApprovalsHandleException(LocaleKeys.transactionNotFound.tr());
    }
    final output = await nekotonRepository.currentTransport.transport
        .getDstTransaction(hash);
    final trans = output?.data == null
        ? null
        : Transaction.fromJson(output!.data.toJson());

    return FindTransactionOutput(trans);
  }

  @override
  Future<GetAccountsByCodeHashOutput> getAccountsByCodeHash(
    GetAccountsByCodeHashInput input,
  ) async {
    _checkBasicPermission();
    final accountsList = await nekotonRepository.currentTransport.transport
        .getAccountsByCodeHash(
      codeHash: input.codeHash,
      limit: input.limit?.toInt() ?? 50,
      continuation: input.continuation,
    );

    return GetAccountsByCodeHashOutput(
      accountsList.accounts,
      accountsList.continuation,
    );
  }

  @override
  Future<GetBocHashOutput> getBocHash(GetBocHashInput input) async {
    _checkBasicPermission();
    final hash = nr.getBocHash(input.boc);

    return GetBocHashOutput(hash);
  }

  @override
  Future<GetCodeSaltOutput> getCodeSalt(GetCodeSaltInput input) async {
    _checkBasicPermission();
    final code = nr.getCodeSalt(input.code);

    return GetCodeSaltOutput(code);
  }

  @override
  Future<GetContractFieldsOutput> getContractFields(
    GetContractFieldsInput input,
  ) async {
    _checkBasicPermission();
    final (output, state) =
        await nekotonRepository.currentTransport.transport.getContractFields(
      address: nr.Address(address: input.address),
      contractAbi: input.abi,
      cachedState: input.cachedState == null
          ? null
          : nr.FullContractState.fromJson(input.cachedState!.toJson()),
    );

    return GetContractFieldsOutput(
      output,
      state == null ? null : FullContractState.fromJson(state.toJson()),
    );
  }

  @override
  Future<GetExpectedAddressOutput> getExpectedAddress(
    GetExpectedAddressInput input,
  ) async {
    _checkBasicPermission();
    final (address, state, hash) = await nr.getExpectedAddress(
      tvc: input.tvc,
      contractAbi: input.abi,
      workchainId: input.workchain?.toInt() ?? nr.defaultWorkchainId,
      publicKey: input.publicKey == null
          ? null
          : nr.PublicKey(publicKey: input.publicKey!),
      initData: input.initParams,
    );

    return GetExpectedAddressOutput(
      address.address,
      state,
      hash,
    );
  }

  @override
  Future<GetFullContractStateOutput> getFullContractState(
    GetFullContractStateInput input,
  ) async {
    _checkBasicPermission();
    final state = await nekotonRepository.currentTransport.transport
        .getFullContractState(nr.Address(address: input.address));

    return GetFullContractStateOutput(
      state == null ? null : FullContractState.fromJson(state.toJson()),
    );
  }

  @override
  Future<GetProviderStateOutput> getProviderState() async {
    final transport = nekotonRepository.currentTransport.transport;
    final selectedConnection = transport.group;
    const supportedPermissions = Permission.values;
    final permissions =
        permissionsService.getPermissions(origin) ?? const Permissions();
    final subscriptions = nekotonRepository.tabSubscriptions(tabId);
    final networkId = await transport.getNetworkId();

    return GetProviderStateOutput(
      providerVersion,
      providerNumericVersion,
      selectedConnection,
      networkId,
      supportedPermissions.map((e) => e.name).toList(),
      permissions.toPartial(),
      subscriptions?.map(
            (key, value) => MapEntry(
              key.address,
              ContractUpdatesSubscription(
                value.contractState ?? false,
                value.transactions ?? false,
              ),
            ),
          ) ??
          {},
    );
  }

  @override
  Future<GetTransactionOutput> getTransaction(GetTransactionInput input) async {
    _checkBasicPermission();
    final transaction = await nekotonRepository.currentTransport.transport
        .getTransaction(input.hash);

    return GetTransactionOutput(
      transaction == null ? null : Transaction.fromJson(transaction.toJson()),
    );
  }

  @override
  Future<GetTransactionsOutput> getTransactions(
    GetTransactionsInput input,
  ) async {
    _checkBasicPermission();
    final transactions =
        await nekotonRepository.currentTransport.transport.getTransactions(
      address: nr.Address(address: input.address),
      count: input.limit?.toInt() ?? 50,
      fromLt: input.continuation?.lt,
    );

    return GetTransactionsOutput(
      transactions.transactions
          .map((e) => Transaction.fromJson(e.toJson()))
          .toList(),
      transactions.continuation == null
          ? null
          : TransactionId.fromJson(transactions.continuation!.toJson()),
      transactions.info == null
          ? null
          : TransactionsBatchInfo.fromJson(transactions.info!.toJson()),
    );
  }

  @override
  Future<MergeTvcOutput> mergeTvc(MergeTvcInput input) async {
    _checkBasicPermission();
    final (tvc, hash) = nr.mergeTvc(code: input.code, data: input.data);

    return MergeTvcOutput(tvc, hash);
  }

  @override
  Future<PackIntoCellOutput> packIntoCell(PackIntoCellInput input) async {
    _checkBasicPermission();
    final (boc, hash) = nr.packIntoCell(
      params:
          input.structure.map((e) => nr.AbiParam.fromJson(e.toJson())).toList(),
      tokens: input.data,
      abiVersion: input.abiVersion,
    );

    return PackIntoCellOutput(boc, hash);
  }

  @override
  Future<PermissionsPartial> requestPermissions(
    RequestPermissionsInput input,
  ) async {
    final requiredPermissions =
        input.permissions.map((e) => Permission.values.byName(e)).toList();
    final existingPermissions = permissionsService.getPermissions(origin);

    Permissions permissions;

    if (existingPermissions != null) {
      final newPermissions = [
        if (requiredPermissions.contains(Permission.basic) &&
            existingPermissions.basic == null)
          Permission.basic,
        if (requiredPermissions.contains(Permission.accountInteraction) &&
            existingPermissions.accountInteraction == null)
          Permission.accountInteraction,
      ];

      permissions = newPermissions.isNotEmpty
          ? await approvalsService.requestPermissions(
              origin: origin!,
              permissions: requiredPermissions,
            )
          : existingPermissions;
    } else {
      permissions = await approvalsService.requestPermissions(
        origin: origin!,
        permissions: requiredPermissions,
      );
    }

    final partial = permissions.toPartial();
    await controller?.permissionsChanged(PermissionsChangedEvent(partial));

    return partial;
  }

  @override
  Future<RunLocalOutput> runLocal(RunLocalInput input) async {
    _checkBasicPermission();
    final address = nr.Address(address: input.address);
    final cachedState = input.cachedState == null
        ? null
        : nr.FullContractState.fromJson(input.cachedState!.toJson());
    final contractState = cachedState ??
        await nekotonRepository.currentTransport.transport
            .getFullContractState(address);
    if (contractState == null) {
      throw Exception(
        LocaleKeys.accountNotFound.tr(args: [address.address]),
      );
    }

    if (!contractState.isDeployed || contractState.lastTransactionId == null) {
      throw s.ApprovalsHandleException(LocaleKeys.accountNotDeployed.tr());
    }

    final signatureId = await _computeSignatureId(input.withSignatureId);

    final executionOutput = await nr.runLocal(
      accountStuffBoc: contractState.boc,
      contractAbi: input.functionCall.abi,
      methodId: input.functionCall.method,
      input: input.functionCall.params,
      responsible: input.responsible ?? false,
      signatureId: signatureId,
    );

    return RunLocalOutput(executionOutput.output, executionOutput.code);
  }

  @override
  // ignore: long-method
  Future<SendExternalMessageOutput> sendExternalMessage(
    SendExternalMessageInput input,
  ) async {
    final publicKey = nr.PublicKey(publicKey: input.publicKey);
    final recipient = nr.Address(address: input.recipient);
    final accountInteraction = _checkAccountInteractionPermission(
      publicKey: publicKey,
    );

    final repackedRecipient =
        nr.repackAddress(nr.Address(address: input.recipient));

    var subscribedNew = false;

    try {
      if (nekotonRepository.allContracts
              .firstWhereOrNull((c) => c.address == recipient) ==
          null) {
        await nekotonRepository.subscribeContract(
          address: recipient,
          origin: origin!,
          tabId: tabId,
          contractUpdatesSubscription: const nr.ContractUpdatesSubscription(),
        );
        subscribedNew = true;
      }

      final unsignedMessage = await nr.createExternalMessage(
        dst: repackedRecipient.address,
        contractAbi: input.payload.abi,
        method: input.payload.method,
        input: input.payload.params,
        publicKey: publicKey,
        stateInit: input.stateInit,
        timeout: defaultSendTimeoutDuration,
      );

      final password = await approvalsService.callContractMethod(
        origin: origin!,
        payload: nr.FunctionCall.fromJson(input.payload.toJson()),
        publicKey: publicKey,
        recipient: recipient,
        account: accountInteraction.address,
      );
      final transport = nekotonRepository.currentTransport.transport;

      await unsignedMessage.refreshTimeout();

      final signature = await nekotonRepository.seedList.sign(
        data: unsignedMessage.hash,
        publicKey: publicKey,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await unsignedMessage.sign(signature: signature);
      unsignedMessage.dispose();

      final transaction = input.local ?? false
          ? await nekotonRepository.executeTransactionLocally(
              address: repackedRecipient,
              signedMessage: signedMessage,
              options: nr.TransactionExecutionOptions(
                disableSignatureCheck:
                    input.executorParams?.disableSignatureCheck ?? false,
              ),
            )
          : await nekotonRepository.sendContract(
              address: repackedRecipient,
              signedMessage: signedMessage,
            );

      nr.DecodedTransaction? decodedTransaction;

      try {
        decodedTransaction = await nr.decodeTransaction(
          transaction: transaction,
          contractAbi: input.payload.abi,
          method: input.payload.method,
        );
      } catch (_) {}

      return SendExternalMessageOutput(
        Transaction.fromJson(transaction.toJson()),
        decodedTransaction?.output,
      );
    } finally {
      if (subscribedNew) {
        nekotonRepository.unsubscribeContract(
          tabId: tabId,
          origin: origin!,
          address: recipient,
        );
      }
    }
  }

  @override
  // ignore: long-method
  Future<SendExternalMessageDelayedOutput> sendExternalMessageDelayed(
    SendExternalMessageDelayedInput input,
  ) async {
    final publicKey = nr.PublicKey(publicKey: input.publicKey);
    final recipient = nr.Address(address: input.recipient);
    final accountInteraction = _checkAccountInteractionPermission(
      publicKey: publicKey,
    );

    final repackedRecipient =
        nr.repackAddress(nr.Address(address: input.recipient));

    var subscribedNew = false;

    try {
      if (nekotonRepository.allContracts
              .firstWhereOrNull((c) => c.address == recipient) ==
          null) {
        await nekotonRepository.subscribeContract(
          address: recipient,
          origin: origin!,
          tabId: tabId,
          contractUpdatesSubscription: const nr.ContractUpdatesSubscription(),
        );
        subscribedNew = true;
      }

      final unsignedMessage = await nr.createExternalMessage(
        dst: repackedRecipient.address,
        contractAbi: input.payload.abi,
        method: input.payload.method,
        input: input.payload.params,
        publicKey: publicKey,
        stateInit: input.stateInit,
        timeout: defaultSendTimeoutDuration,
      );

      final password = await approvalsService.callContractMethod(
        origin: origin!,
        payload: nr.FunctionCall.fromJson(input.payload.toJson()),
        publicKey: publicKey,
        recipient: recipient,
        account: accountInteraction.address,
      );
      final transport = nekotonRepository.currentTransport.transport;

      await unsignedMessage.refreshTimeout();

      final signature = await nekotonRepository.seedList.sign(
        data: unsignedMessage.hash,
        publicKey: publicKey,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await unsignedMessage.sign(signature: signature);
      unsignedMessage.dispose();

      final transaction = await nekotonRepository.sendContractUnawaited(
        address: repackedRecipient,
        signedMessage: signedMessage,
      );

      unawaited(
        nekotonRepository
            .waitContractSending(pending: transaction, address: recipient)
            .then((trans) {
          controller?.messageStatusUpdated(
            MessageStatusUpdatedEvent(
              recipient.address,
              signedMessage.hash,
              Transaction.fromJson(trans.toJson()),
            ),
          );
          if (subscribedNew) {
            nekotonRepository.unsubscribeContract(
              tabId: tabId,
              origin: origin!,
              address: recipient,
            );
          }
        }).catchError((Object? e, StackTrace? t) async {
          _logger.severe(
            'sendExternalMessageDelayed, waiting transaction',
            e,
            t,
          );

          return null;
        }),
      );

      return SendExternalMessageDelayedOutput(
        DelayedMessage(
          signedMessage.hash,
          recipient.address,
          nr.dateSecondsSinceEpochJsonConverter.toJson(transaction.expireAt),
        ),
      );
    } catch (_) {
      // error during send process, waiting won't be called
      if (subscribedNew) {
        nekotonRepository.unsubscribeContract(
          tabId: tabId,
          origin: origin!,
          address: recipient,
        );
      }

      rethrow;
    }
  }

  @override
  // ignore: long-method
  Future<SendMessageOutput> sendMessage(SendMessageInput input) async {
    final sender = nr.Address(address: input.sender);
    final amount = input.amount;
    _checkAccountInteractionPermission(account: sender);
    if (amount == null) {
      throw s.ApprovalsHandleException(LocaleKeys.amountIsWrong.tr());
    }
    final repackedRecipient =
        nr.repackAddress(nr.Address(address: input.recipient));

    String? body;
    nr.KnownPayload? knownPayload;

    if (input.payload != null) {
      body = await nr.encodeInternalInput(
        contractAbi: input.payload!.abi,
        method: input.payload!.method,
        input: input.payload!.params,
      );
      knownPayload = nr.parseKnownPayload(body);
    }

    var subscribedNew = false;

    try {
      if (nekotonRepository.walletsMap[sender] == null) {
        await nekotonRepository.subscribeByAddress(sender);
        subscribedNew = true;
      }

      final (key, password) = await approvalsService.sendMessage(
        origin: origin!,
        sender: sender,
        recipient: repackedRecipient,
        amount: amount,
        bounce: input.bounce,
        payload: input.payload != null
            ? nr.FunctionCall.fromJson(input.payload!.toJson())
            : null,
        knownPayload: knownPayload,
        ignoredComputePhaseCodes: input.ignoredComputePhaseCodes
            ?.map(_mapIgnoreTransactionTreeSimulationError)
            .toList(),
        ignoredActionPhaseCodes: input.ignoredActionPhaseCodes
            ?.map(_mapIgnoreTransactionTreeSimulationError)
            .toList(),
      );

      final unsignedMessage = await nekotonRepository.prepareTransfer(
        address: sender,
        expiration: defaultSendTimeout,
        publicKey: key,
        params: [
          nr.TonWalletTransferParams(
            destination: repackedRecipient,
            amount: amount,
            body: body,
            bounce: defaultMessageBounce,
          ),
        ],
      );

      await unsignedMessage.message.refreshTimeout();

      final hash = unsignedMessage.hash;
      final transport = nekotonRepository.currentTransport.transport;

      final signature = await nekotonRepository.seedList.sign(
        data: hash,
        publicKey: key,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await unsignedMessage.sign(signature: signature);
      unsignedMessage.dispose();

      final transaction = await nekotonRepository.send(
        address: sender,
        signedMessage: signedMessage,
        destination: repackedRecipient,
        amount: amount,
      );

      unawaited(
        controller?.messageStatusUpdated(
          MessageStatusUpdatedEvent(
            sender.address,
            signedMessage.hash,
            Transaction.fromJson(transaction.toJson()),
          ),
        ),
      );

      return SendMessageOutput(
        Transaction.fromJson(transaction.toJson()),
      );
    } finally {
      if (subscribedNew) {
        nekotonRepository.unsubscribe(sender);
      }
    }
  }

  @override
  // ignore: long-method
  Future<SendMessageDelayedOutput> sendMessageDelayed(
    SendMessageDelayedInput input,
  ) async {
    final sender = nr.Address(address: input.sender);
    final amount = input.amount;
    _checkAccountInteractionPermission(account: sender);
    if (amount == null) {
      throw s.ApprovalsHandleException(LocaleKeys.amountIsWrong.tr());
    }
    final repackedRecipient =
        nr.repackAddress(nr.Address(address: input.recipient));

    String? body;
    nr.KnownPayload? knownPayload;

    if (input.payload != null) {
      body = await nr.encodeInternalInput(
        contractAbi: input.payload!.abi,
        method: input.payload!.method,
        input: input.payload!.params,
      );
      knownPayload = nr.parseKnownPayload(body);
    }

    var subscribedNew = false;

    try {
      if (nekotonRepository.walletsMap[sender] == null) {
        await nekotonRepository.subscribeByAddress(sender);
        subscribedNew = true;
      }

      final (key, password) = await approvalsService.sendMessage(
        origin: origin!,
        sender: sender,
        recipient: repackedRecipient,
        amount: amount,
        bounce: input.bounce,
        payload: input.payload != null
            ? nr.FunctionCall.fromJson(input.payload!.toJson())
            : null,
        knownPayload: knownPayload,
        ignoredComputePhaseCodes: input.ignoredComputePhaseCodes
            ?.map(_mapIgnoreTransactionTreeSimulationError)
            .toList(),
        ignoredActionPhaseCodes: input.ignoredActionPhaseCodes
            ?.map(_mapIgnoreTransactionTreeSimulationError)
            .toList(),
      );

      final unsignedMessage = await nekotonRepository.prepareTransfer(
        address: sender,
        expiration: defaultSendTimeout,
        publicKey: key,
        params: [
          nr.TonWalletTransferParams(
            destination: repackedRecipient,
            amount: amount,
            body: body,
            bounce: defaultMessageBounce,
          ),
        ],
      );

      await unsignedMessage.message.refreshTimeout();

      final hash = unsignedMessage.hash;
      final transport = nekotonRepository.currentTransport.transport;

      final signature = await nekotonRepository.seedList.sign(
        data: hash,
        publicKey: key,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await unsignedMessage.sign(signature: signature);
      unsignedMessage.dispose();

      final transaction = await nekotonRepository.sendUnawaited(
        address: sender,
        signedMessage: signedMessage,
        destination: repackedRecipient,
        amount: amount,
      );

      unawaited(
        nekotonRepository
            .waitSending(pending: transaction, address: sender)
            .then((trans) {
          controller?.messageStatusUpdated(
            MessageStatusUpdatedEvent(
              sender.address,
              signedMessage.hash,
              Transaction.fromJson(trans.toJson()),
            ),
          );
          if (subscribedNew) {
            nekotonRepository.unsubscribe(sender);
          }
        }).catchError((Object? e, StackTrace? t) async {
          _logger.severe('sendMessageDelayed, waiting transaction', e, t);

          return null;
        }),
      );

      return SendMessageDelayedOutput(
        DelayedMessage(
          signedMessage.hash,
          sender.address,
          // ignore: no-magic-number
          transaction.expireAt.millisecondsSinceEpoch ~/ 1000,
        ),
      );
    } catch (_) {
      // error during send process, waiting won't be called
      if (subscribedNew) {
        nekotonRepository.unsubscribe(sender);
      }

      rethrow;
    }
  }

  @override
  // ignore: long-method
  Future<SendUnsignedExternalMessageOutput> sendUnsignedExternalMessage(
    SendUnsignedExternalMessageInput input,
  ) async {
    final recipient = nr.Address(address: input.recipient);

    _checkBasicPermission();

    final repackedRecipient =
        nr.repackAddress(nr.Address(address: input.recipient));

    var subscribedNew = false;

    try {
      if (nekotonRepository.allContracts
              .firstWhereOrNull((c) => c.address == recipient) ==
          null) {
        await nekotonRepository.subscribeContract(
          address: recipient,
          origin: origin!,
          tabId: tabId,
          contractUpdatesSubscription: const nr.ContractUpdatesSubscription(),
        );
        subscribedNew = true;
      }

      final payload =
          FunctionCall.fromJson(input.payload! as Map<String, dynamic>);
      final signedMessage = await nr.createExternalMessageWithoutSignature(
        dst: repackedRecipient,
        contractAbi: payload.abi,
        method: payload.method,
        input: payload.params,
        stateInit: input.stateInit,
        timeout: defaultSendTimeoutDuration,
      );

      final transaction = input.local ?? false
          ? await nekotonRepository.executeTransactionLocally(
              address: repackedRecipient,
              signedMessage: signedMessage,
              options: nr.TransactionExecutionOptions(
                disableSignatureCheck:
                    input.executorParams?.disableSignatureCheck ?? false,
              ),
            )
          : await nekotonRepository.sendContract(
              address: repackedRecipient,
              signedMessage: signedMessage,
            );

      nr.DecodedTransaction? decodedTransaction;

      try {
        decodedTransaction = await nr.decodeTransaction(
          transaction: transaction,
          contractAbi: payload.abi,
          method: payload.method,
        );
      } catch (_) {}

      return SendUnsignedExternalMessageOutput(
        Transaction.fromJson(transaction.toJson()),
        decodedTransaction?.output,
      );
    } finally {
      if (subscribedNew) {
        nekotonRepository.unsubscribeContract(
          tabId: tabId,
          origin: origin!,
          address: recipient,
        );
      }
    }
  }

  @override
  Future<SetCodeSaltOutput> setCodeSalt(SetCodeSaltInput input) async {
    _checkBasicPermission();
    final (code, hash) = nr.setCodeSalt(code: input.code, salt: input.salt);

    return SetCodeSaltOutput(code, hash);
  }

  @override
  Future<SignDataOutput> signData(SignDataInput input) async {
    final publicKey = nr.PublicKey(publicKey: input.publicKey);
    final accountInteraction = _checkAccountInteractionPermission(
      publicKey: publicKey,
    );

    final password = await approvalsService.signData(
      origin: origin!,
      account: accountInteraction.address,
      publicKey: publicKey,
      data: input.data,
    );
    final signatureId = await _computeSignatureId(input.withSignatureId);

    final signedData = await nekotonRepository.seedList.signData(
      data: input.data,
      publicKey: publicKey,
      password: password,
      signatureId: signatureId,
    );

    return SignDataOutput(
      signedData.dataHash,
      signedData.signature,
      signedData.signatureHex,
      SignDataOutputSignatureParts(
        signedData.signatureParts.high,
        signedData.signatureParts.low,
      ),
    );
  }

  @override
  Future<SignDataRawOutput> signDataRaw(SignDataRawInput input) async {
    final publicKey = nr.PublicKey(publicKey: input.publicKey);
    final accountInteraction = _checkAccountInteractionPermission(
      publicKey: publicKey,
    );

    final password = await approvalsService.signData(
      origin: origin!,
      account: accountInteraction.address,
      publicKey: publicKey,
      data: input.data,
    );
    final signatureId =
        await nekotonRepository.currentTransport.transport.getSignatureId();

    final signedData = await nekotonRepository.seedList.signRawData(
      data: input.data,
      publicKey: publicKey,
      password: password,
      signatureId: signatureId,
    );

    return SignDataRawOutput(
      signedData.signature,
      signedData.signatureHex,
      SignDataRawOutputSignatureParts(
        signedData.signatureParts.high,
        signedData.signatureParts.low,
      ),
    );
  }

  @override
  Future<SplitTvcOutput> splitTvc(SplitTvcInput input) async {
    _checkBasicPermission();
    final (data, code) = nr.splitTvc(input.tvc);

    return SplitTvcOutput(data, code);
  }

  @override
  Future<ContractUpdatesSubscription> subscribe(SubscribeInput input) async {
    final accountAddress = nr.Address(address: input.address);
    _checkBasicPermission();

    final subs = nr.ContractUpdatesSubscription(
      contractState: input.subscriptions.state ?? true,
      transactions: input.subscriptions.transactions ?? true,
    );

    final existed = nekotonRepository.allContracts.firstWhereOrNull(
      (c) =>
          c.address == accountAddress &&
          c.tabId == tabId &&
          c.origin == origin!,
    );
    if (existed == null) {
      await nekotonRepository.subscribeContract(
        tabId: tabId,
        address: accountAddress,
        origin: origin!,
        contractUpdatesSubscription: subs,
      );
    }

    return ContractUpdatesSubscription(subs.contractState!, subs.transactions!);
  }

  @override
  Future<UnpackFromCellOutput> unpackFromCell(UnpackFromCellInput input) async {
    _checkBasicPermission();
    final data = nr.unpackFromCell(
      params:
          input.structure.map((e) => nr.AbiParam.fromJson(e.toJson())).toList(),
      boc: input.boc,
      allowPartial: input.allowPartial,
      abiVersion: input.abiVersion,
    );

    return UnpackFromCellOutput(data);
  }

  @override
  Future<UnpackInitDataOutput> unpackInitData(UnpackInitDataInput input) async {
    _checkBasicPermission();
    final (key, tokens) = await nr.unpackInitData(
      contractAbi: input.abi,
      data: input.data,
    );

    return UnpackInitDataOutput(key?.publicKey, tokens);
  }

  @override
  Future<void> unsubscribe(UnsubscribeInput input) async {
    final accountAddress = nr.Address(address: input.address);

    nekotonRepository.unsubscribeContract(
      tabId: tabId,
      address: accountAddress,
      origin: origin!,
    );
  }

  @override
  Future<void> unsubscribeAll() async =>
      nekotonRepository.unsubscribeContractsTab(tabId);

  @override
  Future<VerifySignatureOutput> verifySignature(
    VerifySignatureInput input,
  ) async {
    _checkBasicPermission();

    final signatureId = input.withSignatureId == true
        ? await nekotonRepository.currentTransport.transport.getSignatureId()
        : input.withSignatureId == false
            ? null
            : int.tryParse(input.withSignatureId.toString());
    final isValid = await nr.verifySignature(
      publicKey: nr.PublicKey(publicKey: input.publicKey),
      data: input.dataHash,
      signature: input.signature,
      signatureId: signatureId,
    );

    return VerifySignatureOutput(isValid);
  }

  @override
  dynamic call(String method, dynamic params) async {
    _logger.finest('method: $method, params: $params');
    try {
      return await super.call(method, params);
    } on s.ApprovalsHandleException catch (e, t) {
      _logger.severe(method, e.message, t);
      messengerService.show(Message.error(message: e.message));
      rethrow;
    } on nr.ExecuteLocalException catch (e) {
      messengerService.show(
        Message.error(
          message: LocaleKeys.contractWithErrorCode.tr(args: [e.errorCode]),
        ),
      );
      rethrow;
    } on nr.FrbException catch (e, t) {
      _logger.severe(method, e, t);
      messengerService.show(Message.error(message: e.toString()));
      rethrow;
    } catch (e, t) {
      _logger.severe(method, e, t);
      messengerService.show(
        Message.error(message: LocaleKeys.browserErrorTitle.tr()),
      );
      rethrow;
    }
  }

  @override
  Future<ComputeStorageFeeOutput> computeStorageFee(
    ComputeStorageFeeInput input,
  ) async {
    _checkBasicPermission();

    final transport = nekotonRepository.currentTransport.transport;
    final config = await transport.getBlockchainConfig();

    final info = await nr.computeStorageFee(
      config: config.config,
      account: input.state.boc,
      utime: input.timestamp?.toInt() ??
          NtpTime.now().millisecondsSinceEpoch ~/ 1000,
      isMasterchain: input.masterchain,
    );

    return ComputeStorageFeeOutput(
      info.storageFee,
      info.storageFeeDebt,
      info.accountStatus,
      info.freezeDueLimit,
      info.deleteDueLimit,
    );
  }

  @override
  Future<AddNetworkOutput> addNetwork(AddNetworkInput input) async {
    _checkBasicPermission();

    final networkId = input.network.networkId.toInt();
    final connections = await _getConnections(networkId);

    if (connections.isNotEmpty) {
      throw s.ApprovalsHandleException(LocaleKeys.networkAlreadyExists.tr());
    }

    nr.Transport? transport;
    try {
      transport = await connectionService.createTransportByConnection(
        input.network.getConnection(),
      );

      if (transport.networkId != input.network.networkId) {
        throw s.ApprovalsHandleException(LocaleKeys.addNetworkIdError.tr());
      }
    } finally {
      await transport?.dispose();
    }

    final network = await approvalsService.addNetwork(
      origin: origin!,
      network: input.network,
      switchNetwork: input.switchNetwork ?? false,
    );

    return AddNetworkOutput(network);
  }

  @override
  Future<ChangeNetworkOutput> changeNetwork(ChangeNetworkInput input) async {
    _checkBasicPermission();

    final networkId = input.networkId.toInt();
    final currentTransport = nekotonRepository.currentTransport;
    final connections = await _getConnections(networkId);

    if (connections.isEmpty) {
      return const ChangeNetworkOutput(null);
    }

    if (currentTransport.transport.networkId == networkId) {
      return ChangeNetworkOutput(await currentTransport.toNetwork());
    }

    final transport = await approvalsService.changeNetwork(
      origin: origin!,
      networkId: networkId,
      connections: connections,
    );

    return ChangeNetworkOutput(await transport?.toNetwork());
  }

  @override
  Future<RunGetterOutput> runGetter(RunGetterInput input) async {
    _checkBasicPermission();

    final address = nr.Address(address: input.address);
    final cachedState = input.cachedState == null
        ? null
        : nr.FullContractState.fromJson(input.cachedState!.toJson());
    final contractState = cachedState ??
        await nekotonRepository.currentTransport.transport
            .getFullContractState(address);

    if (contractState == null) {
      throw Exception(
        LocaleKeys.accountNotFound.tr(args: [address.address]),
      );
    }

    if (!contractState.isDeployed || contractState.lastTransactionId == null) {
      throw s.ApprovalsHandleException(LocaleKeys.accountNotDeployed.tr());
    }

    final signatureId = await _computeSignatureId(input.withSignatureId);

    final executionOutput = await nr.runGetter(
      accountStuffBoc: contractState.boc,
      contractAbi: input.getterCall.abi,
      methodId: input.getterCall.getter,
      input: input.getterCall.params,
      signatureId: signatureId,
    );

    return RunGetterOutput(executionOutput.output, executionOutput.code);
  }

  Future<List<ConnectionData>> _getConnections(int networkId) async {
    final connections = connectionsStorageService.connections;
    final networksIds = connectionsStorageService.networksIds;
    final list = <ConnectionData>[];
    final update = <(String, int)>[];

    for (final connection in connections) {
      nr.Transport? transport;

      try {
        var id = networksIds[connection.id];

        // connect to get network id
        if (id == null) {
          transport = await connectionService.createTransportByConnection(
            connection,
          );

          id = transport.networkId;
          update.add((connection.id, transport.networkId));
        }

        if (id == networkId) {
          list.add(connection);
        }
      } catch (e) {
        _logger.severe('Error getting network id for connection: '
            '${connection.name} (${connection.id})');
      } finally {
        await transport?.dispose();
      }
    }

    if (update.isNotEmpty) {
      connectionsStorageService.updateNetworksIds(update);
    }

    return list;
  }

  Future<int?> _computeSignatureId(Object? withSignatureId) async {
    final signatureId = withSignatureId == true
        ? await nekotonRepository.currentTransport.transport.getSignatureId()
        : withSignatureId == false
            ? null
            : withSignatureId != null && withSignatureId is num
                ? withSignatureId.toInt()
                : null;
    return signatureId;
  }
}

nr.IgnoreTransactionTreeSimulationError
    _mapIgnoreTransactionTreeSimulationError(
  IgnoreTransactionTreeSimulationError error,
) =>
        nr.IgnoreTransactionTreeSimulationError(
          code: error.code.toInt(),
          address: error.address?.let(
            (address) => nr.Address(address: address),
          ),
        );
