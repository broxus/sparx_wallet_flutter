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

**Example structure for a feature called "feature_name":**

```
/feature/feature_name/
├── feature_name.dart              # exports
├── feature_name_screen.dart      # UI
├── feature_name_model.dart       # Business Logic
├── feature_name_wm.dart          # Widget Model
└── widgets/                      # Feature-specific widgets
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
