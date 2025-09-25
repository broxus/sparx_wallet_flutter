import 'dart:async';

import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/token_wallet_send/token_wallet_send.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

abstract class TokenTransferDelegate {
  Future<PreparedTokenTransfer> prepareTransfer({
    required Address owner,
    required Address rootTokenContract,
    required PublicKey publicKey,
    required Address destination,
    required BigInt amount,
    BigInt? attachedAmount,
    String? comment,
    bool? notifyReceiver,
  });

  Future<TokenTransactionCompleter> sendMessage({
    required PreparedTokenTransfer transfer,
    required TokenTransferSigner signer,
  });

  Future<Fee> estimateFees(PreparedTokenTransfer transfer);

  Future<List<TxTreeSimulationErrorItem>> simulateTransactionTree(
    PreparedTokenTransfer transfer,
  );
}

abstract class TokenTransferSigner {
  Future<SignedMessage> signMessage(UnsignedMessage unsignedMessage);

  Future<String> signDataRaw(String data);
}

final class TokenTransactionCompleter {
  const TokenTransactionCompleter(this._completer);

  final Completer<void> _completer;

  Future<void> get future => _completer.future;
}
