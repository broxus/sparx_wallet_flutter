import 'package:app/data/models/fee.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'prepared_token_transfer.freezed.dart';

@freezed
sealed class PreparedTokenTransfer with _$PreparedTokenTransfer {
  const factory PreparedTokenTransfer.basic({
    required UnsignedMessage unsignedMessage,
    required Address destination,
    required BigInt attachedAmount,
    required Address owner,
    required Address rootTokenContract,
  }) = PreparedTokenTransferBasic;

  const factory PreparedTokenTransfer.gasless({
    required BigInt amount,
    required String hash,
    required String payload,
    required Address destination,
    required Address owner,
    required Address rootTokenContract,
    required Fee fee,
    required PublicKey publicKey,
  }) = PreparedTokenTransferGasless;
}
