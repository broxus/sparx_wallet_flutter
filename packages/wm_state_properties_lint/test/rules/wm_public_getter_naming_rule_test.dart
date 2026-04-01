// ignore_for_file: non_constant_identifier_names

import 'package:analyzer/src/lint/registry.dart'; // ignore: implementation_imports
import 'package:analyzer_testing/analysis_rule/analysis_rule.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';
import 'package:wm_state_properties_lint/src/rules/wm_public_getter_naming_rule.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(WmPublicGetterNamingRuleTest);
  });
}

@reflectiveTest
class WmPublicGetterNamingRuleTest extends AnalysisRuleTest {
  late WmPublicGetterNamingRule _rule;

  @override
  String get analysisRule => 'wm_public_getter_naming';

  @override
  void setUp() {
    _rule = WmPublicGetterNamingRule();
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
    final getterToken = 'get $token';
    final getterOffset = code.indexOf(getterToken);
    final offset = getterOffset == -1
        ? code.indexOf(token)
        : getterOffset + 'get '.length;
    expect(offset, isNot(-1));
    await assertDiagnosticsInFile(filePath, [lint(offset, token.length)]);
  }

  void test_noDiagnostics_forNonWmFile() async {
    const code = r'''
class ValueListenable<T> {}

final ValueListenable<bool> reactiveValue = ValueListenable<bool>();

class TestWm {
  ValueListenable<bool> get isLoading => reactiveValue;
}
''';

    final filePath = convertPath('$testPackageLibPath/not_wm_file.dart');

    newFile(filePath, code);
    await assertNoDiagnosticsInFile(filePath);
  }

  void test_reportsNotifierGetterWithoutSuffix() async {
    const code = r'''
class ValueListenable<T> {}

final ValueListenable<bool> reactiveValue = ValueListenable<bool>();

class TestWm {
  ValueListenable<bool> get isLoading => reactiveValue;
}
''';

    final filePath = convertPath('$testPackageLibPath/test_wm.dart');
    await _assertLintAtToken(filePath, code, 'isLoading');
  }

  void test_reportsStreamGetterWithoutSuffix() async {
    const code = r'''
class Stream<T> {}

final Stream<int> eventsValue = Stream<int>();

class TestWm {
  Stream<int> get events => eventsValue;
}
''';

    final filePath = convertPath('$testPackageLibPath/test_wm.dart');
    await _assertLintAtToken(filePath, code, 'events');
  }

  void test_allowsNotifierAndStateSuffixes() async {
    const code = r'''
class ValueNotifier<T> {}

final ValueNotifier<int> notifierValue = ValueNotifier<int>();

class TestWm {
  ValueNotifier<int> get amountState => notifierValue;
  ValueNotifier<int> get amountNotifier => notifierValue;
}
''';

    final filePath = convertPath('$testPackageLibPath/test_wm.dart');
    newFile(filePath, code);
    await assertNoDiagnosticsInFile(filePath);
  }

  void test_allowsNotifierTypeWithStreamSuffix_forParity() async {
    const code = r'''
class ValueNotifier<T> {}

final ValueNotifier<int> notifierValue = ValueNotifier<int>();

class TestWm {
  ValueNotifier<int> get amountStream => notifierValue;
}
''';

    final filePath = convertPath('$testPackageLibPath/test_wm.dart');
    newFile(filePath, code);
    await assertNoDiagnosticsInFile(filePath);
  }

  void test_allowsStreamSuffix() async {
    const code = r'''
class Stream<T> {}

final Stream<int> eventsValue = Stream<int>();

class TestWm {
  Stream<int> get eventsStream => eventsValue;
}
''';

    final filePath = convertPath('$testPackageLibPath/test_wm.dart');
    newFile(filePath, code);
    await assertNoDiagnosticsInFile(filePath);
  }

  void test_ignoresPrivateGetter() async {
    const code = r'''
class ValueListenable<T> {}

final ValueListenable<bool> reactiveValue = ValueListenable<bool>();

class TestWm {
  ValueListenable<bool> get _isLoading => reactiveValue;
}
''';

    final filePath = convertPath('$testPackageLibPath/test_wm.dart');
    newFile(filePath, code);
    await assertNoDiagnosticsInFile(filePath);
  }
}
