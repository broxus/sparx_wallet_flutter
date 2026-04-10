import 'package:app/feature/add_seed/enter_seed_phrase/data/input_data.dart';
import 'package:flutter/cupertino.dart';

class EnterSeedPhraseTabData {
  EnterSeedPhraseTabData({required this.currentValue, required this.inputs});

  final int currentValue;
  final List<EnterSeedPhraseInputData> inputs;

  bool get isAllWordsExist {
    for (final i in inputs) {
      if (i.controller.text.isEmpty) {
        return false;
      }
    }

    return true;
  }

  void addTextChangeListener(VoidCallback onChanged) {
    removeTextChangeListener(onChanged);
    for (final i in inputs) {
      i.controller.addListener(onChanged);
    }
  }

  void removeTextChangeListener(VoidCallback onChanged) {
    for (final i in inputs) {
      i.controller.removeListener(onChanged);
    }
  }

  EnterSeedPhraseTabData copyWith({
    int? currentValue,
    List<EnterSeedPhraseInputData>? inputs,
  }) {
    return EnterSeedPhraseTabData(
      currentValue: currentValue ?? this.currentValue,
      inputs: inputs ?? this.inputs,
    );
  }
}
