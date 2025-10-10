import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class ExportSeedSheetModel extends ElementaryModel {
  ExportSeedSheetModel(ErrorHandler errorHandler, this._nekotonRepository)
    : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  /// Export seed phrase for the given [publicKey] using [password].
  ///
  /// Throws [SeedMissingException] if seed is not found and
  /// [WrongPasswordException] if export fails (typically due to wrong password)
  Future<List<String>> exportSeedPhrase(
    PublicKey publicKey,
    String password,
  ) async {
    final seed = _nekotonRepository.seedList.findSeed(publicKey);
    if (seed == null) {
      throw SeedMissingException();
    }

    try {
      return await seed.export(password);
    } catch (_) {
      // Typically means wrong password; align with prior Cubit behavior.
      throw WrongPasswordException();
    }
  }

  // Expose error handling to WM via a simple method.
  void showError(String text) => handleError(text);
}

class SeedMissingException implements Exception {}

class WrongPasswordException implements Exception {}
