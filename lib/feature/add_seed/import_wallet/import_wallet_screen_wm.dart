// ignore_for_file: use_build_context_synchronously

import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/route.dart';
import 'package:app/feature/add_seed/import_wallet/data/import_wallet_data.dart';
import 'package:app/feature/add_seed/import_wallet/import_wallet_screen.dart';
import 'package:app/feature/add_seed/import_wallet/import_wallet_screen_model.dart';
import 'package:app/feature/constants.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

final seedSplitRegExp = RegExp(r'[ |;,:\n.]');

@injectable
class ImportWalletScreenWidgetModel
    extends CustomWidgetModel<ImportWalletScreen, ImportWalletScreenModel> {
  ImportWalletScreenWidgetModel(super.model) {
    _init();
  }

  late final screenState = createEntityNotifier<ImportWalletData?>()
    ..loading(ImportWalletData());
  late final _seedPhraseFormatState = createNotifier(
    networkType.isTon || networkGroup == 'hmstr_mainnet'
        ? SeedPhraseFormat.ton
        : SeedPhraseFormat.standard,
  );

  final _log = Logger('ImportWalletWidgetModel');
  Set<String>? _hints;

  String get networkGroup => model.networkGroup;

  NetworkType get networkType => model.networkType;

  ListenableState<SeedPhraseFormat> get seedPhraseFormatState =>
      _seedPhraseFormatState;

  ImportWalletData? get _data => screenState.value.data;

  int get _currentValue =>
      screenState.value.data?.selectedValue ?? model.allowedValues.first;

  MnemonicType get _mnemonicType => getMnemonicType(
    format: _seedPhraseFormatState.value,
    wordsCount: _currentValue,
  );

  Future<void> onPressedImport() async {
    if (!await model.checkConnection(context)) {
      return;
    }

    String? error;
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      final seed = screenState.value.data?.seed;

      if (seed != null && seed.isNotEmpty) {
        final phrase = seed.phrase;

        deriveFromPhrase(phrase: phrase, mnemonicType: _mnemonicType);

        if (!context.mounted) return;

        context.compassContinue(
          CreateSeedOnboardingPasswordRouteData(
            seedPhrase: await model.encryptSeed(phrase),
            mnemonicType: _mnemonicType,
          ),
        );
      } else {
        model.showValidateError(context, LocaleKeys.incorrectWordsFormat.tr());
      }
    } on FrbException catch (e, s) {
      _log.severe('confirmAction FrbException', e, s);
      error = LocaleKeys.wrongSeed.tr();
    } on Exception catch (e, s) {
      _log.severe('confirmAction', e, s);
      error = e.toString();
    }
    if (error != null) {
      model.showValidateError(context, error);
    }
  }

  void onChangeTab(int value) {
    _updateState(
      isPasted: false,
      selectedValue: value,
      seed: SeedPhraseModel.empty(),
    );
  }

  Future<void> pasteWords() async {
    var seed = SeedPhraseModel.fromWords(await getSeedListFromClipboard());

    if (seed.isNotEmpty) {
      for (final word in seed.words) {
        if (!_isWordValid(word)) {
          seed = SeedPhraseModel.empty();
          break;
        }
      }
    }

    switch (seed.wordsCount) {
      case actualSeedPhraseLength:
        onChangeTab(actualSeedPhraseLength);
      case legacySeedPhraseLength:
        onChangeTab(legacySeedPhraseLength);
      default:
        model.showValidateError(context, LocaleKeys.incorrectWordsFormat.tr());
        return;
    }

    final halfLength = (seed.wordsCount / 2).floor();

    final firstColumnWords = seed.words.sublist(0, halfLength);
    final secondColumnWords = seed.words.sublist(halfLength);

    _tryCheckMnemonicType(seed);
    _updateState(
      isPasted: true,
      seed: seed,
      firstColumnWords: firstColumnWords,
      secondColumnWords: secondColumnWords,
    );
  }

  void deleteWords() {
    _updateState(isPasted: false);
  }

  void onPressedManual() {
    context.compassContinue(
      const EnterSeedPhraseRouteData(isOnboarding: true, seedName: null),
    );
  }

  void onSeedPhraseFormatChanged(SeedPhraseFormat format) =>
      _seedPhraseFormatState.accept(format);

  void _init() {
    final allowedValues = model.allowedValues;
    if (model.allowedValues.isNotEmpty) {
      _updateState(allowedValues: allowedValues, selectedValue: _currentValue);
    }
  }

  void _updateState({
    bool? isPasted,
    List<int>? allowedValues,
    int? selectedValue,
    SeedPhraseModel? seed,
    List<String>? firstColumnWords,
    List<String>? secondColumnWords,
  }) {
    screenState.content(
      _data?.copyWith(
        isPasted: isPasted,
        allowedData: allowedValues,
        selectedValue: selectedValue,
        seed: seed,
        firstColumnWords: firstColumnWords,
        secondColumnWords: secondColumnWords,
      ),
    );
  }

  bool _isWordValid(String word) {
    final hints = _hints ??= getHints(input: '').toSet();
    return hints.contains(word);
  }

  void _tryCheckMnemonicType(SeedPhraseModel seed) {
    // don't check if 12 words or MnemonicType.legacy()
    if (seed.wordsCount == actualSeedPhraseLength ||
        _seedPhraseFormatState.value == SeedPhraseFormat.standard) {
      return;
    }

    try {
      deriveFromPhrase(phrase: seed.phrase, mnemonicType: _mnemonicType);
    } catch (_) {
      try {
        deriveFromPhrase(
          phrase: seed.phrase,
          mnemonicType: const MnemonicType.legacy(),
        );
        // if no exception, then it's legacy
        _seedPhraseFormatState.accept(SeedPhraseFormat.standard);
      } catch (_) {}
    }
  }
}
