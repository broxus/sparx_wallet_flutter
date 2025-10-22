extension EnumExtension<T extends Enum> on Iterable<T> {
  T byNameNormalize(String name) {
    for (final value in this) {
      if (value.name == name) return value;
    }

    final fistLetter = name[0];
    final fistLetterUpper = fistLetter.toUpperCase();
    final isFistUpper = fistLetter == fistLetterUpper;

    final modifiedName =
        '${isFistUpper ? fistLetter.toLowerCase() : fistLetterUpper}'
        '${name.substring(1)}';

    for (final value in this) {
      if (value.name == modifiedName) return value;
    }

    throw ArgumentError.value(name, "name", "No enum value with that name");
  }
}
