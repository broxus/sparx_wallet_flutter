import 'package:app/feature/ton_connect/data/ton_connect_error_code.dart';

class TonConnectException implements Exception {
  TonConnectException({required this.code, required this.message});

  final TonConnectErrorCode code;
  final String message;
}
