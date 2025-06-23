import 'package:app/core/wm/context_wm_mixin.dart';
import 'package:app/core/wm/notifier_subscriptions_mixin.dart';
import 'package:app/di/di.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

/// Custom WidgetModel with additional functionality
///
/// *Kneads mixes:*
/// [NotifierSubscriptionsMixin] for working
/// with subscriptions to [ChangeNotifier]
///
class CustomWidgetModel<W extends ElementaryWidget, M extends ElementaryModel>
    extends WidgetModel<W, M> with NotifierSubscriptionsMixin, ContextWmMixin {
  CustomWidgetModel(
    super.model,
  );
}

abstract class InjectedElementaryWidget<WM extends WidgetModel>
    extends ElementaryWidget<WM> {
  const InjectedElementaryWidget({
    Key? key,
    this.param1,
    this.instanceName,
  }) : super(
          _getItFactory,
          key: key,
        );

  final Object? param1;
  final String? instanceName;
  Type get wmType => WM;
}

final _factroryLogger = Logger('InjectedElementaryWidget');

WM _getItFactory<WM extends WidgetModel>(
  BuildContext context,
) {
  final injectedElementaryWidget = context.widget as InjectedElementaryWidget;

  try {
    return getIt.get(
      param1: injectedElementaryWidget.param1,
      instanceName: injectedElementaryWidget.instanceName,
      type: injectedElementaryWidget.wmType,
    ) as WM;
  } catch (e, s) {
    _factroryLogger.severe(
      'Failed to create WM for type ${injectedElementaryWidget.wmType}, '
      'by widget $injectedElementaryWidget',
    );
    Error.throwWithStackTrace(e, s);
  }
}
