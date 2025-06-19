# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Lint/Test Commands

### Development Commands

- **Bootstrap packages**: `melos bs`
- **Build for flavors**: `flutter run --flavor <development|staging|production> --target lib/main_<environment>.dart`
- **Generate code**: `melos run codegen` (runs build_runner and locale generation)
- **Format check**: `melos run check-format`
- **Lint**: `melos run analyze`
- **Pre-commit check**: `melos run check-all` (format, analyze, test, integration test)

### Testing Commands

- **All tests**: `melos run test`
- **Single test file**: `flutter test test/path/to/test_file.dart`
- **Single test by name**: `flutter test test/path/to/test_file.dart -p name="test name"`
- **Integration tests**: `flutter test --flavor production integration_test`
- **Dart-only tests**: `melos run test:dart`
- **Flutter tests**: `melos run test:flutter`

### Build and Deploy

- **Deploy to FAD**: `melos run deploy_fad`
- **Deploy iOS to FAD**: `melos run deploy_fad_ios`
- **Deploy Android to FAD**: `melos run deploy_fad_android`
- **Build Android store**: `melos run build_android_store`

## LLM Instructions

The following files contain detailed instructions for working with this codebase:

- **Project structure and organization**: @docs/llm/project_structure.instructions.md
- **Architecture patterns and code standards**: @docs/llm/architecture_and_code_standards.instructions.md
- **Flutter-specific guidelines and best practices**: @docs/llm/flutter_guidelines.instructions.md
- **Development workflow and processes**: @docs/llm/development_workflow.instructions.md
