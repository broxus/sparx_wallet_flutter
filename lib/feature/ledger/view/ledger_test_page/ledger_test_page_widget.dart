import 'package:app/feature/ledger/ledger.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class LedgerTestPageWidget extends ElementaryWidget<LedgerTestPageWidgetModel> {
  const LedgerTestPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultLedgerTestPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(LedgerTestPageWidgetModel wm) {
    return Scaffold(
      body: SafeArea(
        child: StateNotifierBuilder(
          listenableState: wm.scanResult,
          builder: (_, scanResult) {
            if (scanResult == null) return const SizedBox.shrink();

            return Column(
              children: scanResult.map(
                (e) {
                  final ledger = e.getLedgerDeviceModel();

                  if (ledger == null) {
                    return Text('Unknown device: ${e.device.advName}');
                  }

                  return GestureDetector(
                    onTap: () => wm.connect(e),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Ledger device: ${ledger.productName}'),
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
