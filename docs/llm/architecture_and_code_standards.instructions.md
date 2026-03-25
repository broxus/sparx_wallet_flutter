# Architecture and Code Standards Instructions

You are working on the SparX Wallet Flutter project. Follow these critical architecture patterns and code quality rules.

## Architecture Overview

The project follows Clean Architecture with 5 layers:

1. **Application Layer**: App-level configuration, routing, DI setup
2. **Core Layer**: Shared utilities, exceptions, base classes
3. **Service Layer**: Business logic, state management (stateful components)
4. **Data Layer**: APIs, storage, repositories, DTOs
5. **DI Layer**: Dependency injection configuration

All code MUST use Elementary MVVM pattern. Use `@injectable` for DI registration via GetIt.

## Elementary MVVM Pattern

### File Structure

For each feature screen, create exactly these 3 files:

- `feature_screen.dart` - Widget (UI only)
- `feature_screen_model.dart` - Model (data and state, extends `ElementaryModel`, `@injectable`)
- `feature_screen_wm.dart` - WidgetModel (business logic, `@injectable`)

### Reactive Field Naming Convention

In WidgetModel files, ALL reactive fields must use proper suffixes:

- **Notifier/Listenable types** (`ValueNotifier`, `ValueListenable`, `StateNotifier`, `ListenableState`, `EntityStateNotifier`): Must end with `State` suffix — e.g. `isLoadingState`, `userDataState`
- **Stream types** (`Stream`, `StreamController`, `BehaviorSubject`): Must end with `Stream` suffix — e.g. `eventsStream`, `dataStream`

**Private fields must match public getters:**

```dart
// CORRECT
late final _isLoadingState = createValueNotifier(false);
ValueListenable<bool> get isLoadingState => _isLoadingState;

// WRONG - Private field name doesn't match getter
late final _isLoading = createValueNotifier(false);
ValueListenable<bool> get isLoadingState => _isLoading;
```

### Base Class Patterns

#### 1. Non-Parametrized (CustomWidgetModel + InjectedElementaryWidget)

Use when widgets don't need parameters from parent (e.g. feature entry points, modal sheets):

```dart
class SplashScreen extends InjectedElementaryWidget<SplashScreenWidgetModel> {
  const SplashScreen({super.key});

  @override
  Widget build(SplashScreenWidgetModel wm) {
    // UI implementation
  }
}

@injectable
class SplashScreenWidgetModel extends CustomWidgetModel<SplashScreen, SplashScreenModel> {
  SplashScreenWidgetModel(super.model);
}

@injectable
class SplashScreenModel extends ElementaryModel {
  SplashScreenModel(
    ErrorHandler errorHandler,
    this._service,
  ) : super(errorHandler: errorHandler);
  
  final YourService _service;
}
```

#### 2. Parametrized (CustomWidgetModelParametrized + InjectedElementaryParametrizedWidget)

Use when widgets need data from parent (e.g. list items, reusable components):

```dart
class AccountCard extends InjectedElementaryParametrizedWidget<
    AccountCardWidgetModel, KeyAccount> {
  const AccountCard({
    required KeyAccount account,
    super.key,
  }) : super(wmFactoryParam: account);

  @override
  Widget build(AccountCardWidgetModel wm) {
    // UI implementation
  }
}

@injectable
class AccountCardWidgetModel extends CustomWidgetModelParametrized<
    AccountCard, AccountCardModel, KeyAccount> {
  AccountCardWidgetModel(super.model);
  
  late final ValueListenable<String> accountName =
      createWmParamsNotifier((account) => account.name); // reactive param access
  
  KeyAccount get currentAccount => wmParams.value; // direct param access
}

// For multiple parameters, create a params class:
class MyWidgetParams {
  final String title;
  final VoidCallback onTap;
  const MyWidgetParams({required this.title, required this.onTap});
}

class MyWidget extends InjectedElementaryParametrizedWidget<
    MyWidgetModel, MyWidgetParams> {
  MyWidget({
    required String title,
    required VoidCallback onTap,
    super.key,
  }) : super(wmFactoryParam: MyWidgetParams(title: title, onTap: onTap));
}
```

### CustomWidgetModel Features

Both base WidgetModel classes provide:

- Error handling through `PrimaryErrorHandler`
- Loading state management
- Navigation helpers
- Common mixins (`NotifierSubscriptionsMixin`, `ContextWmMixin`)
- Automatic dependency injection via GetIt

## Business Logic Components

- **Services**: Stateful business logic, registered as DI singletons (e.g. `CurrentAccountsService`, `BalanceService`)
- **Repositories**: Data access (APIs, storage), DTO→domain transformation, no business logic (e.g. `TokenRepository`, `TonRepository`)
- **Domain Models**: Business entities — MUST use Freezed for immutable data classes with JSON serialization
- **DTOs**: Data transfer objects for API/storage communication — also use Freezed

## Navigation System (Compass)

- **NEVER** use raw GoRouter directly — **ALWAYS** use Compass navigation methods
- **NEVER** use Freezed with RouteData classes (breaks type resolution)

### Navigation Methods

```dart
context.compassPoint(YourRoute());     // Navigate to new route
context.compassPush(YourRoute());      // Push onto stack
context.compassContinue(YourRoute());  // Continue navigation flow
context.compassBack();                 // Navigate back
```

### Route Definition

```dart
// Route data class (NO Freezed!)
class YourRouteData {
  final String parameter;
  const YourRouteData({required this.parameter});
}

@AutoRouteConfig.route('/your-path')
class YourRoute extends CompassRoute {
  final YourRouteData data;
  YourRoute({required this.data});
}
```

## Error Handling

- Use `PrimaryErrorHandler` for all error scenarios

### EntityStateNotifier Pattern

For async operations with loading states:

```dart
final entityNotifier = EntityStateNotifier<YourData>();

Future<void> loadData() async {
  await entityNotifier.content(() async {
    return await _service.fetchData();
  });
}
```

## Code Quality Standards

- **NEVER** log or expose secrets, keys, or sensitive data
- Use explicit, descriptive variable names with auxiliary verbs (`isLoading`, `hasError`)
- Avoid magic numbers — use named constants

### File Organization

```dart
// File structure within dart files:
// 1. Imports (SDK → Flutter → External → Internal)
// 2. Main widget/class
// 3. Subwidgets/helper classes
// 4. Static content/constants
// 5. Types/enums
```

## Blockchain Integration

- Use `NekotonRepository` for all blockchain operations
- Use `AssetsService` for token/currency management
- Handle multiple token standards (TIP-3, etc.)

## UI/UX Guidelines

### Theme System

- **ALWAYS** use v2 theme system (`packages/ui_components_lib/v2/`) — NEVER v1 legacy system
- **ALWAYS** access themes via `context.themeStyleV2` extension
- **ALWAYS** use semantic color names (`colors.content0`, `colors.background2`) — NEVER hardcoded colors
- **ALWAYS** use design tokens (`DimensSize.d16`, `DimensRadius.radius12`) — NEVER magic numbers
- **ALWAYS** use pre-built components (`PrimaryButton`, `PrimaryText`) when available
- **ALWAYS** follow typography hierarchy (`textStyles.headingMedium`, `textStyles.paragraphSmall`)
- Import: `import 'package:ui_components_lib/ui_components_lib.dart';`

## Localization

- **NEVER** hardcode strings in widgets
- Storage: JSON files in `assets/translations/`, snake_case keys, hierarchical structure
- Use `easy_localization` package; generate keys with `melos run codegen:locale`

```dart
Text(LocaleKeys.feature_screen_title.tr())
Text(LocaleKeys.feature_screen_message.tr(args: [userName]))
```

## Testing

- Use **mocktail** for mocking (never mock the class under test)
- Follow **Arrange-Act-Assert (AAA)** pattern with **given_when_then** naming convention
- Test each layer separately; test error scenarios
- Run tests: `melos run test` or `flutter test test/path/to/test_file.dart`
- Run specific test: `flutter test test/path/to/test_file.dart -p name="test name"`

```dart
class MockRepository extends Mock implements UserRepository {}

void main() {
  late UserService service;
  late MockRepository mockRepository;
  
  setUp(() {
    mockRepository = MockRepository();
    service = UserService(mockRepository);
  });

  group('FeatureName', () {
    test('should return expected result when valid input provided', () {
      // Arrange
      final input = 'test_input';
      // Act
      final result = service.method(input);
      // Assert
      expect(result, equals('expected_output'));
    });
  });
}
```
