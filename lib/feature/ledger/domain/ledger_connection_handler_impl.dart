import 'dart:typed_data';

import 'package:app/feature/ledger/ledger.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@singleton
class LedgerConnectionHandlerImpl implements LedgerConnectionHandler {
  LedgerAppInterface? _appInterface;

  LedgerAppInterface? get appInterface => _appInterface;

  Future<void> setAppInterface(LedgerAppInterface? appInterface) async {
    if (_appInterface != null &&
        _appInterface!.device.remoteId != appInterface?.device.remoteId) {
      await _appInterface?.dispose();
    }

    _appInterface = appInterface;
  }

  @override
  Future<Uint8List> getPublicKey(int accountId) {
    if (_appInterface == null) {
      throw const LedgerException('Ledger app interface is not set');
    }

    return _appInterface!.getPublicKey(accountId);
  }

  @override
  Future<Uint8List> sign({
    required int accountId,
    required List<int> message,
    int? signatureId,
  }) {
    if (_appInterface == null) {
      throw const LedgerException('Ledger app interface is not set');
    }

    return _appInterface!.sign(
      accountId: accountId,
      message: message,
      signatureId: signatureId,
    );
  }

  @override
  Future<Uint8List> signTransaction({
    required int accountId,
    required int wallet,
    required List<int> message,
    required LedgerSignatureContext context,
    int? signatureId,
  }) {
    if (_appInterface == null) {
      throw const LedgerException('Ledger app interface is not set');
    }

    return _appInterface!.signTransaction(
      accountId: accountId,
      wallet: wallet,
      message: message,
      context: context,
      signatureId: signatureId,
    );
  }
}
