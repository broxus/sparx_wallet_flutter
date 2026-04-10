import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class AddNewExternalAccountSheetModel extends ElementaryModel {
  AddNewExternalAccountSheetModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  Future<void> addExternalAccount({
    required Address address,
    required PublicKey publicKey,
    String? name,
  }) => _nekotonRepository.addExternalAccount(
    address: address,
    publicKey: publicKey,
    name: name,
  );

  void showError(String text) => handleError(text);
}
