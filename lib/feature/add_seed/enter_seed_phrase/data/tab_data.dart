import 'package:app/feature/add_seed/enter_seed_phrase/data/input_data.dart';

class EnterSeedPhraseTabData {
  EnterSeedPhraseTabData({required this.currentValue, required this.inputs});

  final int currentValue;
  final List<EnterSeedPhraseInputData> inputs;

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
