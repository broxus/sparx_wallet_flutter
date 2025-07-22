import 'package:app/core/wm/context_wm_mixin.dart';
import 'package:app/core/wm/notifier_subscriptions_mixin.dart';
import 'package:app/di/di.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

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
    this.instanceName,
  }) : super(
          _getItFactory,
          key: key,
        );

  final String? instanceName;
  Type get wmType => WM;
}

abstract class InjectedElementaryParametrizedWidget<
    // ignore: strict_raw_type
    WM extends WidgetModel,
    Param> extends InjectedElementaryWidget<WM> {
  const InjectedElementaryParametrizedWidget({
    // ignore: deprecated_consistency
    required this.wmFactoryParam,
    super.key,
    super.instanceName,
  });

  @Deprecated(
    'Should be used only in WM',
  )
  final Param wmFactoryParam;
}

/// Base class for WidgetModels that work with InjectedElementaryWidget
/// and need access to wmFactoryParam with specific type
class InjectedWidgetModel<
    W extends InjectedElementaryParametrizedWidget<WidgetModel, Param>,
    M extends ElementaryModel,
    Param> extends CustomWidgetModel<W, M> {
  InjectedWidgetModel(
    super.model,
  );

  @protected
  final BehaviorSubject<Param> wmParams = BehaviorSubject();

  // ignore: deprecated_member_use_from_same_package
  Param get _widgetParam => widget.wmFactoryParam;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    wmParams.add(_widgetParam);
  }

  @override
  void didUpdateWidget(W oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ignore: deprecated_member_use_from_same_package
    if (oldWidget.wmFactoryParam != _widgetParam) {
      wmParams.add(_widgetParam);
    }
  }

  @override
  void dispose() {
    wmParams.close();
    super.dispose();
  }

  /// Create [ValueNotifier] from WM params stream.
  @protected
  ValueNotifier<T> createWmParamsNotifier<T>(T Function(Param param) convert) {
    return createValueNotifierFromStream<T>(
      convert(wmParams.value),
      wmParams.map(convert).distinct(),
    );
  }
}

final _factroryLogger = Logger('InjectedElementaryWidget');

WM _getItFactory<WM extends WidgetModel>(
  BuildContext context,
) {
  final injectedElementaryWidget = context.widget as InjectedElementaryWidget;

  try {
    return getIt.get(
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
