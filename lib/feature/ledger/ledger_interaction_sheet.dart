import 'dart:async';

import 'package:app/feature/ledger/ledger.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

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
    dismissible: false,
    body: (_, scrollController) => _LedgerInteractionSheet(
      interactionType: interactionType,
      stateStream: stateStream,
    ),
  );
}

const _closeDelay = Duration(seconds: 1);

class _LedgerInteractionSheet extends StatefulWidget {
  const _LedgerInteractionSheet({
    required this.interactionType,
    required this.stateStream,
  });

  final LedgerInteractionType interactionType;
  final Stream<LedgerInteractionState> stateStream;

  @override
  State<_LedgerInteractionSheet> createState() =>
      _LedgerInteractionSheetState();
}

class _LedgerInteractionSheetState extends State<_LedgerInteractionSheet> {
  StreamSubscription<LedgerInteractionState>? _stateSubscription;
  var _currentState = LedgerInteractionState.connecting;

  @override
  void initState() {
    super.initState();
    _stateSubscription = widget.stateStream.listen((state) {
      if (state == LedgerInteractionState.done ||
          state == LedgerInteractionState.cancelled) {
        _stateSubscription?.cancel();
        _close();
      }
    });
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: DimensSizeV2.d16,
      children: [
        Text(
          LocaleKeys.confirmAction.tr(),
          style: theme.textStyles.headingMedium,
          textAlign: TextAlign.center,
        ),
        StreamBuilder<LedgerInteractionState>(
          stream: widget.stateStream,
          builder: (_, snapshot) {
            final state = snapshot.data ?? LedgerInteractionState.connecting;

            if (state != LedgerInteractionState.cancelled) {
              // skip interface update if interaction was cancelled
              _currentState = state;
            }

            return LedgerStatusContainer(
              steps: [
                LedgerInteractionStep(
                  title: LocaleKeys.ledgerStepConnectTitle.tr(),
                  state: _currentState == LedgerInteractionState.connecting
                      ? LedgerInteractionStepState.loading
                      : LedgerInteractionStepState.success,
                ),
                LedgerInteractionStep(
                  title: LocaleKeys.ledgerStepAppTitle.tr(),
                  state: switch (_currentState) {
                    LedgerInteractionState.connecting =>
                      LedgerInteractionStepState.initial,
                    LedgerInteractionState.initializing =>
                      LedgerInteractionStepState.loading,
                    _ => LedgerInteractionStepState.success,
                  },
                ),
                if (widget.interactionType.needsConfirmation)
                  LedgerInteractionStep(
                    title: switch (widget.interactionType) {
                      LedgerInteractionType.signTransaction =>
                        LocaleKeys.ledgerStepConfirmTxTitle.tr(),
                      LedgerInteractionType.sign =>
                        LocaleKeys.ledgerStepConfirmActionTitle.tr(),
                      _ => '',
                    },
                    state: switch (_currentState) {
                      LedgerInteractionState.confirming =>
                        LedgerInteractionStepState.loading,
                      LedgerInteractionState.done =>
                        LedgerInteractionStepState.success,
                      _ => LedgerInteractionStepState.initial,
                    },
                  ),
              ],
            );
          },
        ),
        StreamBuilder<LedgerInteractionState>(
          stream: widget.stateStream,
          builder: (_, snapshot) {
            final state = snapshot.data ?? LedgerInteractionState.connecting;

            return DestructiveButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.cancelWord.tr(),
              isLoading: switch (state) {
                LedgerInteractionState.connecting ||
                LedgerInteractionState.initializing =>
                  false,
                _ => true,
              },
              onPressed: () => Navigator.of(context).pop(),
            );
          },
        ),
      ],
    );
  }

  Future<void> _close() async {
    await Future<void>.delayed(_closeDelay);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
