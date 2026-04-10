# Project Structure

This document outlines the high-level structure of the SparX Wallet Flutter application, explaining the organization of the codebase and the relationship between different components.

## Root Directory Structure

The current workspace is organized around these top-level directories:

- **/lib**: Main Dart application code  
  - **/app**: App-level bootstrap, router, guards, and shared services  
  - **/core**: Shared primitives, base classes, WM helpers, and utilities  
  - **/data**: Shared data-layer code  
  - **/di**: Dependency injection wiring  
  - **/extensions**: Shared Dart and Flutter extensions  
  - **/feature**: Feature modules  
  - **/generated**: Generated assets/localization/codegen output  
  - **/http**: Networking helpers and clients  
  - **/utils**: Shared utility functions  
  - **/widgets**: Cross-feature reusable widgets  
  - `main.dart`, `main_development.dart`, `main_staging.dart`, `main_production.dart`, `runner.dart`: App entrypoints  

- **/assets**: Non-code resources  
  - **/abi**: Blockchain contract ABIs  
  - **/animations**: Animated assets  
  - **/configs**: Static config payloads  
  - **/html**: Embedded HTML resources  
  - **/images**: UI images and icons  
  - **/splash**: Splash screen assets  
  - **/translations**: Localization files  

- **/packages**: Workspace packages  
  - **/ui_components_lib**: UI component library  
  - **/storybook**: Storybook app for UI components  
  - **/wm_state_properties_lint**: Custom lint package  

## Feature Structure (Elementary Pattern)

Feature modules are not all shaped the same, but they follow a few common patterns.

**Flat screen feature:**

```
/feature/choose_network/
├── choose_network.dart
├── choose_network_screen.dart
├── choose_network_screen_model.dart
├── choose_network_screen_wm.dart
└── route.dart
```

**Nested screen folder:**

```
/feature/onboarding/
├── route.dart
├── screen/
│   └── welcome/
│       ├── welcome_screen.dart
│       ├── welcome_screen_model.dart
│       └── welcome_screen_wm.dart
└── widgets/
```

**Larger feature with data/domain/view split:**

```
/feature/{feature_name}/
├── {feature_name}.dart
├── route.dart
├── data/
├── domain/
├── screen/ or view/
└── widgets/
```

## Domain Layer

The `domain` directory contains feature-specific business logic.

```
/feature/{feature_name}/domain/
├── feature_service.dart
├── feature_processor.dart
└── specific_service/
  └── specific_service.dart
```

Use `domain` for stateless processors/parsers/use-cases and for stateful services. Services should be DI-managed singletons; repositories should stay out of this layer.

## Data Layer

The `data` directory contains repositories, APIs, DTOs, storage adapters, and feature-scoped entities.

```
/feature/{feature_name}/data/
├── api/
├── dto/
├── entities/
├── repository.dart
└── storage/
```

For smaller features, these files may live directly inside `data/`. Keep UI-specific state next to the screen or widget instead of moving it into shared data folders.

**Key characteristics:**

- Repositories perform data access and DTO transformation only  
- DTOs and entities commonly use Freezed/JsonSerializable where that fits the feature  
- Retrofit-style API declarations may live under `api/`  
