# Architecture and Code Standards Instructions

You are working on the SparX Wallet Flutter project. Follow these critical architecture patterns and code quality rules.

## Architecture Overview

The project follows Clean Architecture with these practical layers:

1. **Presentation Layer**: Screens, widgets, WidgetModels, and feature UI code in `lib/feature/**` and `lib/widgets/**`
2. **Application Layer**: App-level bootstrap, routing, guards, and cross-feature orchestration in `lib/app/**`
3. **Core Layer**: Shared primitives, utilities, exceptions, base classes, and error handling in `lib/core/**`
4. **Service Layer**: Stateful business logic in `lib/app/service/**` and `lib/feature/**/domain/**`
5. **Data Layer**: Repositories, APIs, storage, DTOs, and persistence in `lib/data/**` and `lib/feature/**/data/**`
6. **DI Layer**: Dependency injection configuration in `lib/di/**`

Keep dependencies one-way: presentation -> application/core/service -> data -> di. Do not place business logic inside repositories.

Use Injectable/GetIt annotations that match the lifecycle you need (`@injectable`, `@singleton`, `@lazySingleton`, `@Singleton(as: ...)`, `@named`).

## Elementary MVVM Pattern

### File Structure

Stateful screens should follow the Elementary split and keep UI, model, and WM files together. The repo currently uses both flat and nested layouts, for example:

- `lib/feature/choose_network/choose_network_screen.dart`
- `lib/feature/onboarding/screen/welcome/welcome_screen.dart`
- `lib/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen.dart`

For screens, keep the required trio together:

- `*_screen.dart` - Widget/UI
- `*_screen_model.dart` - Model (`ElementaryModel`)
- `*_screen_wm.dart` - WidgetModel

Reusable stateful widgets may follow the analogous `*_widget.dart` / `*_model.dart` / `*_wm.dart` split. Add a barrel export file only when the feature exposes multiple public entry points.

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

Use when widgets don't need parameters from parent (for example feature entry points and modal sheets):

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

Use when widgets need data from parent (for example list items and reusable components):

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

- **Services**: Stateful business logic, registered as DI singletons (for example `CurrentAccountsService`, `BalanceService`)
- **Repositories**: Data access, API/storage orchestration, and DTO -> domain transformation only; no business logic
- **Domain Models / DTOs**: Prefer Freezed plus JSON serialization where appropriate, but do not use Freezed for Compass route data classes

## Navigation System (Compass)

- **NEVER** use raw GoRouter directly from feature code — navigate with Compass route data objects
- **NEVER** use Freezed with Compass route data classes (breaks type-based route resolution)
- Use `CompassRouteParameterless<T extends CompassRouteData>` for routes without query parameters
- Use `CompassRoute<T extends CompassRouteDataQuery>` for routes that serialize data into query parameters

### Navigation Methods

```dart
context.compassPoint(const OnBoardingRouteData());
await context.compassPush<ChooseNetworkRouteData, bool>(
  const ChooseNetworkRouteData(
    nextStep: ChooseNetworkNextStep.createSeedPassword,
  ),
);
context.compassContinue(
  const ChooseNetworkRouteData(
    nextStep: ChooseNetworkNextStep.addExistingWallet,
  ),
);
context.compassBack();
```

### Route Definition

```dart
const _userIdQueryParam = 'userId';

class ProfileRouteData implements CompassRouteDataQuery {
  const ProfileRouteData({required this.userId});

  final String userId;

  @override
  Map<String, String> toQueryParams() => {
    _userIdQueryParam: userId,
  };
}

@named
@Singleton(as: CompassBaseRoute)
class ProfileRoute extends CompassRoute<ProfileRouteData> {
  ProfileRoute()
    : super(
        path: '/profile',
        builder: (context, data, _) => ProfileScreen(userId: data.userId),
      );

  @override
  ProfileRouteData fromQueryParams(Map<String, String> queryParams) {
    return ProfileRouteData(
      userId: queryParams.require(_userIdQueryParam),
    );
  }
}

class OnBoardingRouteData implements CompassRouteData {
  const OnBoardingRouteData();
}

@named
@Singleton(as: CompassBaseRoute)
class OnBoardingRoute extends CompassRouteParameterless<OnBoardingRouteData> {
  OnBoardingRoute()
    : super(
        path: '/onboarding',
        builder: (context, _, _) => const WelcomeScreen(),
        isTopLevel: true,
      );

  @override
  OnBoardingRouteData createData() => const OnBoardingRouteData();
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

- **ALWAYS** use the v2 theme/tokens exported from `package:ui_components_lib/ui_components_lib.dart`
- **ALWAYS** access themes via `context.themeStyleV2`
- **ALWAYS** use semantic colors (`colors.content0`, `colors.background2`) instead of hardcoded colors
- **ALWAYS** use design tokens (`DimensSize.d16`, `DimensRadius.radius12`) instead of magic numbers
- **ALWAYS** prefer pre-built components when they cover the use case
- **ALWAYS** follow the established typography hierarchy from `themeStyleV2.textStyles`

## Localization

- **NEVER** hardcode strings in widgets
- Storage: JSON files in `assets/translations/`; this repo currently uses camelCase keys such as `createNewWallet` and `enterSeedNameScreenTitle`
- Preserve the existing key style in the surrounding translation file instead of introducing a new naming convention mid-file
- Use `easy_localization`; generate keys with `melos run codegen:locale` or `melos run codegen`

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
