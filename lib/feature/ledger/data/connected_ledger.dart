import 'package:app/feature/ledger/ledger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'connected_ledger.freezed.dart';
part 'connected_ledger.g.dart';

@freezed
abstract class ConnectedLedger with _$ConnectedLedger {
  const factory ConnectedLedger({
    required String remoteId,
    required PublicKey masterKey,
    required DeviceModelId deviceModelId,
  }) = _ConnectedLedger;

  factory ConnectedLedger.fromJson(Map<String, dynamic> json) =>
      _$ConnectedLedgerFromJson(json);
}
