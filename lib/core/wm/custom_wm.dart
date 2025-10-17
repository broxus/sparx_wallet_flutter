import 'package:app/core/wm/context_wm_mixin.dart';
import 'package:app/core/wm/notifier_subscriptions_mixin.dart';
import 'package:app/di/di.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

/// Custom WidgetModel with additional functionality
///
/// Base class for non-parametrized WidgetModels in Elementary MVVM pattern.
/// Use together with [InjectedElementaryWidget] for widgets that don't need
/// parameters from parent widgets.
///
/// **Usage pattern:**
/// ```dart
/// // Widget
/// class MyScreen extends InjectedElementaryWidget<MyScreenWidgetModel> {
///   const MyScreen({super.key});
/// }
///
/// // WidgetModel
/// @injectable
/// class MyScreenWidgetModel
///     extends CustomWidgetModel<MyScreen, MyScreenModel> {
///   MyScreenWidgetModel(super.model);
/// }
/// ```
class CustomWidgetModel<W extends ElementaryWidget, M extends ElementaryModel>
    extends WidgetModel<W, M>
    with NotifierSubscriptionsMixin, ContextWmMixin {
  CustomWidgetModel(super.model);
}

/// Base widget class for non-parametrized Elementary widgets
///
/// Use for widgets that don't need parameters from parent widgets.
/// Pairs with [CustomWidgetModel] for the non-parametrized pattern.
///
/// **Features:**
/// - Automatic dependency injection of WidgetModel
/// - No need to manually create factory methods
/// - All dependencies resolved via GetIt
///
/// **Example:**
/// ```dart
/// class SplashScreen
///     extends InjectedElementaryWidget<SplashScreenWidgetModel> {
///   const SplashScreen({super.key});
///
///   @override
///   Widget build(SplashScreenWidgetModel wm) {
///     return Scaffold(...);
///   }
/// }
/// ```
///
abstract class InjectedElementaryWidget<WM extends WidgetModel>
    extends ElementaryWidget<WM> {
  const InjectedElementaryWidget({Key? key, this.instanceName})
    : super(_getItFactory, key: key);

  final String? instanceName;
  Type get wmType => WM;
}

/// Base widget class for parametrized Elementary widgets
///
/// Use for widgets that need parameters from parent widgets.
/// Pairs with [CustomWidgetModelParametrized] for the parametrized pattern.
///
/// **Features:**
/// - Pass parameters to WidgetModel via wmFactoryParam
/// - Parameters are reactive and update on widget rebuild
/// - Type-safe parameter passing
///
/// **Example with single parameter:**
/// ```dart
/// class AccountCard extends InjectedElementaryParametrizedWidget<
///     AccountCardWidgetModel, KeyAccount> {
///   const AccountCard({
///     required KeyAccount account,
///     super.key,
///   }) : super(wmFactoryParam: account);
/// }
/// ```
///
/// **Example with multiple parameters:**
/// ```dart
/// // Define params class
/// class MyWidgetParams {
///   final String title;
///   final VoidCallback onTap;
///   const MyWidgetParams({required this.title, required this.onTap});
/// }
///
/// // Use in widget
/// class MyWidget extends InjectedElementaryParametrizedWidget<
///     MyWidgetModel, MyWidgetParams> {
///   MyWidget({
///     required String title,
///     required VoidCallback onTap,
///     super.key,
///   }) : super(wmFactoryParam: MyWidgetParams(title: title, onTap: onTap));
/// }
/// ```
///
abstract class InjectedElementaryParametrizedWidget<
  // ignore: strict_raw_type
  WM extends WidgetModel,
  Param
>
    extends InjectedElementaryWidget<WM> {
  const InjectedElementaryParametrizedWidget({
    // ignore: deprecated_consistency
    required this.wmFactoryParam,
    super.key,
    super.instanceName,
  });

  @Deprecated('Should be used only in WM')
  final Param wmFactoryParam;
}

/// Base class for parametrized WidgetModels in Elementary MVVM pattern
///
/// Use together with [InjectedElementaryParametrizedWidget] for widgets that
/// need parameters from parent widgets. Parameters are reactive and update
/// automatically when widget rebuilds with new values.
///
/// **Features:**
/// - Access parameters via [wmParams] BehaviorSubject
/// - Create reactive notifiers from parameters using [createWmParamsNotifier]
/// - Parameters update automatically on widget rebuild
/// - Full type safety for parameters
///
/// **Example:**
/// ```dart
/// @injectable
/// class AccountCardWidgetModel extends CustomWidgetModelParametrized<
///     AccountCard, AccountCardModel, KeyAccount> {
///   AccountCardWidgetModel(super.model);
///
///   // Access current parameter value
///   KeyAccount get currentAccount => wmParams.value;
///
///   // Create reactive notifier from parameter
///   late final ValueListenable<String> accountName =
///       createWmParamsNotifier((account) => account.name);
///
///   // React to parameter changes
///   @override
///   void initWidgetModel() {
///     super.initWidgetModel();
///     wmParams.listen((account) {
///       // Handle account changes
///     });
///   }
/// }
/// ```
///
class CustomWidgetModelParametrized<
  W extends InjectedElementaryParametrizedWidget<WidgetModel, Param>,
  M extends ElementaryModel,
  Param
>
    extends CustomWidgetModel<W, M> {
  CustomWidgetModelParametrized(super.model);

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

WM _getItFactory<WM extends WidgetModel>(BuildContext context) {
  final injectedElementaryWidget = context.widget as InjectedElementaryWidget;

  try {
    return getIt.get(
          instanceName: injectedElementaryWidget.instanceName,
          type: injectedElementaryWidget.wmType,
        )
        as WM;
  } catch (e, s) {
    _factroryLogger.severe(
      'Failed to create WM for type ${injectedElementaryWidget.wmType}, '
      'by widget $injectedElementaryWidget',
    );
    Error.throwWithStackTrace(e, s);
  }
}
