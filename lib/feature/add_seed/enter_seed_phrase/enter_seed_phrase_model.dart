import 'package:app/app/service/service.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase_widget.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/utils/mixins/connection_mixin.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' as nt;

/// [ElementaryModel] for [EnterSeedPhraseWidget]
class EnterSeedPhraseModel extends ElementaryModel with ConnectionMixin {
  EnterSeedPhraseModel(
    ErrorHandler errorHandler,
    this.networkConnectionService,
    this.messengerService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  @override
  final NetworkConnectionService networkConnectionService;
  @override
  final MessengerService messengerService;
  final nt.NekotonRepository _nekotonRepository;

  Set<String>? _hints;

  String get networkGroup => _nekotonRepository.currentTransport.networkGroup;

  List<int> get seedPhraseWordsCount =>
      _nekotonRepository.currentTransport.seedPhraseWordsCount;

  nt.GeneratedKeyG getKey(nt.MnemonicType mnemonicType) {
    return nt.generateKey(
      accountType: mnemonicType,
    );
  }

  List<String> getHints(String text) => nt.getHints(input: text);

  /// [text] is valid if it is in list of hints for this word.
  bool checkIsWordValid(String text) {
    final hints = _hints ??= nt.getHints(input: '').toSet();
    return hints.contains(text);
  }

  void showError(String text) => handleError(text);
}
