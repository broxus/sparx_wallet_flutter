import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class WalletMultisigConfigModel extends ElementaryModel {
  WalletMultisigConfigModel(
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  /// Validates the number of required confirmations
  bool validateRequireConfirmations(
    int requireConfirmations,
    int custodiansCount,
  ) {
    return requireConfirmations > 0 && requireConfirmations <= custodiansCount;
  }

  bool validateHours(int hours) {
    return hours > 0 && hours <= 24;
  }

  bool validateConfig({
    required List<PublicKey> custodians,
    required int requireConfirmations,
    required int hours,
  }) {
    return validateRequireConfirmations(
          requireConfirmations,
          custodians.length,
        ) &&
        validateHours(hours);
  }
}
