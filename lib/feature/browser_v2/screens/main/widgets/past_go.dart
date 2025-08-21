import 'package:app/feature/browser_v2/widgets/past_go.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';

class PastGoView extends StatelessWidget {
  const PastGoView({
    required this.showState,
    required this.onPressed,
    super.key,
  });

  final ListenableState<bool> showState;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: StateNotifierBuilder(
        listenableState: showState,
        builder: (_, bool? isShow) {
          isShow ??= false;

          return Transform.translate(
            offset: Offset(0, isShow ? 0 : 300),
            child: AnimatedOpacity(
              opacity: isShow ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: Center(
                child: PastGoButton(
                  onPressed: onPressed,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
