# Testing Guide

This guide outlines the testing strategy and best practices for the SparX Wallet Flutter application. It provides concrete examples from our existing codebase to illustrate effective testing approaches.

## Testing Structure

The project employs a multi-level testing strategy:

1. **Unit Tests** - Test individual components in isolation
2. **Widget Tests** - Test UI components and their behavior
3. **Integration Tests** - Test interactions between multiple components

### Test Commands

```bash
# Run all tests
melos run test

# Run only dart tests
melos run test:dart

# Run only flutter tests
melos run test:flutter

# Run integration tests
melos run test:integration

# Run a specific test
flutter test test/path/to/test_file.dart -p name="test name"
```

## Unit Testing Best Practices

### 1. Test Structure

Each test file follows this consistent structure:

```dart
void main() {
  late ClassBeingTested objectUnderTest;
  late MockDependency mockDependency;

  setUp(() {
    // Initialize mocks and the object under test before each test
    mockDependency = MockDependency();
    objectUnderTest = ClassBeingTested(mockDependency);
  });

  group('MethodName', () {
    test('should behave in a certain way when given certain input', () {
      // Arrange - set up test conditions
      
      // Act - execute the method being tested
      
      // Assert - verify the expected behavior
    });
    
    // Additional tests for this method...
  });
  
  // Additional groups for other methods...
  
  tearDown(() {
    // Clean up after tests if necessary
  });
}
```

### 2. Mock Dependencies

We use [mocktail](https://pub.dev/packages/mocktail) for mocking dependencies. Mock classes are defined at the top of the test file:

```dart
class MockDependency extends Mock implements Dependency {}
```

### 3. Arrange-Act-Assert Pattern

Each test follows the AAA pattern:

```dart
test('returns the latest available version when current version is lower', () {
  // Arrange - set up test data
  const releaseNotes = ReleaseNotes(
    notes: {
      '1.0.0': ReleaseNote(available: true, info: 'Version 1.0.0'),
      '1.1.0': ReleaseNote(available: true, info: 'Version 1.1.0'),
      '1.2.0': ReleaseNote(available: false, info: 'Version 1.2.0'),
    },
  );

  // Act - execute the method being tested
  final result = latestVersionFinder.findLatestVersion(
    releaseNotes,
    '0.9.0',
  );

  // Assert - verify the expected behavior
  expect(result, isNotNull);
  expect(result!.key, '1.1.0');
  expect(result.value.info, 'Version 1.1.0');
});
```

### 4. Mock Behavior Configuration

Use `when` to define how mocks should behave:

```dart
// Basic response
when(() => mockService.getValue()).thenReturn('test value');

// Async response
when(() => mockService.getValueAsync())
    .thenAnswer((_) async => 'test value');

// Throwing exceptions
when(() => mockService.getValue()).thenThrow(Exception('error'));

// Different responses for different arguments
when(() => mockService.compute(1)).thenReturn(10);
when(() => mockService.compute(2)).thenReturn(20);
```

### 5. Verification

Use `verify` to ensure methods are called with expected arguments:

```dart
// Verify a method was called exactly once
verify(() => mockService.getValue()).called(1);

// Verify a method was never called
verifyNever(() => mockService.getValue());

// Verify a method was called with specific arguments
verify(() => mockService.setValue('expected value')).called(1);

// Verify a method was called with any value of a specific type
verify(() => mockService.setValue(any<String>())).called(1);
```

### 6. Test Edge Cases

Always test edge cases, not just the happy path:

```dart
test('returns null when release notes are null', () {
  // Act
  final result = latestVersionFinder.findLatestVersion(
    null,
    '1.0.0',
  );

  // Assert
  expect(result, isNull);
});
```

## Widget Testing

Widget tests verify that the UI renders correctly and responds to user interactions:

```dart
testWidgets('Counter increments when button is tapped', (WidgetTester tester) async {
  // Build the widget
  await tester.pumpWidget(const MyApp());

  // Verify initial state
  expect(find.text('0'), findsOneWidget);
  expect(find.text('1'), findsNothing);

  // Tap the button
  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  // Verify the counter was incremented
  expect(find.text('0'), findsNothing);
  expect(find.text('1'), findsOneWidget);
});
```

Use our custom `pumpApp` helper from `test/helpers/pump_app.dart` to set up the widget test environment:

```dart
await tester.pumpApp(
  const MyWidget(),
  // Optional parameters for custom test setup
);
```

## Testing Services

For services that interact with external dependencies (APIs, databases, etc.), we follow these practices:

1. **Mock external dependencies** - Don't make real API calls in tests
2. **Test error handling** - Ensure the service handles errors gracefully
3. **Test caching behavior** - Verify data is properly cached and retrieved

Example from `update_service_test.dart`:

```dart
test('should check warning display rules for warning status', () async {
  // Arrange
  when(() => mockStorageService.warningCount()).thenReturn(null);
  when(() => mockStorageService.warningLastTime()).thenReturn(null);
  when(() => mockStorageService.versionForUpdate())
      .thenReturn(testNewVersion.key);
  emulateStatus(UpdateStatus.warning);

  // Act
  await updateService.initAndWait();

  // Assert
  verify(
    () => mockConfigReader.getConfig(PresetConfigType.updateRules),
  ).called(1);
  verify(
    () => mockConfigReader.getConfig(PresetConfigType.releaseNotes),
  ).called(1);

  verifyNever(() => mockStorageService.updateWarningCount(any<int>()));
  verifyNever(() => mockStorageService.updateWarningLastTime());

  // Verify that an update request was emitted
  expectUpdateRequest(UpdateStatus.warning);
});
```

## Testing Asynchronous Code

For testing asynchronous code, we use the `async/await` pattern with `thenAnswer`:

```dart
test('fetches data asynchronously', () async {
  // Arrange
  when(() => mockRepository.fetchData())
      .thenAnswer((_) async => 'test data');

  // Act
  final result = await service.getData();

  // Assert
  expect(result, equals('test data'));
  verify(() => mockRepository.fetchData()).called(1);
});
```

## Testing Streams and BLoC Pattern

For testing streams and BLoC components:

```dart
test('emits the correct sequence of states', () {
  // Arrange
  when(() => mockRepository.getData())
      .thenAnswer((_) async => 'test data');

  // Assert
  expectLater(
    bloc.stream,
    emitsInOrder([
      isA<LoadingState>(),
      isA<LoadedState>(),
    ]),
  );

  // Act - trigger the event after setting up the expectation
  bloc.add(LoadDataEvent());
});
```

## Testing Elementary Architecture

For Elementary components, test each layer separately:

1. **Model** - Test business logic and data manipulation
2. **WidgetModel** - Test state management and coordination
3. **Widget** - Test UI rendering and interactions

## Best Practices

1. **Test one thing per test** - Each test should focus on a single behavior
2. **Use descriptive test names** - Test names should describe the behavior being tested
3. **Keep tests isolated** - Tests should not depend on each other
4. **Clean up** - Reset mocks and state in `setUp` and `tearDown`
5. **Test error cases** - Test how your code handles errors and edge cases
6. **Test state transitions** - Verify that state changes correctly
7. **Don't test external libraries** - Focus on testing your own code
8. **Use test helpers** - Create helper functions for common test setup
9. **Keep tests fast** - Tests should run quickly to provide rapid feedback

## Example Test File

Below is a simplified version of a test file following our patterns:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock dependencies
class MockDependency extends Mock implements Dependency {}

void main() {
  late Service service;
  late MockDependency mockDependency;

  setUp(() {
    mockDependency = MockDependency();
    service = Service(mockDependency);
  });

  group('getData', () {
    test('returns data successfully when dependency succeeds', () async {
      // Arrange
      when(() => mockDependency.fetchData())
          .thenAnswer((_) async => 'test data');

      // Act
      final result = await service.getData();

      // Assert
      expect(result, equals('test data'));
      verify(() => mockDependency.fetchData()).called(1);
    });

    test('throws exception when dependency fails', () async {
      // Arrange
      when(() => mockDependency.fetchData())
          .thenThrow(Exception('network error'));

      // Act & Assert
      expect(
        () => service.getData(),
        throwsA(isA<Exception>()),
      );
      verify(() => mockDependency.fetchData()).called(1);
    });
  });
}
```

## Continuous Integration

Tests are automatically run in CI using GitHub Actions to ensure code quality:

1. **Pull Requests** - All tests must pass before merging
2. **Main Branch** - Tests run on each commit to the main branch
3. **Test Coverage** - Coverage reports are generated to track test coverage

For more information, see the workflow configuration in `.github/workflows/main.yaml`.

