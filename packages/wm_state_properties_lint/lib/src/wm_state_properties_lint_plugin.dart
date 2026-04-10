import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';

import 'rules/wm_private_field_naming_rule.dart';
import 'rules/wm_public_getter_naming_rule.dart';

class WmStatePropertiesLintPlugin extends Plugin {
  @override
  String get name => 'WM state properties lint';

  @override
  void register(PluginRegistry registry) {
    registry.registerWarningRule(WmPublicGetterNamingRule());
    registry.registerWarningRule(WmPrivateFieldNamingRule());
  }
}
