import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/utils/utils.dart';

class ScanButtom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3d8bef', 'Cancelar', false, ScanMode.QR);
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        //String barcodeScanRes = 'geo:-25.30740448542779,-57.60401133265003';
        //String barcodeScanRes = 'http://www.leaderit.com.py';
        print(barcodeScanRes);

        if (barcodeScanRes != '-1') {
          final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
          launchURL(context, nuevoScan);
        } else {
          print('Cancelado');
        }
      }, //
      child: Icon(Icons.filter_center_focus),
    );
  }
}
