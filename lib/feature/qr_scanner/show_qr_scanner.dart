import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:flutter/material.dart';

/// Shows a QR scanner interface and returns the scan result.
///
/// This function opens a QR code scanner camera view and returns the result
/// after a successful scan. The result is returned as a [QrScanResult] object,
/// or null if the scanning was cancelled or failed.
///
/// Returns a [Future] that completes with the scan result or null.
Future<QrScanResult?> showQrScanner(
  BuildContext context, {
  List<QrScanType> types = QrScanType.values,
}) => Navigator.of(context, rootNavigator: true).push<QrScanResult>(
  MaterialPageRoute(builder: (_) => QrScannerWidget(types: types)),
);
