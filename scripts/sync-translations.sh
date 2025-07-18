#!/bin/bash

# Copy English translations to Korean
cp assets/translations/en.json assets/translations/ko.json

# Generate localization keys and format the output file
dart run easy_localization:generate --source-dir assets/translations -f keys --output-file locale_keys.g.dart && dart format lib/generated/locale_keys.g.dart
