import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/add_seed/add_seed.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/constants.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

typedef SuggestionSelectedCallback = void Function(
  String suggestion,
  int index,
);

class EnterSeedWmParams {
  EnterSeedWmParams({required this.isOnboarding, required this.seedName});

  final bool isOnboarding;
  final String? seedName;
}

/// [WidgetModel] для [EnterSeedPhraseWidget]
@injectable
class EnterSeedPhraseWidgetModel extends CustomWidgetModelParametrized<
    EnterSeedPhraseWidget, EnterSeedPhraseModel, EnterSeedWmParams> {
  EnterSeedPhraseWidgetModel(
    super.model,
  );

  static final _log = Logger('EnterSeedPhraseWidgetModel');

  final formKey = GlobalKey<FormState>();

  late final List<EnterSeedPhraseInputData> _inputDataList = List.unmodifiable(
    Iterable.generate(
      model.seedPhraseWordsCount.max,
      (i) => EnterSeedPhraseInputData.init(i)
        ..controller.addListener(() {
          final isExistText = _inputDataList.any(
            (data) => data.text.isNotEmpty,
          );

          if (displayPasteButtonState.value == isExistText) {
            _displayPasteButtonState.accept(!isExistText);
          }

          if (isExistText) {
            _checkDebugPhraseGenerating();
          }

          _checkInputCompletion(i);
        })
        ..focusNode.addListener(() => _checkInputCompletion(i)),
    ),
  );

  late final _displayPasteButtonState = createNotifier<bool>(true);
  late final _tabState = createNotifier<EnterSeedPhraseTabData>(
    () {
      final currentValue = model.seedPhraseWordsCount.first;

      return EnterSeedPhraseTabData(
        currentValue: currentValue,
        inputs: _inputDataList.take(currentValue).toList(),
      );
    }(),
  );
  late final _seedPhraseFormatState = createNotifier(
    networkType.isTon || networkGroup == 'hmstr_mainnet'
        ? SeedPhraseFormat.ton
        : SeedPhraseFormat.standard,
  );

  ColorsPalette get colors => context.themeStyle.colors;

  ThemeStyleV2 get themeStyleV2 => context.themeStyleV2;

  double get bottomPadding => MediaQuery.of(context).viewInsets.bottom;

  bool get isExistBottomPadding => bottomPadding >= commonButtonHeight;

  ListenableState<bool> get displayPasteButtonState => _displayPasteButtonState;

  ListenableState<EnterSeedPhraseTabData> get tabState => _tabState;

  EnterSeedPhraseTabData? get _tabData => _tabState.value;

  String get networkGroup => model.networkGroup;

  NetworkType get networkType => model.networkType;

  ListenableState<SeedPhraseFormat> get seedPhraseFormatState =>
      _seedPhraseFormatState;

  List<int> get seedPhraseWordsCount => model.seedPhraseWordsCount;

  int get _currentValue =>
      _tabState.value?.currentValue ?? model.seedPhraseWordsCount.first;

  MnemonicType get _mnemonicType => getMnemonicType(
        format: _seedPhraseFormatState.value,
        wordsCount: _currentValue,
      );

  @override
  void dispose() {
    for (final c in _inputDataList) {
      c.dispose();
    }

    super.dispose();
  }

  void onPressedResetFocus() => resetFocus(contextSafe);

  /// Callback for UI TextField widget
  List<String> onSuggestions(String text) {
    if (text.isEmpty) return [];
    final hints = model.getHints(text);
    if (hints.length == 1 && hints[0] == text) {
      return [];
    }

    return hints;
  }

  void changeTab(int value) {
    if (value == _currentValue) return;

    final tabData = _tabData;

    if (tabData == null) {
      return;
    }

    _clearAllInputs();
    _resetErrors();

    formKey.currentState?.reset();

    _tabState.accept(
      tabData.copyWith(
        currentValue: value,
        inputs: _inputDataList.take(value).toList(),
      ),
    );

    _displayPasteButtonState.accept(true);
  }

  Future<void> confirm() async {
    if (!await model.checkConnection(context)) {
      return;
    }

    if (_validateFormWithError()) {
      try {
        FocusManager.instance.primaryFocus?.unfocus();

        final phrase = _getPhrase();

        deriveFromPhrase(
          phrase: phrase,
          mnemonicType: _mnemonicType,
        );
        _next(phrase);
      } on AnyhowException catch (e, s) {
        _log.severe('confirmAction AnyhowException', e, s);
        model.showError(LocaleKeys.wrongSeed.tr());
      } on Exception catch (e, s) {
        _log.severe('confirmAction', e, s);
        model.showError(e.toString());
      }
    }
  }

  /// [index] starts with 0
  void nextOrConfirm(int index) {
    if (index == _currentValue - 1) {
      confirm();
    } else if (index + 1 < _inputDataList.length) {
      _inputDataList[index + 1].focusNode.requestFocus();
    }
  }

  void clearFields() {
    for (final data in _inputDataList) {
      data.clear();
    }
    _resetFormAndError();
  }

  /// [index] start with 0
  void onSuggestionSelected(
    String suggestion,
    int index,
  ) {
    _inputDataList[index].controller
      ..text = suggestion
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: suggestion.length),
      );

    nextOrConfirm(index);
  }

  /// Reset text of controller that triggers [_checkInputCompletion]
  void clearField(int index) => _inputDataList[index].clear();

  Future<void> pastePhrase() async {
    final words = await getSeedListFromClipboard();
    final count = words.length;

    if ((count == actualSeedPhraseLength || count == legacySeedPhraseLength) &&
        count <= seedPhraseWordsCount.max) {
      changeTab(count);
    } else {
      model.showError(LocaleKeys.incorrectWordsFormat.tr());
      return;
    }

    if (words.isNotEmpty && words.length == _currentValue) {
      for (final word in words) {
        if (!model.checkIsWordValid(word)) {
          words.clear();
          break;
        }
      }
    } else {
      words.clear();
    }

    if (words.isEmpty) {
      _resetFormAndError();
      model.showError(LocaleKeys.incorrectWordsFormat.tr());
      return;
    }

    try {
      if (words.length > _inputDataList.length) {
        words.length = _inputDataList.length;
      }

      for (var i = 0; i < words.length; i++) {
        final word = words[i];
        _inputDataList[i].controller.value = TextEditingValue(
          text: word,
          selection: TextSelection.fromPosition(
            TextPosition(offset: word.length),
          ),
        );
      }
    } catch (_) {}

    _tryCheckMnemonicType();
    _validateFormWithError();
  }

  void onSeedPhraseFormatChanged(SeedPhraseFormat format) =>
      _seedPhraseFormatState.accept(format);

  /// Check if debug phrase is entered in any text field
  void _checkDebugPhraseGenerating() {
    if (!_inputDataList.any((data) => data.text == 'speakfriendandenter')) {
      return;
    }

    final key = model.getKey(_mnemonicType);
    final count = _inputDataList.take(_currentValue).length;

    for (var i = 0; i < count; i++) {
      final text = key.words[i];
      _inputDataList[i].controller
        ..text = text
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: text.length),
        );
    }

    _validateFormWithError();
  }

  /// If input with [index] has any text and it's not in focus
  void _checkInputCompletion(int index) {
    final data = _inputDataList[index];

    if (data.text.isNotEmpty && !data.isFocused) {
      _inputDataList[index].isError = false;

      _updateTab();
    }
  }

  void _next(String phrase) {
    if (wmParams.value.isOnboarding) {
      context.compassContinue(
        CreateSeedOnboardingPasswordRouteData(
          seedPhrase: phrase,
          mnemonicType: _mnemonicType,
        ),
      );
    } else {
      context.compassContinue(
        CreateSeedPasswordRouteData(
          seedPhrase: phrase,
          mnemonicType: _mnemonicType,
          type: SeedAddType.import,
          name: wmParams.value.seedName,
        ),
      );
    }
  }

  /// Validate form and return its status.
  /// It also updates state of cubit if there was some errors.
  ///
  /// Returns true if there was no any error, false otherwise.
  bool _validateFormWithError() {
    final isEmptyFields = !(formKey.currentState?.validate() ?? false);
    var isWrongWords = false;

    for (var index = 0; index < _currentValue; index++) {
      final input = _inputDataList[index];
      if (!model.checkIsWordValid(input.text)) {
        isWrongWords = true;
        _inputDataList[index].isError = true;
      }
    }

    _updateTab();

    if (isEmptyFields) {
      model.showError(LocaleKeys.fillMissingWords.tr());
    } else if (isWrongWords) {
      model.showError(LocaleKeys.incorrectWordsFormat.tr());
    }

    return !isEmptyFields && !isWrongWords;
  }

  /// Drop form validation state
  void _resetFormAndError() {
    formKey.currentState?.reset();
    var isChanged = false;

    try {
      for (var index = 0; index < _currentValue; index++) {
        if (_inputDataList[index].isError) {
          isChanged = true;
          _inputDataList[index].isError = false;
        }
      }
    } finally {
      if (isChanged) {
        _updateTab();
      }
    }
  }

  void _resetErrors() {
    for (final data in _inputDataList) {
      data.isError = false;
    }
  }

  void _updateTab() {
    final data = _tabData;
    if (data == null) {
      return;
    }

    var inputs = data.inputs;

    if (data.inputs.length != _currentValue) {
      inputs = _inputDataList.take(_currentValue).toList();
    }

    _tabState.accept(
      data.copyWith(inputs: inputs),
    );
  }

  void _clearAllInputs() {
    for (final data in _inputDataList) {
      data.controller.clear();
    }
  }

  String _getPhrase() {
    final buffer = StringBuffer();

    for (var i = 0; i < _currentValue; i++) {
      buffer
        ..write(_inputDataList[i].text.trim())
        ..write(' ');
    }

    return buffer.toString().trimRight();
  }

  void _tryCheckMnemonicType() {
    // don't check if 12 words or MnemonicType.legacy()
    if (_currentValue == actualSeedPhraseLength ||
        _seedPhraseFormatState.value == SeedPhraseFormat.standard) {
      return;
    }

    final phrase = _getPhrase();

    try {
      deriveFromPhrase(
        phrase: phrase,
        mnemonicType: _mnemonicType,
      );
    } catch (_) {
      try {
        deriveFromPhrase(
          phrase: phrase,
          mnemonicType: const MnemonicType.legacy(),
        );
        // if no exception, then it's legacy
        _seedPhraseFormatState.accept(SeedPhraseFormat.standard);
      } catch (_) {}
    }
  }
}
