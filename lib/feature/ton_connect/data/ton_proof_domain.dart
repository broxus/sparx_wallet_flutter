import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton_proof_domain.freezed.dart';
part 'ton_proof_domain.g.dart';

@freezed
abstract class TonProofDomain with _$TonProofDomain {
  factory TonProofDomain({required num lengthBytes, required String value}) =
      _TonProofDomain;

  factory TonProofDomain.fromJson(Map<String, dynamic> json) =>
      _$TonProofDomainFromJson(json);
}
