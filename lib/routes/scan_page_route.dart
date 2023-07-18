import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPageRoute extends StatefulWidget {
  const ScanPageRoute({Key? key}) : super(key: key);

  @override
  State<ScanPageRoute> createState() => _ScanPageRouteState();
}

class _ScanPageRouteState extends State<ScanPageRoute> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                "  Please clean the lens if not working.",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width - 50,
                  width: MediaQuery.of(context).size.width - 50,
                  child: QRView(
                    overlay: QrScannerOverlayShape(
                      borderRadius: 20,
                      borderLength: 100,
                    ),
                    key: qrKey,
                    onQRViewCreated: (controller) {
                      this.controller = controller;
                    },
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
