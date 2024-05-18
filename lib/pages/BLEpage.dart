import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import 'config_device.dart';

class BLEPage extends StatefulWidget {
  const BLEPage({super.key});

  @override
  _BLEPageState createState() => _BLEPageState();
}

class _BLEPageState extends State<BLEPage> {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  final List<DiscoveredDevice> _foundDevices = [];
  final Map<String, StreamSubscription<ConnectionStateUpdate>?>
      _connectionSubscriptions = {};
  final Map<String, bool> _deviceConnectionStates = {};

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
      Permission.location,
    ].request();
  }

  void _startScan() {
    setState(() {
      _isScanning = true;
      _foundDevices.clear();
      _deviceConnectionStates.clear();
    });

    _scanSubscription = _ble.scanForDevices(
      withServices: [],
      scanMode: ScanMode.lowLatency,
    ).listen((device) {
      if (!_foundDevices.any((element) => element.id == device.id)) {
        setState(() {
          _foundDevices.add(device);
          _deviceConnectionStates[device.id] = false;
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
    if (_connectionSubscriptions[deviceId] != null) {
      _connectionSubscriptions[deviceId]!.cancel();
    }
    _connectionSubscriptions[deviceId] = _ble
        .connectToDevice(
      id: deviceId,
      connectionTimeout: const Duration(seconds: 7),
    )
        .listen(
      (connectionState) {
        if (connectionState.connectionState ==
            DeviceConnectionState.connected) {
          setState(() {
            _deviceConnectionStates[deviceId] = true;
          });
          _showToast("Connected to ${connectionState.deviceId}");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ConfigDevice(
                    device: _foundDevices.firstWhere((d) => d.id == deviceId),
                    ble: _ble,
                  )));
        }
      },
      onError: (error) {
        _showToast("Connection Error: $error");
      },
    );
  }

  void _disconnectFromDevice(String deviceId) {
    _connectionSubscriptions[deviceId]?.cancel();
    setState(() {
      _deviceConnectionStates[deviceId] = false;
    });
    _showToast("Disconnected from $deviceId");
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Reactive BLE Example'),
      ),
      body: Stack(
        children: [
          if (_isScanning)
            Center(
              child: Lottie.asset(
                'lib/animations/scanning_animation.json',
                repeat: true,
              ),
            ),
          Column(
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
                      trailing: _buildConnectionButtons(device),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionButtons(DiscoveredDevice device) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!_deviceConnectionStates[device.id]!)
          ElevatedButton(
            onPressed: () => _connectToDevice(device.id),
            child: Text('Connect'),
          ),
        if (_deviceConnectionStates[device.id]!)
          ElevatedButton(
            onPressed: () => _disconnectFromDevice(device.id),
            child: Text('Disconnect'),
          ),
      ],
    );
  }
}
