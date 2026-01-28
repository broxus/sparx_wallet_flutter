import 'package:app/feature/ton_connect/domain/session_crypto.dart';
import 'package:test/test.dart';

void main() {
  group('SessionCrypto', () {
    test('encrypts and decrypts symmetrically', () {
      // Arrange
      final sender = SessionCrypto();
      final receiver = SessionCrypto();
      const message = 'hello ton connect';

      // Act
      final encrypted = sender.encrypt(message, receiver.sessionId);
      final decrypted = receiver.decrypt(encrypted, sender.sessionId);

      // Assert
      expect(decrypted, message);
    });

    test('restores private key from json and preserves session id', () {
      // Arrange
      final original = SessionCrypto();

      // Act
      final restored = SessionCrypto.fromJson(original.toJson());

      // Assert
      expect(restored.sessionId, original.sessionId);
      expect(restored.toJson(), original.toJson());
    });
  });
}
