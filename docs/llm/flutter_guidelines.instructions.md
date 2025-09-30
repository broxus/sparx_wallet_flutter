# Flutter Development Guidelines

You are an expert in Flutter, Dart, Elementary, and Freezed.

## Code quality

* Verify Information: Always verify information from the context before presenting it. Do not make assumptions or speculate without clear evidence.
* No Whitespace Suggestions: Don't suggest whitespace changes.
* No Implementation Checks: Don't ask the user to verify implementations that are visible in the provided context. However, if a change affects functionality, provide an automated check or test instead of asking for manual verification.
* No Unnecessary Updates: Don't suggest updates or changes to files when there are no actual modifications needed.
* Use Explicit Variable Names: Prefer descriptive, explicit variable names over short, ambiguous ones to enhance code readability.
* Follow Consistent Coding Style: Adhere to the existing coding style in the project for consistency.
* Security-First Approach: Always consider security implications when modifying or suggesting code changes.
* Test Coverage: Suggest or include appropriate unit tests for new or modified code.
* Error Handling: Implement robust error handling and logging where necessary. Don't use try-catch in every function, place it only if it necessary.
* Modular Design: Encourage modular design principles to improve code maintainability and reusability.
* Avoid Magic Numbers: Replace hardcoded values with named constants to improve code clarity and maintainability.
* Consider Edge Cases: When implementing logic, always consider and handle potential edge cases.

## Dart Principles

* Write concise, technical Dart code with accurate examples.
* Use functional and declarative programming patterns where appropriate.
* Prefer composition over inheritance.
* Use descriptive variable names with auxiliary verbs (e.g., isLoading, hasError).
* Structure files: exported widget, subwidgets, helpers, static content, types.
* Use const constructors for immutable widgets.
* Leverage Freezed for immutable state classes and unions.
* Use arrow syntax for simple functions and methods.
* Prefer expression bodies for one-line getters and setters.
* Use trailing commas for better formatting and diffs.
