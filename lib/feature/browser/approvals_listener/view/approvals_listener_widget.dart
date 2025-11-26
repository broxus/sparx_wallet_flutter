import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/approvals_listener/approvals_listener.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart' show AddNetwork, Network;

/// UI-based listener, that listens for events from [BrowserApprovalsService]
/// and open dialogs/pages, specified for this actions, allowing user to
/// handle them.
/// This widget listen for events from all browser-tabs.
///
/// This listener handles requests and returns result to the completer, that
/// comes for r, sending this data to the caller function.
class ApprovalsListenerWidget extends StatefulWidget {
  const ApprovalsListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  State<ApprovalsListenerWidget> createState() =>
      _ApprovalsListenerWidgetState();
}

class _ApprovalsListenerWidgetState extends State<ApprovalsListenerWidget> {
  late final BrowserApprovalsService approvalsService = inject();
  StreamSubscription<dynamic>? _streamSubscription;

  @override
  // ignore: long-method
  void initState() {
    _streamSubscription = approvalsService.approvalsStream.listen(
      (r) => switch (r) {
        ApprovalRequestPermissions() => requestPermissions(
          origin: r.origin,
          permissions: r.permissions,
          completer: r.completer,
        ),
        ApprovalRequestChangeAccount() => changeAccount(
          origin: r.origin,
          permissions: r.permissions,
          previousSelectedAccount: r.previousSelectedAccount,
          completer: r.completer,
        ),
        ApprovalRequestAddTip3Token() => addTip3Token(
          origin: r.origin,
          account: r.account,
          details: r.details,
          completer: r.completer,
        ),
        ApprovalRequestSignData() => signData(
          origin: r.origin,
          account: r.account,
          publicKey: r.publicKey,
          data: r.data,
          signInputAuthLedger: r.signInputAuthLedger,
          completer: r.completer,
        ),
        ApprovalRequestEncryptData() => encryptData(
          origin: r.origin,
          account: r.account,
          publicKey: r.publicKey,
          data: r.data,
          completer: r.completer,
        ),
        ApprovalRequestDecryptData() => decryptData(
          origin: r.origin,
          account: r.account,
          recipientPublicKey: r.recipientPublicKey,
          sourcePublicKey: r.sourcePublicKey,
          completer: r.completer,
        ),
        ApprovalRequestCallContractMethod() => callContractMethod(
          origin: r.origin,
          account: r.account,
          publicKey: r.publicKey,
          recipient: r.recipient,
          payload: r.payload,
          signInputAuthLedger: r.signInputAuthLedger,
          completer: r.completer,
        ),
        ApprovalRequestSendMessage() => sendMessage(
          origin: r.origin,
          sender: r.sender,
          recipient: r.recipient,
          amount: r.amount,
          bounce: r.bounce,
          payload: r.payload,
          knownPayload: r.knownPayload,
          ignoredComputePhaseCodes: r.ignoredComputePhaseCodes,
          ignoredActionPhaseCodes: r.ignoredActionPhaseCodes,
          completer: r.completer,
        ),
        ApprovalRequestChangeNetwork() => changeNetwork(
          origin: r.origin,
          networkId: r.networkId,
          connections: r.connections,
          completer: r.completer,
        ),
        ApprovalRequestAddNetwork() => addNetwork(
          origin: r.origin,
          network: r.network,
          switchNetwork: r.switchNetwork,
          completer: r.completer,
        ),
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  /// Check existing current accounts and current key for some approval requests
  ///
  /// If there is no some data, ApprovalsHandleException will be thrown
  /// and dialog to add account will be shown if possible.
  void checkCurrentAccountsAndKey(BuildContext context) {
    final accounts = inject<CurrentAccountsService>().currentAccounts;

    if (accounts == null || accounts.allAccounts.isEmpty) {
      final currentKey = inject<CurrentKeyService>().currentKey;

      if (currentKey == null) {
        throw ApprovalsHandleException(LocaleKeys.noCurrentKey.tr());
      }

      if (context.mounted) {
        unawaited(
          showAddNewLocalAccountSheet(context: context, publicKey: currentKey),
        );
      }

      throw ApprovalsHandleException(LocaleKeys.noAccountsYet.tr());
    }
  }

  Future<void> requestPermissions({
    required Uri origin,
    required List<Permission> permissions,
    required Completer<Permissions> completer,
  }) async {
    try {
      checkCurrentAccountsAndKey(context);

      final result = await showRequestPermissionsSheet(
        context: context,
        origin: origin,
        permissions: permissions,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.notGranted.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> changeAccount({
    required Uri origin,
    required List<Permission> permissions,
    required Address? previousSelectedAccount,
    required Completer<Permissions> completer,
  }) async {
    try {
      checkCurrentAccountsAndKey(context);

      final result = await showChangeAccountSheet(
        context: context,
        permissions: permissions,
        origin: origin,
        previousSelectedAccount: previousSelectedAccount,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.notGranted.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> addTip3Token({
    required Uri origin,
    required Address account,
    required TokenContractAsset details,
    required Completer<void> completer,
  }) async {
    try {
      final result = await showAddTip3TokenSheet(
        context: context,
        origin: origin,
        account: account,
        details: details,
      );

      if (result) {
        completer.complete();
      } else {
        throw ApprovalsHandleException(LocaleKeys.notGranted.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> signData({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required String data,
    required SignInputAuthLedger signInputAuthLedger,
    required Completer<SignInputAuth> completer,
  }) async {
    try {
      final result = await showSignDataSheet(
        context: context,
        origin: origin,
        account: account,
        publicKey: publicKey,
        data: data,
        signInputAuthLedger: signInputAuthLedger,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.noPassword.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> encryptData({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required String data,
    required Completer<SignInputAuth> completer,
  }) async {
    try {
      final result = await showEncryptDataSheet(
        context: context,
        origin: origin,
        account: account,
        publicKey: publicKey,
        data: data,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.noPassword.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> decryptData({
    required Uri origin,
    required Address account,
    required PublicKey recipientPublicKey,
    required PublicKey sourcePublicKey,
    required Completer<SignInputAuth> completer,
  }) async {
    try {
      final result = await showDecryptDataSheet(
        context: context,
        origin: origin,
        account: account,
        recipientPublicKey: recipientPublicKey,
        sourcePublicKey: sourcePublicKey,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.noPassword.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> callContractMethod({
    required Uri origin,
    required Address account,
    required PublicKey publicKey,
    required Address recipient,
    required FunctionCall payload,
    required SignInputAuthLedger signInputAuthLedger,
    required Completer<SignInputAuth> completer,
  }) async {
    try {
      final result = await showCallContractMethodSheet(
        context: context,
        origin: origin,
        account: account,
        publicKey: publicKey,
        recipient: recipient,
        payload: payload,
        signInputAuthLedger: signInputAuthLedger,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.noPassword.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> sendMessage({
    required Uri origin,
    required Address sender,
    required Address recipient,
    required BigInt amount,
    required bool bounce,
    required FunctionCall? payload,
    required KnownPayload? knownPayload,
    required List<IgnoreTransactionTreeSimulationError>?
    ignoredComputePhaseCodes,
    required List<IgnoreTransactionTreeSimulationError>?
    ignoredActionPhaseCodes,
    required Completer<(PublicKey, SignInputAuth)> completer,
  }) async {
    try {
      final result = await showSendMessageSheet(
        context: context,
        origin: origin,
        sender: sender,
        recipient: recipient,
        amount: amount,
        bounce: bounce,
        payload: payload,
        knownPayload: knownPayload,
        ignoredComputePhaseCodes: ignoredComputePhaseCodes,
        ignoredActionPhaseCodes: ignoredActionPhaseCodes,
      );

      if (result != null) {
        completer.complete(result);
      } else {
        throw ApprovalsHandleException(LocaleKeys.noPassword.tr());
      }
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> changeNetwork({
    required Uri origin,
    required int networkId,
    required List<ConnectionData> connections,
    required Completer<TransportStrategy?> completer,
  }) async {
    try {
      final result = await showChangeNetworkSheet(
        context: context,
        origin: origin,
        networkId: networkId,
        connections: connections,
      );

      completer.complete(result);
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }

  Future<void> addNetwork({
    required Uri origin,
    required AddNetwork network,
    required bool switchNetwork,
    required Completer<Network?> completer,
  }) async {
    try {
      final result = await showAddNetworkSheet(
        context: context,
        origin: origin,
        network: network,
        switchNetwork: switchNetwork,
      );

      completer.complete(result);
    } catch (err, st) {
      completer.completeError(err, st);
    }
  }
}
