import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ModalScrollController extends InheritedWidget {
  ModalScrollController({
    required this.controller,
    required Widget child,
    super.key,
  }) : super(
         child: PrimaryScrollController(controller: controller, child: child),
       );

  final ScrollController controller;

  static ScrollController? of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<ModalScrollController>();
    return result?.controller;
  }

  @override
  bool updateShouldNotify(ModalScrollController oldWidget) =>
      controller != oldWidget.controller;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<ScrollController>(
        'controller',
        controller,
        ifNull: 'no controller',
        showName: false,
      ),
    );
  }
}
