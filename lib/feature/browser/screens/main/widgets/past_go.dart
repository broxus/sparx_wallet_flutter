import 'package:app/feature/browser/widgets/past_go.dart';
import 'package:flutter/cupertino.dart';

class PastGoView extends StatelessWidget {
  const PastGoView({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: PastGoButton(onPressed: onPressed),
    );
  }
}
