import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothProvider with ChangeNotifier {
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> _devices = [];

  List<BluetoothDevice> get devices => _devices;

  // Bluetoothのスキャン開始
  void startScan() {
    _flutterBlue.startScan(timeout: Duration(seconds: 5));

    _flutterBlue.scanResults.listen((results) {
      for (final result in results) {
        if (!_devices.contains(result.device)) {
          _devices.add(result.device);
          notifyListeners();
        }
      }
    });

    _flutterBlue.stopScan();
  }

  // Bluetoothのスキャン停止
  void stopScan() {
    _flutterBlue.stopScan();
  }
}
