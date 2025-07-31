import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money2/money2.dart';
import 'package:ui_components_lib/components/input/currency_text_input_formatter.dart';

void main() {
  group('CurrencyTextInputFormatter', () {
    late CurrencyTextInputFormatter formatter;
    late Currency currency;

    setUp(() {
      currency = Currency.create('USD', 2);
    });

    group('Basic functionality', () {
      setUp(() {
        formatter = CurrencyTextInputFormatter(currency);
      });

      test('should allow valid integer input', () {
        const oldValue = TextEditingValue.empty;
        const newValue = TextEditingValue(
          text: '123',
          selection: TextSelection.collapsed(offset: 3),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123'));
        expect(result.selection.start, equals(3));
      });

      test('should allow valid decimal input', () {
        const oldValue = TextEditingValue.empty;
        const newValue = TextEditingValue(
          text: '123.45',
          selection: TextSelection.collapsed(offset: 6),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123.45'));
        expect(result.selection.start, equals(6));
      });

      test('should reject invalid input', () {
        const oldValue = TextEditingValue(
          text: '123',
          selection: TextSelection.collapsed(offset: 3),
        );
        const newValue = TextEditingValue(
          text: '123abc',
          selection: TextSelection.collapsed(offset: 6),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123'));
        expect(result.selection.start, equals(3));
      });

      test('should handle empty input', () {
        const oldValue = TextEditingValue(text: '123');
        const newValue = TextEditingValue(
          selection: TextSelection.collapsed(offset: 0),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals(''));
        expect(result.selection.start, equals(0));
      });
    });

    group('Decimal separator handling (EWM-398)', () {
      setUp(() {
        formatter = CurrencyTextInputFormatter(
          currency,
          decimalSeparators: ['.', ','],
        );
      });

      test('should prepend 0 when comma is entered as first character', () {
        const oldValue = TextEditingValue.empty;
        const newValue = TextEditingValue(
          text: ',',
          selection: TextSelection.collapsed(offset: 1),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('0,'));
        expect(result.selection.start, equals(2));
      });

      test('should prepend 0 when dot is entered as first character', () {
        const oldValue = TextEditingValue.empty;
        const newValue = TextEditingValue(
          text: '.',
          selection: TextSelection.collapsed(offset: 1),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('0.'));
        expect(result.selection.start, equals(2));
      });

      test('should handle comma followed by digits', () {
        const oldValue = TextEditingValue.empty;
        const newValue = TextEditingValue(
          text: ',5',
          selection: TextSelection.collapsed(offset: 2),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('0,5'));
        expect(result.selection.start, equals(3));
      });

      test('should handle dot followed by digits', () {
        const oldValue = TextEditingValue.empty;
        const newValue = TextEditingValue(
          text: '.25',
          selection: TextSelection.collapsed(offset: 3),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('0.25'));
        expect(result.selection.start, equals(4));
      });

      test('should not affect normal input with integer part', () {
        const oldValue = TextEditingValue.empty;
        const newValue = TextEditingValue(
          text: '1.5',
          selection: TextSelection.collapsed(offset: 3),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('1.5'));
        expect(result.selection.start, equals(3));
      });

      test('should not prepend 0 when separator is not first character', () {
        const oldValue = TextEditingValue(text: '12');
        const newValue = TextEditingValue(
          text: '12.5',
          selection: TextSelection.collapsed(offset: 4),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('12.5'));
        expect(result.selection.start, equals(4));
      });

      test('should handle multiple decimal places within scale limit', () {
        const oldValue = TextEditingValue(text: '0.');
        const newValue = TextEditingValue(
          text: '0.99',
          selection: TextSelection.collapsed(offset: 4),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('0.99'));
        expect(result.selection.start, equals(4));
      });

      test('should reject input exceeding decimal scale', () {
        const oldValue = TextEditingValue(
          text: '0.99',
          selection: TextSelection.collapsed(offset: 4),
        );
        const newValue = TextEditingValue(
          text: '0.999',
          selection: TextSelection.collapsed(offset: 5),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('0.99'));
        expect(result.selection.start, equals(4));
      });
    });

    group('Ticker support', () {
      setUp(() {
        formatter = CurrencyTextInputFormatter(
          currency,
          includeTicker: true,
          decimalSeparators: ['.'],
        );
      });

      test('should append ticker to valid input', () {
        const oldValue = TextEditingValue.empty;
        const newValue = TextEditingValue(
          text: '123.45',
          selection: TextSelection.collapsed(offset: 6),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('123.45 USD'));
        expect(result.selection.start, equals(6));
      });

      test('should append ticker when prepending 0 for decimal separator', () {
        const oldValue = TextEditingValue.empty;
        const newValue = TextEditingValue(
          text: '.',
          selection: TextSelection.collapsed(offset: 1),
        );

        final result = formatter.formatEditUpdate(oldValue, newValue);

        expect(result.text, equals('0. USD'));
        expect(result.selection.start, equals(2));
      });
    });

    group('RegExp creation', () {
      test('should create correct regex for currency with decimal places', () {
        final regex = CurrencyTextInputFormatter.createRegExp(
          currency: currency,
          allowNegative: false,
          includeTicker: false,
          decimalSeparators: ['.', ','],
        );

        expect(regex.hasMatch('123'), isTrue);
        expect(regex.hasMatch('123.45'), isTrue);
        expect(regex.hasMatch('123,45'), isTrue);
        expect(regex.hasMatch('123.456'), isFalse); // exceeds scale
        expect(regex.hasMatch('abc'), isFalse);
        expect(regex.hasMatch(''), isTrue);
      });

      test('should create correct regex for currency without decimal places',
          () {
        final noCurrencyFormat = Currency.create('JPY', 0);
        final regex = CurrencyTextInputFormatter.createRegExp(
          currency: noCurrencyFormat,
          allowNegative: false,
          includeTicker: false,
        );

        expect(regex.hasMatch('123'), isTrue);
        expect(regex.hasMatch('123.45'), isFalse); // no decimals allowed
        expect(regex.hasMatch(''), isTrue);
      });
    });
  });
}
