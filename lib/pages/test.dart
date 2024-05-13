import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MaterialApp(home: BLEPage()));

class BLEPage extends StatefulWidget {
  @override
  _BLEPageState createState() => _BLEPageState();
}

class _BLEPageState extends State<BLEPage> {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  List<DiscoveredDevice> _foundDevices = [];
  DiscoveredDevice? _connectedDevice;
  StreamSubscription<ConnectionStateUpdate>? _connectionSubscription;
  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  void _requestPermissions() async {
    await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location
    ].request();
  }

  void _startScan() {
    setState(() {
      _isScanning = true;
      _foundDevices.clear();
    });
    _scanSubscription = _ble.scanForDevices(
      withServices: [],
      scanMode: ScanMode.lowLatency,
    ).listen((device) {
      if (!_foundDevices.any((element) => element.id == device.id)) {
        setState(() {
          _foundDevices.add(device);
        });
      }
    }, onDone: _stopScan);
  }

  void _stopScan() {
    _scanSubscription?.cancel();
    setState(() {
      _isScanning = false;
    });
  }

  void _connectToDevice(String deviceId) {
    if (_connectionSubscription != null) {
      _connectionSubscription!.cancel();
    }
    _connectionSubscription = _ble
        .connectToDevice(
      id: deviceId,
      connectionTimeout: const Duration(seconds: 10),
    )
        .listen(
      (connectionState) {
        if (connectionState.connectionState ==
            DeviceConnectionState.connected) {
          setState(() {
            _connectedDevice =
                _foundDevices.firstWhere((device) => device.id == deviceId);
          });
        }
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Connection Error"),
            content: Text("Failed to connect. Error: $error"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _disconnectFromDevice() {
    _connectionSubscription?.cancel();
    setState(() {
      _connectedDevice = null;
    });
  }

  @override
  void dispose() {
    _stopScan();
    _disconnectFromDevice();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Reactive BLE Example'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _isScanning ? null : _startScan,
            child: Text(_isScanning ? 'Scanning...' : 'Start Scanning'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _foundDevices.length,
              itemBuilder: (context, index) {
                final device = _foundDevices[index];
                return ListTile(
                  title: Text(
                      device.name.isEmpty ? "Unknown Device" : device.name),
                  subtitle: Text(device.id),
                  trailing: ElevatedButton(
                    onPressed: () => _connectToDevice(device.id),
                    child: Text('Connect'),
                  ),
                );
              },
            ),
          ),
          if (_connectedDevice != null)
            ElevatedButton(
              onPressed: _disconnectFromDevice,
              child:
                  Text('Disconnect from ${_connectedDevice?.name ?? "Device"}'),
            ),
        ],
      ),
    );
  }
}
