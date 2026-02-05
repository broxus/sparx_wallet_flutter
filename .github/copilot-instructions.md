# Copilot Code Review Instructions (SparX Wallet Flutter)

Keep review feedback concise; prefer checklists and links over prose.

## Review Priorities
- Correctness and safety first; call out crashes, data loss, and security/privacy risks.
- Enforce Clean Architecture layering: presentation → application → core → service (stateful business logic) → data → di.
- Elementary MVVM only; flag raw GoRouter usage. Screens must use `screen.dart`/`screen_model.dart`/`screen_wm.dart` split with @injectable models.
- Navigation must use Compass (`context.compassPoint/Push/Continue/Back` + CompassRoute classes); no Freezed RouteData.
- Data vs services: repositories are pure data/DTO transforms (Freezed + JSON). Services hold business/state and are singletons in DI. No business logic inside repositories.

## UI/Theme/Localization
- Must use v2 design tokens/components from `package:ui_components_lib/ui_components_lib.dart` and `context.themeStyleV2`; no hardcoded colors or magic numbers. Prefer prebuilt components and const constructors where possible.
- Reactive naming: notifiers/listenables end with `State`; streams end with `Stream`; private field mirrors public getter name.
- No hardcoded strings; use `LocaleKeys...tr(...)` with snake_case keys from `assets/translations/`.

## Error Handling & State
- Prefer PrimaryErrorHandler; avoid leaking sensitive info.
- Async loading should use EntityStateNotifier pattern; keep try/catch minimal and meaningful.

## Testing Expectations
- Design for testability via DI; prefer AAA style.
- Prefer using **mocktail** for mocks instead of handwritten fakes.
- Highlight missing or weak tests for critical paths (happy + error). Usual commands: `melos run test` or `flutter test path/to/file -p name="test name"`.

## Code Quality
- Explicit naming (is/has), small functions, trailing commas. Import order: SDK → Flutter → external → internal; then main widget, subwidgets/helpers, statics/constants, types/enums.
- Security-first: never log secrets; validate inputs; use secure storage.
