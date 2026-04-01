// ignore_for_file: non_constant_identifier_names

import 'package:analyzer/src/lint/registry.dart'; // ignore: implementation_imports
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';
import 'package:wm_state_properties_lint/src/rules/wm_private_field_naming_rule.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(WmPrivateFieldNamingRuleTest);
  });
}

@reflectiveTest
class WmPrivateFieldNamingRuleTest extends AnalysisRuleTest {
  late WmPrivateFieldNamingRule _rule;

  @override
  String get analysisRule => 'wm_private_field_naming';

  @override
  void setUp() {
    _rule = WmPrivateFieldNamingRule();
    Registry.ruleRegistry.registerWarningRule(_rule);
    super.setUp();
  }

  @override
  Future<void> tearDown() async {
    Registry.ruleRegistry.unregisterWarningRule(_rule);
    await super.tearDown();
  }

  Future<void> _assertLintAtToken(
    String filePath,
    String code,
    String token,
  ) async {
    newFile(filePath, code);
    final offset = code.indexOf(token);
    expect(offset, isNot(-1));
    await assertDiagnosticsInFile(filePath, [lint(offset, token.length)]);
  }

  void test_noDiagnostics_forNonReactiveGetter() async {
    const code = r'''
class TestWm {
  int get countState => _count;

  final int _count = 0;
}
''';

    final filePath = convertPath('$testPackageLibPath/test_wm.dart');
    newFile(filePath, code);
    await assertNoDiagnosticsInFile(filePath);
  }

  void test_noDiagnostics_forNonWmFile() async {
    const code = r'''
class ValueListenable<T> {}

final ValueListenable<bool> _value = ValueListenable<bool>();

class TestWm {
  ValueListenable<bool> get isLoadingState => _isLoading;

  final ValueListenable<bool> _isLoading = _value;
}
''';

    final filePath = convertPath('$testPackageLibPath/not_wm_file.dart');
    newFile(filePath, code);
    await assertNoDiagnosticsInFile(filePath);
  }

  void test_noDiagnostics_whenBackingFieldMatchesGetter() async {
    const code = r'''
class ValueListenable<T> {}

final ValueListenable<bool> _value = ValueListenable<bool>();

class TestWm {
  ValueListenable<bool> get isLoadingState => _isLoadingState;

  final ValueListenable<bool> _isLoadingState = _value;
}
''';

    final filePath = convertPath('$testPackageLibPath/test_wm.dart');
    newFile(filePath, code);
    await assertNoDiagnosticsInFile(filePath);
  }

  void test_noDiagnostics_whenGetterBodyIsNotSimpleIdentifier() async {
    const code = r'''
class ValueListenable<T> {}

final ValueListenable<bool> _value = ValueListenable<bool>();

class TestWm {
  ValueListenable<bool> get isLoadingState {
    return _isLoading;
  }

  final ValueListenable<bool> _isLoading = _value;
}
''';

    final filePath = convertPath('$testPackageLibPath/test_wm.dart');
    newFile(filePath, code);
    await assertNoDiagnosticsInFile(filePath);
  }

  void test_reportsMismatchedBackingFieldForReactiveGetter() async {
    const code = r'''
class ValueListenable<T> {}

final ValueListenable<bool> _value = ValueListenable<bool>();

class TestWm {
  ValueListenable<bool> get isLoadingState => _isLoading;

  final ValueListenable<bool> _isLoading = _value;
}
''';

    final filePath = convertPath('$testPackageLibPath/test_wm.dart');
    await _assertLintAtToken(filePath, code, '_isLoading');
  }
}
