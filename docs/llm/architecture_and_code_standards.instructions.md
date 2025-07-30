# Architecture and Code Standards Instructions

You are working on the SparX Wallet Flutter project. Follow these critical architecture patterns and code quality rules.

## Architecture Overview

### Clean Architecture Layers

The project follows Clean Architecture with 5 layers:

1. **Application Layer**: App-level configuration, routing, DI setup
2. **Core Layer**: Shared utilities, exceptions, base classes
3. **Service Layer**: Business logic, state management (stateful components)
4. **Data Layer**: APIs, storage, repositories, DTOs
5. **DI Layer**: Dependency injection configuration

### Architecture Patterns

- **New Code**: MUST use Elementary MVVM pattern
- **Legacy Code**: May use BLoC pattern - don't refactor unless necessary
- **Navigation**: MUST use Compass (type-safe navigation) - NEVER raw GoRouter

## Elementary MVVM Pattern (Required for New Code)

### File Structure

For each feature screen, create exactly these 3 files:

- `feature_screen.dart` - Widget (UI only)
- `feature_screen_model.dart` - Model (data and state)
- `feature_screen_wm.dart` - WidgetModel (business logic)

### Implementation Rules

- **Widget**: Pure UI, no business logic
- **Model**: Data handling, state management, extends `ElementaryModel`, MUST be `@injectable`
- **WidgetModel**: Business logic, user interactions, MUST be `@injectable`

### Base Class Patterns

The project uses two patterns for Elementary MVVM implementation:

#### 1. Non-Parametrized Pattern (CustomWidgetModel + InjectedElementaryWidget)

Use when widgets don't need parameters from parent widgets:

```dart
// Widget - extends InjectedElementaryWidget
class SplashScreen extends InjectedElementaryWidget<SplashScreenWidgetModel> {
  const SplashScreen({super.key});

  @override
  Widget build(SplashScreenWidgetModel wm) {
    // UI implementation
  }
}

// WidgetModel - extends CustomWidgetModel
@injectable
class SplashScreenWidgetModel extends CustomWidgetModel<SplashScreen, SplashScreenModel> {
  SplashScreenWidgetModel(super.model);
  // Business logic implementation
}

// Model - extends ElementaryModel
@injectable
class SplashScreenModel extends ElementaryModel {
  SplashScreenModel(
    ErrorHandler errorHandler,
    this._service,
  ) : super(errorHandler: errorHandler);
  
  final YourService _service;
}
```

#### 2. Parametrized Pattern (CustomWidgetModelParametrized + InjectedElementaryParametrizedWidget)

Use when widgets need parameters from parent widgets:

```dart
// Widget - extends InjectedElementaryParametrizedWidget
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

// WidgetModel - extends CustomWidgetModelParametrized
@injectable
class AccountCardWidgetModel extends CustomWidgetModelParametrized<
    AccountCard, AccountCardModel, KeyAccount> {
  AccountCardWidgetModel(super.model);
  
  // Access parameter via reactive notifier
  late final ValueListenable<String> accountName =
      createWmParamsNotifier((account) => account.name);
  
  // Or access current value directly
  KeyAccount get currentAccount => wmParams.value;
}

// For multiple parameters, create a params class
class MyWidgetParams {
  final String title;
  final VoidCallback onTap;
  const MyWidgetParams({required this.title, required this.onTap});
}

// Widget with multiple parameters
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

### When to Use Each Pattern

**Use Non-Parametrized Pattern when:**

- Widget is self-contained
- All data comes from injected services
- No configuration from parent is needed
- Examples: App root widget, feature entry points, modal sheets

**Use Parametrized Pattern when:**

- Widget needs data from parent
- Widget behavior changes based on parameters
- Widget is reusable with different configurations
- Examples: List items, reusable components, widgets displaying entity details

## Dependency Injection

### Service Registration

```dart
// In di.dart
@injectable
class YourService {
  // Implementation
}
```

## Business Logic Components

### Services (Stateful Business Logic)

- Handle complex business operations
- Maintain state across the application
- Examples: `CurrentAccountsService`, `BalanceService`
- MUST be registered in DI as singletons

### Repositories (Data Access)

- Handle external data sources (APIs, storage)
- Transform DTOs to domain models
- No business logic - pure data operations
- Examples: `TokenRepository`, `TonRepository`

### Models and DTOs

- **Domain Models**: Business entities used throughout the app
- **DTOs**: Data transfer objects for API/storage communication
- MUST use Freezed for immutable data classes
- Include proper JSON serialization

## Navigation System (Compass)

### Critical Rules

- **NEVER** use raw GoRouter directly
- **ALWAYS** use Compass navigation methods
- **NEVER** use Freezed with RouteData classes (breaks type resolution)

### Navigation Methods

```dart
// Navigate to new route
context.compassPoint(YourRoute());

// Push onto stack
context.compassPush(YourRoute());

// Continue navigation flow
context.compassContinue(YourRoute());

// Navigate back
context.compassBack();
```

### Route Definition

```dart
// Route data class (NO Freezed!)
class YourRouteData {
  final String parameter;
  const YourRouteData({required this.parameter});
}

// Route implementation
@AutoRouteConfig.route('/your-path')
class YourRoute extends CompassRoute {
  final YourRouteData data;
  YourRoute({required this.data});
}
```

## Error Handling

### Consistent Error Handling

- Use `PrimaryErrorHandler` for all error scenarios
- Implement proper try-catch blocks in async operations
- Provide meaningful error messages to users
- Log errors for debugging but never expose sensitive data

### EntityStateNotifier Pattern

For async operations with loading states:

```dart
final entityNotifier = EntityStateNotifier<YourData>();

// In WidgetModel
Future<void> loadData() async {
  await entityNotifier.content(() async {
    return await _service.fetchData();
  });
}
```

## Code Quality Standards

### Security First

- **NEVER** log or expose secrets, keys, or sensitive data
- Validate all user inputs
- Use secure storage for sensitive information
- Implement proper authentication and authorization

### Clean Code Principles

- Use explicit, descriptive variable names with auxiliary verbs (`isLoading`, `hasError`)
- Avoid magic numbers - use named constants
- Keep functions small and focused
- Implement proper null safety
- Use const constructors for immutable widgets

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

### Nekoton Integration

- Use `NekotonRepository` for all blockchain operations
- Handle connection states properly
- Implement proper error handling for network issues
- Cache blockchain data when appropriate

### Asset Management

- Use `AssetsService` for token/currency management
- Implement proper balance calculations
- Handle multiple token standards (TIP-3, etc.)

## UI/UX Guidelines

### Theme System

- **ALWAYS** use v2 theme system (`packages/ui_components_lib/v2/`) - NEVER v1 legacy system
- **ALWAYS** access themes via `context.themeStyleV2` extension
- **ALWAYS** use semantic color names (`colors.content0`, `colors.background2`) - NEVER hardcoded colors
- **ALWAYS** use design tokens (`DimensSizeV2.d16`, `DimensRadiusV2.radius12`) - NEVER magic numbers
- **ALWAYS** use pre-built components (`PrimaryButton`, `PrimaryText`) when available
- **ALWAYS** follow typography hierarchy (`textStyles.headingMedium`, `textStyles.paragraphSmall`)
- Import pattern: `import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';`

### Responsive Design

- Implement proper responsive layouts
- Test on different screen sizes
- Use flexible widgets and constraints
- Handle orientation changes

## Localization

### Translation Requirements

- **NEVER** hardcode strings in widgets
- **Storage**: JSON files in `assets/translations/`
- Use snake_case for all keys
- Use `easy_localization` package
- Generate translation keys with `melos run codegen:locale`
- Provide descriptive keys following hierarchical structure

### Implementation

```dart
// In widget
Text(LocaleKeys.feature_screen_title.tr())

// With parameters
Text(LocaleKeys.feature_screen_message.tr(args: [userName]))
```

## Testing Integration

### Testable Architecture

- Design components for easy testing
- Use dependency injection for mocking
- Separate business logic from UI
- Implement proper abstractions

### Test-Driven Development

- Follow **Arrange-Act-Assert (AAA)** pattern:
- Use **given_when_then** format for naming convention

- Write tests for all business logic
- Mock external dependencies
- Never mock the class under test
- Test error scenarios
- Maintain high test coverage
- Use **Mocktail** for all dependencies
- Test Each Layer Separately
- Run command for test `melos run test`
- Run Specific Test File `flutter test test/path/to/test_file.dart`
- Run `flutter test test/path/to/test_file.dart -p name="test name"`

```dart
class MockRepository extends Mock implements UserRepository {}
class MockNekotonRepository extends Mock implements NekotonRepository {}

void main() {
  late ServiceUnderTest serviceUnderTest;
  late MockRepository mockRepository;
  
  setUp(() {
    mockRepository = MockRepository();
    serviceUnderTest = UserService(mockRepository, MockNekotonRepository());
  });

  group('FeatureName', () {
    test('should return expected result when valid input provided', () {
      // Arrange
      final input = 'test_input';
      final expected = 'expected_output';
      
      // Act
      final result = serviceUnderTest.method(input);
      
      // Assert
      expect(result, equals(expected));
    });
  });
}
```

## Module System

### Feature Modules

- Group related functionality into modules
- Implement proper boundaries between modules
- Use dependency injection for inter-module communication
- Design for modularity and reusability
