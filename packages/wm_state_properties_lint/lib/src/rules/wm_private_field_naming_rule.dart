import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart' show LintCode;

import 'reactive_type_matcher.dart';

class WmPrivateFieldNamingRule extends AnalysisRule {
  static const LintCode _code = LintCode(
    'wm_private_field_naming',
    'Private field {0} should match its public getter name {1}',
    correctionMessage: 'Rename to {2}',
  );

  WmPrivateFieldNamingRule()
    : super(
        name: 'wm_private_field_naming',
        description:
            'Enforce private backing field names for reactive getters.',
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

  final WmPrivateFieldNamingRule rule;
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

    final getterName = node.name.lexeme;
    if (getterName.startsWith('_')) {
      return;
    }

    final returnType = node.returnType;
    if (returnType == null ||
        !ReactiveTypeMatcher.isReactiveType(returnType.toSource())) {
      return;
    }

    final body = node.body;
    if (body is! ExpressionFunctionBody) {
      return;
    }

    final expression = body.expression;
    if (expression is! SimpleIdentifier) {
      return;
    }

    final fieldName = expression.name;
    if (!fieldName.startsWith('_')) {
      return;
    }

    final expectedFieldName = '_$getterName';
    if (fieldName == expectedFieldName) {
      return;
    }

    rule.reportAtNode(
      expression,
      arguments: [fieldName, getterName, expectedFieldName],
    );
  }
}
