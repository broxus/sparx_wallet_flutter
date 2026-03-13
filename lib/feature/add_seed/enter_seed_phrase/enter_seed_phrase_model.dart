import 'package:app/app/service/service.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/data/english_words.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase_widget.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/utils/mixins/connection_mixin.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' as nt;

/// [ElementaryModel] for [EnterSeedPhraseWidget]
@injectable
class EnterSeedPhraseModel extends ElementaryModel with ConnectionMixin {
  EnterSeedPhraseModel(
    ErrorHandler errorHandler,
    this.networkConnectionService,
    this.messengerService,
    this._nekotonRepository,
    this._secureStringService,
  ) : super(errorHandler: errorHandler);

  @override
  final NetworkConnectionService networkConnectionService;
  @override
  final MessengerService messengerService;
  final nt.NekotonRepository _nekotonRepository;
  final SecureStringService _secureStringService;

  Set<String>? _hints;

  // String get networkGroup => _nekotonRepository.currentTransport.networkGroup;
  String get networkGroup => 'ever';

  // NetworkType get networkType =>
  //     _nekotonRepository.currentTransport.networkType;

  NetworkType get networkType => NetworkType.ever;

  // List<int> get seedPhraseWordsCount =>
  //     _nekotonRepository.currentTransport.seedPhraseWordsCount;

  List<int> get seedPhraseWordsCount => [12, 24];

  nt.GeneratedKeyG getKey(nt.MnemonicType mnemonicType) {
    return nt.GeneratedKeyG(
      words: List.generate(12, (i) => i.toString()),
      accountType: const nt.MnemonicType.legacy(),
    );
    // return nt.generateKey(accountType: mnemonicType);
  }

  // List<String> getHints(String text) => nt.getHints(input: text);
  List<String> getHints(String text) => words;

  /// [text] is valid if it is in list of hints for this word.
  bool checkIsWordValid(String text) {
    final hints = _hints ??= nt.getHints(input: '').toSet();
    return hints.contains(text);
  }

  void showError(String text) => handleError(text);

  Future<SecureString> encryptSeed(String phrase) =>
      _secureStringService.encrypt(phrase);
}
