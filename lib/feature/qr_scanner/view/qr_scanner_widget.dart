import 'dart:math' show pi;

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class QrScannerWidget extends InjectedElementaryWidget<QrScannerWidgetModel>
    with WidgetsBindingObserver {
  const QrScannerWidget({
    required List<QrScanType> types,
    super.key,
  }) : super(
          wmFactoryParam: types,
        );

  @override
  Widget build(QrScannerWidgetModel wm) {
    final scanWindow = wm.scanWindow;

    return Scaffold(
      backgroundColor: wm.theme.colors.background0,
      appBar: DefaultAppBar(
        titleText: LocaleKeys.scanQrCode.tr(),
        onClosePressed: (_) => wm.onResult(),
      ),
      extendBodyBehindAppBar: true,
      body: MobileScanner(
        controller: wm.controller,
        scanWindow: scanWindow,
        overlayBuilder: (_, constraints) => ConstrainedBox(
          constraints: constraints,
          child: Stack(
            children: [
              Positioned.fromRect(
                rect: scanWindow,
                child: CustomPaint(
                  size: scanWindow.size,
                  painter: const _FramePainter(),
                ),
              ),
              Positioned(
                top: scanWindow.top + scanWindow.height,
                left: scanWindow.left,
                width: scanWindow.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: DimensSizeV2.d64),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: DimensSizeV2.d64,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: DimensSizeV2.d8,
                        children: [
                          FloatButton(
                            buttonShape: ButtonShape.circle,
                            icon: LucideIcons.image,
                            onPressed: wm.tryScanPhoto,
                          ),
                          Text(
                            LocaleKeys.photos.tr(),
                            style: wm.theme.textStyles.labelSmall,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: DimensSizeV2.d8,
                        children: [
                          ValueListenableBuilder<MobileScannerState>(
                            valueListenable: wm.controller,
                            builder: (_, state, __) {
                              return FloatButton(
                                buttonShape: ButtonShape.circle,
                                icon: state.torchState == TorchState.on
                                    ? LucideIcons.zapOff
                                    : LucideIcons.zap,
                                onPressed: wm.toggleFlash,
                              );
                            },
                          ),
                          Text(
                            LocaleKeys.flash.tr(),
                            style: wm.theme.textStyles.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FramePainter extends CustomPainter {
  const _FramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 8.0;
    const cornerLength = 40.0;

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Top-left corner
    canvas
      ..drawArc(
        Rect.fromCircle(center: const Offset(radius, radius), radius: radius),
        pi,
        pi / 2,
        false,
        paint,
      )
      ..drawLine(const Offset(radius, 0), const Offset(cornerLength, 0), paint)
      ..drawLine(const Offset(0, radius), const Offset(0, cornerLength), paint)

      // Top-right corner
      ..drawArc(
        Rect.fromCircle(
          center: Offset(size.width - radius, radius),
          radius: radius,
        ),
        3 * pi / 2,
        pi / 2,
        false,
        paint,
      )
      ..drawLine(
        Offset(size.width - cornerLength, 0),
        Offset(size.width - radius, 0),
        paint,
      )
      ..drawLine(
        Offset(size.width, radius),
        Offset(size.width, cornerLength),
        paint,
      )

      // Bottom-left corner
      ..drawArc(
        Rect.fromCircle(
          center: Offset(radius, size.height - radius),
          radius: radius,
        ),
        pi,
        -pi / 2,
        false,
        paint,
      )
      ..drawLine(
        Offset(0, size.height - cornerLength),
        Offset(0, size.height - radius),
        paint,
      )
      ..drawLine(
        Offset(radius, size.height),
        Offset(cornerLength, size.height),
        paint,
      )

      // Bottom-right corner
      ..drawArc(
        Rect.fromCircle(
          center: Offset(size.width - radius, size.height - radius),
          radius: radius,
        ),
        0,
        pi / 2,
        false,
        paint,
      )
      ..drawLine(
        Offset(size.width - cornerLength, size.height),
        Offset(size.width - radius, size.height),
        paint,
      )
      ..drawLine(
        Offset(size.width, size.height - cornerLength),
        Offset(size.width, size.height - radius),
        paint,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
