#!/bin/bash

# Unit tests
flutter test --coverage
mv coverage/lcov.info coverage/unit.info

# Integration tests
flutter test --coverage --flavor production integration_test
mv coverage/lcov.info coverage/integration.info

# Merge
lcov -a coverage/unit.info -a coverage/integration.info -o coverage/merged.info
genhtml coverage/merged.info -o coverage/html
