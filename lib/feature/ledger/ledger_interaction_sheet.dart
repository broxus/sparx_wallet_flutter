import 'package:app/feature/ledger/ledger.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum LedgerInteractionState {
  connecting,
  initializing,
  confirming,
  done,
  cancelled,
}

Future<void> showLedgerInteractionSheet({
  required BuildContext context,
  required LedgerInteractionType interactionType,
  required Stream<LedgerInteractionState> stateStream,
}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, scrollController) => _LedgerInteractionSheet(
      interactionType: interactionType,
      stateStream: stateStream,
    ),
  );
}

class _LedgerInteractionSheet extends StatelessWidget {
  const _LedgerInteractionSheet({
    required this.interactionType,
    required this.stateStream,
  });

  final LedgerInteractionType interactionType;
  final Stream<LedgerInteractionState> stateStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LedgerInteractionState>(
      stream: stateStream,
      builder: (context, snapshot) {
        final state = snapshot.data ?? LedgerInteractionState.connecting;
        return Column(
          children: [
            Text('Interaction Type: $interactionType'),
            Text('Current State: $state'),
          ],
        );
      },
    );
  }
}
