import 'package:app/utils/url_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UrlValidator', () {
    test('checkString returns true for valid URLs', () {
      final validUrls = [
        'https://example.com',
        'http://example.com',
        'ftp://example.com',
        'www.example.com',
        'example.com',
        'https://example.com/path?query=param',
      ];

      for (final url in validUrls) {
        expect(
          UrlValidator.checkString(url),
          isTrue,
          reason: 'Failed on: $url',
        );
      }
    });

    test('checkString returns false for invalid URLs', () {
      final invalidUrls = [
        'htp://invalid-url',
        'invalid',
        '://missing.protocol.com',
        'http//missingcolon.com',
        'example.123',
        'example. 123',
        'example .123',
        'example . 123',
        '',
      ];

      for (final url in invalidUrls) {
        expect(
          UrlValidator.checkString(url),
          isFalse,
          reason: 'Failed on: $url',
        );
      }
    });

    test('checkUri correctly validates Uri objects', () {
      final validUri = Uri.parse('https://valid.com');
      final invalidUri = Uri.parse('htp:/invalid');

      expect(UrlValidator.checkUri(validUri), isTrue);
      expect(UrlValidator.checkUri(invalidUri), isFalse);
    });
  });
}
