# Project Structure

This document outlines the high-level structure of the SparX Wallet Flutter application, explaining the organization of the codebase and the relationship between different components.

## Root Directory Structure

The application follows a modular and layered architecture that includes the following main directories:

- **/lib**: Contains all Dart code for the application  
  - **/app**: Core application infrastructure  
  - **/bootstrap**: App initialization and configuration  
  - **/core**: Common utilities and base classes  
  - **/data**: Data models and data layer components  
  - **/di**: Dependency injection configuration  
  - **/event_bus**: Event handling system  
  - **/feature**: Feature modules (screens, business logic)  
  - **/generated**: Generated code (assets, localizations)  
  - **/http**: API clients and networking  
  - **/utils**: Utility functions  
  - **/widgets**: Shared UI components  

- **/assets**: Contains non-code resources  
  - **/abi**: Blockchain contract ABIs  
  - **/images**: UI images and icons  
  - **/js**: JavaScript code for blockchain integrations  
  - **/splash**: Splash screen assets  
  - **/translations**: Localization files  

- **/packages**: Contains internal packages  
  - **/ui_components_lib**: UI component library  
  - **/datetime_avoid_lint**: Custom lint rules  

## Feature Structure (Elementary Pattern)

New features follow the Elementary architecture pattern, which consists of three main components:

1. **Screen/Widget**: The UI component that displays data and handles user interactions  
   - `feature_screen.dart`: Extends `ElementaryWidget`  
   - Minimal UI logic, declarative UI construction  

2. **Model**: The business logic component  
   - `feature_screen_model.dart`: Extends `ElementaryModel`  
   - Contains business logic and data operations  
   - Injected with services and repositories  

3. **WidgetModel**: The presentation logic component  
   - `feature_screen_wm.dart`: Extends `WidgetModel` or `CustomWidgetModel`  
   - Acts as a bridge between UI and business logic  
   - Contains UI state as `StateNotifier` properties  
   - Handles UI events and transforms them into model operations  

**Example structure for a feature called "feature_name":**

```
/feature/feature_name/
├── feature_name.dart              # exports
├── feature_name_screen.dart      # UI
├── feature_name_model.dart       # Business Logic
├── feature_name_wm.dart          # Widget Model
└── widgets/                      # Feature-specific widgets
```

## Legacy Feature Structure (Bloc Pattern)

Legacy features use the BLoC pattern with:

1. **View**: The UI component  
   - `feature_view.dart`: The screen  
   - `feature_page.dart`: Page container  

2. **Cubit/Bloc**: State management  
   - `feature_cubit.dart`: Extends `Cubit`  
   - `feature_state.dart`: Freezed state class  

3. **Widgets**: Feature-specific components  

**Example structure:**

```
/feature/feature_name/
├── cubit/
│   ├── feature_cubit.dart
│   └── feature_state.dart
├── view/
│   ├── feature_page.dart
│   └── feature_view.dart
└── widgets/
```

## Domain Layer

Domain layer provides business-specific logic of feature.

```
/feature/{feature_name}/domain/
├── feature_service.dart
├── feature_processor.dart         # some object managic stateless logic like use_case/processor/parser/etc
└── specific_service/              # for big feature with multiple service creates directory
    └── specific_service.dart      # implementation
```

The `domain` directory houses stateless use-cases (parsers, comparators, patchers, etc.) and stateful services.

**Key characteristics:**

- Implemented as singletons via Injectable  
- Provide business logic and data handling  

## Data Layer

Data layer provides data structures and data flow of feature.

```
/feature/feature_name/data/
├── entities/                   # for complex feature entities placed in separate directory
├── dto/                       # for complex feature dto placed in separate directory
├── api/                        # for complex feature apis placed in separate directory
├── feature_api.dart            # interface reptresenting api-layer http/rpc of feature
├── feature_object.dart         # some business layer object
├── shared_widget_object.dart   # some model of shared widget
└── feature_object_dto.dart     # some transport layer (http/rpc/other) object        
```

For simple features, models are placed directly inside the `data` directory. For more complex features, the `data` directory is further divided into:

- `dto`: Contains data transfer objects and serialization-related code.
- `entities`: Contains business logic models.

UI models are located either next to the widget in the `widget` folder or in the `data` folder if they are cross-feature models.

**Key characteristics:**

- Use Freezed for immutability and pattern matching  
- Use Retrofit annotations for api-layer
- Use JsonSerializable for serialization  

## Routing System

The application uses GoRouter for navigation:

```
/app/router/
├── app_route.dart            # route definitions
├── router.dart               # router configuration
├── page_transitions.dart
└── routs/                    # route implementations
```

## Application Entry Points

The application has multiple entry points for different environments:

```
/lib/
├── main.dart                 # entry point
├── main_development.dart
├── main_production.dart
├── main_staging.dart
└── runner.dart               # shared initialization
```
