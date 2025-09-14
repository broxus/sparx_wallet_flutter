# WM State Properties Lint

A custom lint package for enforcing naming conventions for reactive fields in WidgetModel files.

## Overview

This package provides custom lint rules to ensure consistent naming of reactive fields in Elementary WidgetModel (`*_wm.dart`) files. It enforces that all reactive fields use proper suffixes to clearly indicate their reactive nature.

## Rules

### 1. `wm_public_getter_naming`

Ensures that public getters for reactive types have proper suffixes:

- **Notifier/Listenable types** must end with `State` suffix
  - Applies to: `ValueNotifier`, `ValueListenable`, `StateNotifier`, `ListenableState`, `EntityStateNotifier`
  - Example: `isLoadingState`, `selectedTabState`, `userDataState`

- **Stream types** must end with `Stream` suffix
  - Applies to: `Stream`, `StreamController`, `BehaviorSubject`
  - Example: `eventsStream`, `dataStream`

```dart
// ✅ CORRECT
ValueListenable<bool> get isLoadingState => _isLoadingState;
StateNotifier<User?> get userState => _userState;
Stream<Event> get eventsStream => _eventsStream;

// ❌ WRONG
ValueListenable<bool> get isLoading => _isLoading;  // Missing State suffix
StateNotifier<User?> get user => _user;  // Missing State suffix
Stream<Event> get events => _events;  // Missing Stream suffix
```

### 2. `wm_private_field_naming`

Ensures that private fields match their public getter names:

```dart
// ✅ CORRECT - Private field matches public getter
late final _isLoadingState = createValueNotifier(false);
ValueListenable<bool> get isLoadingState => _isLoadingState;

// ❌ WRONG - Private field doesn't match public getter
late final _isLoading = createValueNotifier(false);
ValueListenable<bool> get isLoadingState => _isLoading;
```

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dev_dependencies:
  wm_state_properties_lint:
    path: packages/wm_state_properties_lint
  custom_lint: ^0.6.0
```

Then add to your `analysis_options.yaml`:

```yaml
analyzer:
  plugins:
    - custom_lint
```

## Configuration

The lint rules are automatically applied to all files ending with `_wm.dart`. No additional configuration is needed.

## Exceptions

The following naming patterns are considered valid:
- Fields ending with `State`
- Fields ending with `Notifier`  
- Fields ending with `Stream`

Descriptive names that clearly indicate reactive behavior are acceptable.

## Quick Fixes

The package provides quick fixes to automatically rename fields with incorrect suffixes. Use your IDE's quick fix feature (usually Alt+Enter or Cmd+.) to apply the suggested fixes.

## Development

To run tests:

```bash
dart test
```

## License

This package is part of the SparX Wallet Flutter project.
