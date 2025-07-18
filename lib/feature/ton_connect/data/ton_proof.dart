import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton_proof.freezed.dart';
part 'ton_proof.g.dart';

@freezed
abstract class TonProof with _$TonProof {
  const factory TonProof({
    /// 64-bit unix epoch time of the signing operation (seconds)
    required String timestamp,
    required String signature,
    required String payload,
    required TonProofDomain domain,
  }) = _TonProof;

  factory TonProof.fromJson(Map<String, dynamic> json) =>
      _$TonProofFromJson(json);
}
