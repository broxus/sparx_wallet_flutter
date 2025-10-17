import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class KeyDetailPageModel extends ElementaryModel {
  KeyDetailPageModel(ErrorHandler errorHandler, this._nekotonRepository)
    : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  Stream<Seed?> seedStreamForKey(PublicKey publicKey) => _nekotonRepository
      .seedListStream
      .map((list) => list.findSeedByAnyPublicKey(publicKey));
}
