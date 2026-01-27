import 'package:app/generated/generated.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show Address;

final _validCrosschainPairs = <(int, int)>{(0, -1), (-1, 0), (1, -1), (-1, 1)};

class CrosschainTransferValidator {
  static CrosschainTransferValidationResult validate({
    required int fromWorkchain,
    required int toWorkchain,
  }) => CrosschainTransferValidationResult(
    from: fromWorkchain,
    to: toWorkchain,
    isValid: _validate(from: fromWorkchain, to: toWorkchain),
  );

  static CrosschainTransferValidationResult validateByAddress({
    required int fromWorkchain,
    required Address toAddress,
  }) {
    final toWorkchain = toAddress.workchain;
    return validate(fromWorkchain: fromWorkchain, toWorkchain: toWorkchain);
  }

  static bool _validate({required int from, required int to}) =>
      from == to || _validCrosschainPairs.contains((from, to));
}

class CrosschainTransferValidationResult {
  const CrosschainTransferValidationResult({
    required this.from,
    required this.to,
    required this.isValid,
  });

  final int from;
  final int to;
  final bool isValid;

  String? get errorMessage => isValid
      ? null
      : LocaleKeys.invalidWorkchainAddress.tr(
          args: [from.toString(), to.toString()],
        );
}
