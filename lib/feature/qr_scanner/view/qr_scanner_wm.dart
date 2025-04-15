import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

QrScannerWidgetModel defaultQrScannerWidgetModelFactory(
  BuildContext context,
) =>
    QrScannerWidgetModel(
      QrScannerModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class QrScannerWidgetModel
    extends CustomWidgetModel<QrScannerWidget, QrScannerModel> {
  QrScannerWidgetModel(super.model);

  // late final _selected = createNotifier(_initialSelectedAccount);

  // ListenableState<KeyAccount?> get selected => _selected;

  final MobileScannerController controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
  );

  StreamSubscription<BarcodeCapture>? _barcodeSubscription;
  StreamSubscription<AppLifecycleState>? _appStateSubscription;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Rect get scanWindow => MediaQuery.sizeOf(context).let(
        (size) => Rect.fromCenter(
          center: size.center(const Offset(0, -DimensSizeV2.d64)),
          width: (size.width * 0.65).roundToDouble(),
          height: (size.width * 0.65).roundToDouble(),
        ),
      );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _appStateSubscription =
        model.appLifecycleStateStream.listen(_onAppLifecycleState);
    _barcodeSubscription =
        controller.barcodes.listen(_onBarcode, onError: _onError);
    controller.start();
  }

  @override
  void dispose() {
    _appStateSubscription?.cancel();
    _barcodeSubscription?.cancel();
    controller.dispose();
    super.dispose();
  }

  void toggleFlash() => controller.toggleTorch();

  Future<void> tryScanPhoto() async {
    final isGranted = await model.requestPhotos();

    if (!isGranted) {
      if (contextSafe != null) {
        model.showMessage(
          Message.error(
            context: contextSafe,
            message: LocaleKeys.givePhotosPermission.tr(),
            actionText: LocaleKeys.giveWord.tr(),
            onAction: model.openSettings,
          ),
        );
      }
      return;
    }

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      final value = await controller.analyzeImage(image.path);

      if (value != null) {
        _onBarcode(value);
      } else {
        model.showMessage(
          Message.error(
            context: contextSafe,
            message: LocaleKeys.qrScannerError.tr(),
          ),
        );
      }
    }
  }

  void onResult([QrScanResult? result]) {
    // https://github.com/juliansteenbakker/mobile_scanner/issues/510
    // double event workaround
    _barcodeSubscription?.cancel();

    final navigator = Navigator.of(context);

    if (navigator.canPop()) {
      navigator.pop(result);
    }
  }

  void _onBarcode(BarcodeCapture value) {
    QrScanResult? result;

    for (final barcode in value.barcodes) {
      final rawValue = barcode.rawValue;
      if (rawValue == null) return;

      result = model.tryGetResult(value: rawValue, types: widget.types);
      if (result != null) break;
    }

    if (result != null) {
      onResult(result);
    }
  }

  void _onError(Object error) {
    if (error is MobileScannerBarcodeException) {
      model.showMessage(
        Message.error(
          context: context,
          message: error.message ?? error.toString(),
        ),
      );

      return;
    }
  }

  void _onAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.hasCameraPermission) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _barcodeSubscription =
            controller.barcodes.listen(_onBarcode, onError: _onError);
        controller.start();

      case AppLifecycleState.inactive:
        _barcodeSubscription?.cancel();
        _barcodeSubscription = null;
        controller.stop();

      // ignore: no_default_cases
      default:
        break; // Do nothing for other states.
    }
  }

  Future<void> checkCameraPermission() async {
    final isGranted = await model.requestCamera();

    if (!isGranted && contextSafe != null) {
      model.showMessage(
        Message.error(
          context: contextSafe,
          message: LocaleKeys.givePermissions.tr(),
          actionText: LocaleKeys.giveWord.tr(),
          onAction: model.openSettings,
        ),
      );
    }
  }
}
