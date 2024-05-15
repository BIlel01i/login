// ignore_for_file: avoid_print

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleController {
  // This class manages Bluetooth operations
  void startScan() {
    // ignore: prefer_typing_uninitialized_variables
    var flutterBluePlus;
    flutterBluePlus.scanResults.listen((results) {
      print("Found devices: ${results.length}");
      for (var result in results) {
        print("Device found: ${result.device.name} - ${result.device.id}");
      }
    });

    flutterBluePlus.startScan(timeout: Duration(seconds: 10));
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
  }
}
