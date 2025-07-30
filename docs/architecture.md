# Architecture

The codebase in the SparX Wallet Flutter project follows Clean Architecture principles. Additionally, the application architecture is formed based on the recommended architectural patterns for Flutter applications. You can learn more about the Clean Architecture approach in [this article](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).

Both the entire application code and the code within individual features are divided into three layers:

## Data Layer

The data layer is responsible for obtaining data from various sources (local storage, blockchain, network, etc.). This layer contains the following business object groups:

- `*Api` - Objects responsible for retrieving data from REST API sources. For example, working with REST APIs through Retrofit. Examples include `TokenApi`, `TonAssetsApi`, etc. **APIs should be stateless** and only responsible for the communication with remote services.
- `*StorageService` - Objects responsible for persisting and retrieving data from local storage. For example, working with GetStorage for saving user preferences or application state. Examples include `TonConnectStorageService`, `SettingsStorageService`, etc. **Storage services can be stateful as they often need to maintain a reference to the underlying storage mechanism.
- `NekotonRepository` - The main repository that handles blockchain interactions, which is a central part of the application. Imported from another package.
- `DTO` (Data Transfer Object) - Data models describing the contract for working with remote sources. For example, a data model that comes from the server as JSON. These are typically defined using Freezed with the `@freezed` and `@JsonSerializable` annotations.
- `*Repository` - Objects that isolate different data sources behind a unified interface. In all other layers, access to data should be through the Repository. The Repository returns domain objects. **Repositories can be stateful**, especially when they need to cache data or maintain connection states. It's nice when repositories implement a dual-interface approach for data access:
  - **Read Operations**: Provide `ValueStream<T>` for reactive data consumption
  - **Write Operations**: Provide `async` methods for data updates

To maintain consistency and provide a seamless user experience, we follow specific patterns for making data reactive throughout the application:

### External communications on Data Layer

#### Blockchain Integration

A key aspect of our application is the integration with the blockchain through the `NekotonRepository`. This repository provides methods for interacting with the blockchain, managing wallets, and working with contracts:

- **Wallet Management**: Creating, importing, and managing wallets
- **Transaction Handling**: Sending, receiving, and monitoring transactions
- **Contract Interactions**: Deploying and interacting with smart contracts
- **Token Operations**: Working with TIP-3 tokens and other token standards

When working with blockchain functionality, always ensure you're properly handling:

- Asynchronous operations with proper error handling
- Transaction fees and gas calculations
- Secure storage of keys and sensitive information

#### Network Communications

For REST API communications, the project uses the [retrofit.dart](https://pub.dev/packages/retrofit) package, which provides a type-safe HTTP client:

```dart
@RestApi()
abstract class TokenApi {
  factory TokenApi(Dio dio, {String baseUrl}) = _TokenApi;

  @GET('/tokens')
  Future<List<TokenDto>> getTokens();
}
```

## Domain Layer

The business logic layer is responsible for the application's business logic. This layer receives data from the Data layer and performs filtering/aggregation/transformation/calculations depending on the application's tasks. The following business object groups are stored in this layer:

- `*Service` - An object responsible for executing a specific business scenario. These objects should not be isolated just as proxy requests to `Repository`; for this case, it's acceptable to directly access the `Repository` in the Presentation layer. However, you should not overload a service with too many tasks or scenarios, as such services become complex to understand and test, and it's better to do a more appropriate decomposition. **Services can be stateful** as they often need to maintain the application state or manage subscriptions.

- `*UseCase` - Objects responsible for executing specific, focused business tasks. Unlike Services which may handle broader areas of functionality, these classes should focus on a single responsibility, following the Single Responsibility Principle. **Use cases should be stateless** whenever possible to ensure testability and predictability.

  While the standard naming convention is `*UseCase` (e.g., `GetTokenBalanceUseCase`, `ValidateAddressUseCase`), it's better when use case class names end with a verbal noun that clearly indicates their function. Examples include:
  - `LatestVersionFinder` - Finds the latest version of the application
  - `UpdateStatusChecker` - Checks if an update is available and determines its priority

  Naming conventions for these objects should clearly indicate their purpose and follow the pattern of `[noun][verb]` or `[verb][noun]`. For example:
  - Use `VersionComparator` instead of just `Comparator`
  - Use `UpdateStatusChecker` instead of just `UpdateChecker`

  By using specific, descriptive names, the purpose of each class becomes immediately clear, making the codebase more maintainable.

  When deciding whether to extract functionality from a Service into a separate UseCase class, consider the following criteria:

  1. **Reusability**: The functionality can be reused in different parts of the application.
  2. **Domain Cohesion**: The functionality represents a complete logical operation within a specific domain.
  3. **Future Complexity**: Even if the current implementation is simple (just a few lines of code), there's an understanding that it might become more complex in the future.
  4. **Testability**: When you've identified multiple use scenarios and expected results for your code, creating a separate UseCase makes it easier to cover with comprehensive tests.

  When you extract a UseCase class, you should always cover it with tests. This ensures the functionality works as expected and provides documentation for how the UseCase should be used.

- `Domain models` - Data models that describe the final business entities of the application. The structure of such models contains the correct contract corresponding to the business meaning. These models can contain small, simple pieces of business logic related only to the given model. Models should be described as immutable data structures.

## Presentation Layer

The presentation layer is responsible for displaying data to the user. This layer receives data from the Domain and Data layers and presents it to the user. We implement the Presentation layer using the Elementary architecture, which follows the MVVM (Model-View-ViewModel) pattern.

The following business object groups are stored in this layer:

- `*Model` - An object that encapsulates business logic for a specific UI component. The Model serves as a coordinator between the WidgetModel and the Domain/Data layers. It handles data fetching, transformations, and business operations specific to a widget's needs. Models typically:
  - Aggregate dependencies from services and repositories
  - Provide methods that encapsulate business operations
  - Perform data transformation between domain and UI formats
  - Handle caching and optimization logic when appropriate
  
  In Elementary architecture, the Model serves as the "brain" that supplies the WidgetModel with processed data and execution capabilities, keeping business logic separate from presentation logic.

- `*WidgetModel` - The core component that connects the View and Model layers. It's responsible for:
  - Maintaining UI state through StateNotifier properties
  - Exposing state to the UI for consumption
  - Handling user actions through explicit methods
  - Transforming domain models into UI models
  - Managing the widget lifecycle (initWidgetModel, didUpdateWidget, dispose)
  - Communicating with the Model to execute business operations
  - Managing errors through error handlers
  - Sending one-time events to the UI when needed

- `*UiModel/*UiData` - Data model describing the state of UI elements. The model should contain either primitive data types or other nested `UiModel` objects. `UiModel` should be implemented as immutable data structures using Freezed. Examples include screen states, form data, or item representations for lists.

- `*Widget` (View) - A Flutter widget responsible for displaying data to the user. The widget receives data from the `WidgetModel` through state notifiers and renders the UI accordingly. It should not contain business logic beyond what's needed for display. Widgets handle UI events and delegate them to the WidgetModel through method calls. Additionally, widgets process one-time events like navigation, dialogs, or snackbars through handling messages from the WidgetModel.

### Elementary Widget Patterns

The project uses two patterns for implementing Elementary MVVM widgets, both providing automatic dependency injection:

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
```

##### Complex Parameters

For multiple parameters, create a dedicated params class:

```dart
// Params class for complex data
class WalletActionsParams {
  const WalletActionsParams({
    required this.account,
    required this.allowStake,
    required this.sendSpecified,
  });

  final KeyAccount account;
  final bool allowStake;
  final bool sendSpecified;
}

// Widget usage
class WalletActionsWidget extends InjectedElementaryParametrizedWidget<
    WalletActionsWidgetModel, WalletActionsParams> {
  WalletActionsWidget({
    required KeyAccount account,
    required bool allowStake,
    required bool sendSpecified,
    super.key,
  }) : super(
    wmFactoryParam: WalletActionsParams(
      account: account,
      allowStake: allowStake,
      sendSpecified: sendSpecified,
    ),
  );
}

// WidgetModel usage
@injectable
class WalletActionsWidgetModel extends CustomWidgetModelParametrized<
    WalletActionsWidget, WalletActionsModel, WalletActionsParams> {
  WalletActionsWidgetModel(super.model);
  
  // React to parameter changes
  @override
  void initWidgetModel() {
    super.initWidgetModel();
    wmParams.listen((params) {
      // Handle parameter updates
    });
  }
}
```

#### When to Use Each Pattern

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

**Legacy Pattern**: For existing code that hasn't been migrated, you may still see the manual factory pattern with `defaultFactory` methods.

### MVVM add-ons

We use the [Elementary](https://pub.dev/packages/elementary) package as our implementation of the MVVM (Model-View-ViewModel) pattern. Elementary provides a clean separation of concerns and a structured approach to state management. More details can be found in the [Elementary documentation](https://pub.dev/packages/elementary).

- `CustomWidgetModel` - A specialized extension of the standard `WidgetModel` that includes additional functionality through mixins. It's the base class for non-parametrized WidgetModels in our application and includes `NotifierSubscriptionsMixin`, `ContextWmMixin`.

  ```dart
  class CustomWidgetModel<W extends ElementaryWidget, M extends ElementaryModel>
      extends WidgetModel<W, M> with NotifierSubscriptionsMixin, ContextWmMixin {
    CustomWidgetModel(super.model);
  }
  ```

- `CustomWidgetModelParametrized` - An extension of `CustomWidgetModel` designed for widgets that need parameters from parent widgets. It provides reactive parameter handling through a `wmParams` BehaviorSubject that automatically updates when widget rebuilds with new parameters.

  ```dart
  class CustomWidgetModelParametrized<
      W extends InjectedElementaryParametrizedWidget<WidgetModel, Param>,
      M extends ElementaryModel,
      Param> extends CustomWidgetModel<W, M> {
    
    // Access current parameter value
    Param get currentParam => wmParams.value;
    
    // Create reactive notifier from parameter
    ValueNotifier<T> createWmParamsNotifier<T>(T Function(Param param) convert);
  }
  ```

- `NotifierSubscriptionsMixin` - A mixin that simplifies the creation and management of notifiers, controllers, and stream subscriptions. It ensures proper cleanup when the WidgetModel is disposed, preventing memory leaks. Key features include:
  - Creation of various notifiers (StateNotifier, EntityStateNotifier, ValueNotifier)
  - Creation of controllers (TextEditingController, FocusNode, ScrollController)
  - Management of stream subscriptions
  - Automatic disposal of all managed resources
  
  ```dart
  // Creating notifiers with automatic disposal
  final _dataState = createNotifier<MyData>();
  final _loadingState = createEntityNotifier<MyData>();
  final _textController = createTextEditingController();
  
  // Creating a notifier from a stream
  final _streamData = createNotifierFromStream<MyData>(model.dataStream);
  
  // Listening to a stream with automatic disposal
  disposableListen(model.events, (event) {
    // Handle event
  });
  ```

- `EntityStateNotifier` - A specialized StateNotifier that encapsulates a three-state model for UI data: loading, error, and content. It's designed for handling async operations and their UI states:
  - `loading()` - Sets the state to indicate a loading operation
  - `error()` - Sets the state to indicate an error condition
  - `content(data)` - Sets the state with successful content
  
  This pattern is frequently used with the `LoadScreenDataMixin` for standardized data loading:
  
  ```dart
  // Define a screen state using EntityStateNotifier
  final _screenState = createEntityNotifier<MyData>();
  
  // Load data with standard error handling
  loadScreenData(
    () => model.fetchData(), // Data loading function
    onSuccess: (data) {
      // Additional handling on success
    },
    onError: (error) {
      // Error handling
    },
  );
  ```

- `SafeStateNotifier` - An extension of StateNotifier that adds protection against updates after disposal. It prevents "setState after dispose" errors by checking the disposal state before accepting new values.

- `StateNotifier` - Used for managing and exposing state to the UI. When the state changes, the WidgetModel updates the StateNotifier, which notifies listeners (the UI) to rebuild. In our implementation, we often use `EntityStateNotifier` for handling loading, error, and content states.

- `PrimaryErrorHandler` - A specialized error handler that manages error processing and reporting. All WidgetModels should be initialized with this error handler to ensure consistent error handling across the application. It's responsible for displaying error messages to users and logging errors for debugging. It keeps error handling logic separate from business logic.

## Stateless and stateful objects across Layers

1. **Stateless Components**:
   - **APIs**: Should not maintain state between calls
   - **Use Cases/Finders/Readers/Checkers**: Should perform operations without maintaining state
   - **DTOs and Domain Models**: Should be immutable and not contain mutable state

2. **Potentially Stateful Components**:
   - **Repositories**: May cache data or manage connection states
   - **Services**: May maintain application state or manage subscriptions
   - **Storage Services**: Need to maintain connection to storage

3. **Always Stateful Components**:
   - **WidgetModels**: Maintain UI state and react to user actions

For stateful components, consider the following best practices:

- Use appropriate scoping through dependency injection (`@singleton`, `@lazySingleton`, or unscoped)
- Implement proper cleanup methods to avoid memory leaks
- Document the stateful nature of the component for other developers

## Logging

For logging in the project, the [logger](https://pub.dev/packages/logger) package is used. Logger instances should be configured and have a convenient name for searching, reading, and filtering logs.

We also have logs from nekoton, and level transformation matrix is in `packages/nekoton_repository/lib/src/nekoton_repository.dart`.

Console colors are defined in fancy_logger package.

## Logger Configuration

Logger configuration is managed through environment variables and build flavors (development, staging, production). Each flavor sets a different log level:

- Development: Verbose
- Staging: Debug
- Production: Warning

## Exceptions and Error Handling

All exceptions should be properly handled and logged. In production mode, exceptions should be reported to crash analytics systems such as Sentry. The application should recover gracefully from errors whenever possible and provide appropriate feedback to the user.

## Dependency Injection

For dependency injection, we use [get_it](https://pub.dev/packages/get_it) and [injectable](https://pub.dev/packages/injectable).

## Code Conventions and Guidelines

- Follow broxus_flutter_analysis linting rules
- Keep imports organized: Dart SDK → Flutter → External packages → Internal packages
- Use freezed for data models with proper annotations (@freezed, @JsonSerializable)
- Use trailing commas for better formatting and git diffs
- Name files with snake_case.dart, classes with PascalCase
- Structure files: exported widget, subwidgets, helpers, static content, types
- Use descriptive variable names with auxiliary verbs (e.g., isLoading, hasError)
- Use const constructors for immutable widgets
- Create small, private widget classes instead of methods like Widget _build...
