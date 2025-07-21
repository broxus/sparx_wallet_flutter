class LedgerException implements Exception {
  const LedgerException(this.message);

  final String message;

  @override
  String toString() => 'LedgerException: $message';
}
