import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@singleton
class LedgerConnectionHandlerImpl implements LedgerConnectionHandler {
  @override
  Future<List<int>> getPublicKey(int accountId) {
    throw UnimplementedError();
  }

  @override
  Future<List<int>> sign({
    required int accountId,
    required List<int> message,
    int? signatureId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<int>> signTransaction({
    required int accountId,
    required int wallet,
    required List<int> message,
    required LedgerSignatureContext context,
    int? signatureId,
  }) {
    throw UnimplementedError();
  }
}
