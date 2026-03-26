import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' show LintCode;

import 'reactive_type_matcher.dart';

class WmPublicGetterNamingRule extends AnalysisRule {
  static const LintCode _code = LintCode(
    'wm_public_getter_naming',
    'Public getter {0} of type {1} must end with "{2}" suffix',
    correctionMessage: 'Consider renaming to {3}',
  );

  WmPublicGetterNamingRule()
    : super(
        name: 'wm_public_getter_naming',
        description: 'Enforce naming suffixes for reactive public getters.',
      );

  @override
  LintCode get diagnosticCode => _code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    registry.addMethodDeclaration(this, _Visitor(this, context));
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final WmPublicGetterNamingRule rule;
  final RuleContext context;

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    final path =
        context.currentUnit?.file.path ?? context.definingUnit.file.path;
    if (!ReactiveTypeMatcher.isWmFilePath(path)) {
      return;
    }

    if (!node.isGetter) {
      return;
    }

    final name = node.name.lexeme;
    if (name.startsWith('_')) {
      return;
    }

    final returnType = node.returnType;
    if (returnType == null) {
      return;
    }

    final typeString = returnType.toSource();

    if (ReactiveTypeMatcher.isNotifierOrListenableType(typeString) &&
        !ReactiveTypeMatcher.hasValidNotifierSuffix(name)) {
      final suggestedName = ReactiveTypeMatcher.suggestNotifierName(name);
      rule.reportAtToken(
        node.name,
        arguments: [
          name,
          typeString,
          'State, Notifier, or Stream',
          suggestedName,
        ],
      );
    }

    if (ReactiveTypeMatcher.isStreamType(typeString) &&
        !ReactiveTypeMatcher.hasValidStreamSuffix(name)) {
      final suggestedName = ReactiveTypeMatcher.suggestStreamName(name);
      rule.reportAtToken(
        node.name,
        arguments: [name, typeString, 'Stream', suggestedName],
      );
    }
  }
}
