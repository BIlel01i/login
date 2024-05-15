// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class ConfigDevice extends StatefulWidget {
  final DiscoveredDevice device;
  final FlutterReactiveBle ble;

  const ConfigDevice({super.key, required this.device, required this.ble});

  @override
  // ignore: library_private_types_in_public_api
  _ConfigDeviceState createState() => _ConfigDeviceState();
}

class _ConfigDeviceState extends State<ConfigDevice> {
  final TextEditingController _textController = TextEditingController();
  QualifiedCharacteristic? _qualifiedCharacteristic;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _discoverServices();
  }

  void _discoverServices() async {
    // ignore: deprecated_member_use
    final services = await widget.ble.discoverServices(widget.device.id);
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.isWritableWithResponse ||
            characteristic.isWritableWithoutResponse) {
          setState(() {
            _qualifiedCharacteristic = QualifiedCharacteristic(
              serviceId: service.serviceId,
              characteristicId: characteristic.characteristicId,
              deviceId: widget.device.id,
            );
          });
          break;
        }
      }
      if (_qualifiedCharacteristic != null) break;
    }
  }

  void _sendData() async {
    if (_textController.text.isNotEmpty && _qualifiedCharacteristic != null) {
      setState(() {
        _isSending = true;
      });
      try {
        await widget.ble.writeCharacteristicWithResponse(
          _qualifiedCharacteristic!,
          value: _textController.text.codeUnits,
        );

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data sent successfully!")));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to send data: $e")));
      } finally {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configure Device - ${widget.device.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter data to send',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSending ? null : _sendData,
              child: Text(_isSending ? 'Sending...' : 'Set Configuration'),
            ),
          ],
        ),
      ),
    );
  }
}
