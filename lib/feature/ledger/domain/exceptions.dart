class LedgerException implements Exception {
  LedgerException(this.message);

  final String message;

  @override
  String toString() => 'LedgerException: $message';
}
