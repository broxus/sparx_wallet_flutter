import 'package:freezed_annotation/freezed_annotation.dart';

part 'rpc_request.freezed.dart';
part 'rpc_request.g.dart';

@Freezed(unionKey: 'method')
sealed class RpcRequest with _$RpcRequest {
  @FreezedUnionValue('disconnect')
  const factory RpcRequest.disconnect({
    required String id,
    @Default([]) List<dynamic> params,
  }) = DisconnectRpcRequest;

  @FreezedUnionValue('sendTransaction')
  const factory RpcRequest.sendTransaction({
    required String id,
    required List<String> params,
  }) = SendTransactionRpcRequest;

  @FreezedUnionValue('signData')
  const factory RpcRequest.signData({
    required String id,
    required List<String> params,
  }) = SignDataRpcRequest;

  factory RpcRequest.fromJson(Map<String, dynamic> json) =>
      _$RpcRequestFromJson(json);
}
