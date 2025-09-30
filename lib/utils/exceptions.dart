final class UiException implements Exception {
  const UiException(this.message);

  final String message;

  @override
  String toString() => message;
}
