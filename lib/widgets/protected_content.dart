import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:flutter/widgets.dart';

class ProtectedContent extends StatefulWidget {
  const ProtectedContent({required this.child, super.key});

  final Widget child;

  @override
  State<ProtectedContent> createState() => _ProtectedContentState();
}

class _ProtectedContentState extends State<ProtectedContent> {
  late final _protectedContentService = inject<ProtectedContentService>();

  @override
  void initState() {
    super.initState();
    _protectedContentService.enableProtectedContent();
  }

  @override
  void dispose() {
    _protectedContentService.disableProtectedContent();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
