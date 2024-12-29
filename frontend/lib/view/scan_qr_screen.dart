import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AiBarcodeScanner(
        onDetect: (BarcodeCapture barcodeCapture) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${barcodeCapture.barcodes.first.rawValue}'),
          ));
          Navigator.pop(context);
        },
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        ),
        bottomSheetBuilder: (context, controller) {
          return Container(height: 0);
        },
        validator: (value) {
          if (value.barcodes.isEmpty) {
            return false;
          }
          return true;
        },
      ),
    );
  }
}
