import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:event_management_app/controllers/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AiBarcodeScanner(
        onDetect: (BarcodeCapture barcodeCapture) {
          if (barcodeCapture.barcodes.first.rawValue != null) {
            Provider.of<EventController>(context, listen: false)
                .validateAttendance(
                    barcodeCapture.barcodes.first.rawValue.toString())
                .then((success) {
              Navigator.pop(context, success);
            });
          }
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
