import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart' show SourceRange;
import 'package:custom_lint_builder/custom_lint_builder.dart';

// This is the entrypoint of our custom linter
PluginBase createPlugin() => _WmStatePropertiesLinter();

/// Plugin that enforces naming conventions for reactive fields in WidgetModel files
class _WmStatePropertiesLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return [WmPublicGetterNamingRule(), WmPrivateFieldNamingRule()];
  }
}

/// Mixin that provides common functionality for reactive type checking
mixin ReactiveTypeCheckerMixin {
  bool isNotifierOrListenableType(String type) {
    return type.contains('ValueNotifier') ||
        type.contains('ValueListenable') ||
        type.contains('StateNotifier') ||
        type.contains('ListenableState') ||
        type.contains('EntityStateNotifier');
  }

  bool isStreamType(String type) {
    return type.contains('Stream') ||
        type.contains('StreamController') ||
        type.contains('BehaviorSubject');
  }

  bool isReactiveType(String type) {
    return isNotifierOrListenableType(type) || isStreamType(type);
  }

  bool hasValidStateSuffix(String name) {
    return name.endsWith('State') ||
        name.endsWith('Notifier') ||
        name.endsWith('Stream');
  }

  String suggestStateName(String name) {
    if (name.endsWith('State') || name.endsWith('Notifier')) {
      return name;
    }
    return '${name}State';
  }

  String suggestStreamName(String name) {
    if (name.endsWith('Stream')) {
      return name;
    }
    return '${name}Stream';
  }
}

/// Mixin that provides WM file checking
mixin WmFileCheckerMixin {
  bool isWmFile(String path) => path.endsWith('_wm.dart');
}

/// Rule that checks public getters have proper suffixes
class WmPublicGetterNamingRule extends DartLintRule
    with ReactiveTypeCheckerMixin, WmFileCheckerMixin {
  WmPublicGetterNamingRule() : super(code: _code);

  static const _code = LintCode(
    name: 'wm_public_getter_naming',
    problemMessage:
        'Public getter {0} of type {1} must end with "State" suffix',
    correctionMessage: 'Consider renaming to {2}',
    errorSeverity: ErrorSeverity.WARNING,
  );

  static const _streamCode = LintCode(
    name: 'wm_public_getter_naming',
    problemMessage:
        'Public getter {0} of type {1} must end with "Stream" suffix',
    correctionMessage: 'Consider renaming to {2}',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Only check files that end with _wm.dart
    if (!isWmFile(resolver.path)) return;

    context.registry.addMethodDeclaration((node) {
      // Only check getters
      if (!node.isGetter) return;

      // Skip private getters
      final name = node.name.lexeme;
      if (name.startsWith('_')) return;

      // Get the return type
      final returnType = node.returnType;
      if (returnType == null) return;

      final typeString = returnType.toSource();

      // Check if it's a reactive type that needs State suffix
      if (isNotifierOrListenableType(typeString) &&
          !hasValidStateSuffix(name)) {
        final suggestedName = suggestStateName(name);
        reporter.atNode(
          node,
          code,
          arguments: [name, typeString, suggestedName],
        );
      }

      // Check if it's a stream type that needs Stream suffix
      if (isStreamType(typeString) && !name.endsWith('Stream')) {
        final suggestedName = suggestStreamName(name);
        reporter.atNode(
          node,
          _streamCode,
          arguments: [name, typeString, suggestedName],
        );
      }
    });
  }
}

/// Rule that checks private fields match their public getters
class WmPrivateFieldNamingRule extends DartLintRule
    with ReactiveTypeCheckerMixin, WmFileCheckerMixin {
  WmPrivateFieldNamingRule() : super(code: _code);

  static const _code = LintCode(
    name: 'wm_private_field_naming',
    problemMessage: 'Private field {0} should match its public getter name {1}',
    correctionMessage: 'Rename to {2}',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Only check files that end with _wm.dart
    if (!isWmFile(resolver.path)) return;

    final privateFields = <String, FieldDeclaration>{};
    final publicGetters = <String, MethodDeclaration>{};

    // First pass: collect all private fields and public getters
    context.registry.addFieldDeclaration((node) {
      final fields = node.fields;
      for (final variable in fields.variables) {
        final name = variable.name.lexeme;
        if (name.startsWith('_')) {
          privateFields[name] = node;
        }
      }
    });

    context.registry.addMethodDeclaration((node) {
      if (!node.isGetter) return;
      final name = node.name.lexeme;
      if (!name.startsWith('_')) {
        publicGetters[name] = node;
      }
    });

    // Second pass: check if private fields are used in getters and validate naming
    context.registry.addMethodDeclaration((node) {
      if (!node.isGetter) return;
      final getterName = node.name.lexeme;
      if (getterName.startsWith('_')) return;

      // Check if the getter body references a private field
      final body = node.body;
      if (body is ExpressionFunctionBody) {
        final expression = body.expression;
        if (expression is SimpleIdentifier) {
          final fieldName = expression.name;
          if (fieldName.startsWith('_')) {
            final expectedFieldName = '_$getterName';
            if (fieldName != expectedFieldName) {
              // Check if this is a reactive type field
              final returnType = node.returnType?.toSource() ?? '';
              if (isReactiveType(returnType)) {
                reporter.atNode(
                  expression,
                  code,
                  arguments: [fieldName, getterName, expectedFieldName],
                );
              }
            }
          }
        }
      }
    });
  }
}

/// Assist to fix naming issues
class WmNamingAssist extends DartAssist
    with ReactiveTypeCheckerMixin, WmFileCheckerMixin {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    // Only work on _wm.dart files
    if (!isWmFile(resolver.path)) return;

    context.registry.addMethodDeclaration((node) {
      // Check if the target is within this getter
      if (!node.isGetter) return;
      if (!target.intersects(node.sourceRange)) return;

      final name = node.name.lexeme;
      final returnType = node.returnType?.toSource() ?? '';

      // Suggest fixes for public getters
      if (!name.startsWith('_')) {
        if (isNotifierOrListenableType(returnType) &&
            !hasValidStateSuffix(name)) {
          final newName = suggestStateName(name);
          final changeBuilder = reporter.createChangeBuilder(
            message: 'Rename to $newName',
            priority: 1,
          );

          changeBuilder.addDartFileEdit((builder) {
            builder.addSimpleReplacement(node.name.sourceRange, newName);
          });
        } else if (isStreamType(returnType) && !name.endsWith('Stream')) {
          final newName = suggestStreamName(name);
          final changeBuilder = reporter.createChangeBuilder(
            message: 'Rename to $newName',
            priority: 1,
          );

          changeBuilder.addDartFileEdit((builder) {
            builder.addSimpleReplacement(node.name.sourceRange, newName);
          });
        }
      }
    });
  }
}
