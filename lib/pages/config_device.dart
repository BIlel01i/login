// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'HomePage.dart';

class ConfigDevice extends StatefulWidget {
  final DiscoveredDevice device;
  final FlutterReactiveBle ble;

  const ConfigDevice({super.key, required this.device, required this.ble});

  @override
  _ConfigDeviceState createState() => _ConfigDeviceState();
}

class _ConfigDeviceState extends State<ConfigDevice> {
  final TextEditingController _ssidController = TextEditingController();
  final TextEditingController _ssidPwController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emailPwController = TextEditingController();
  QualifiedCharacteristic? _qualifiedCharacteristic;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _discoverServices();
  }

  void _discoverServices() async {
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
    final dataToSend =
        "${_ssidController.text};${_ssidPwController.text};${_emailController.text};${_emailPwController.text}";
    if (dataToSend.trim().isNotEmpty && _qualifiedCharacteristic != null) {
      setState(() {
        _isSending = true;
      });
      try {
        await widget.ble.writeCharacteristicWithResponse(
          _qualifiedCharacteristic!,
          value: dataToSend.codeUnits,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Data sent successfully!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send data: $e")),
        );
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
        title: Text(
          'Configure Device - ${widget.device.name}',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 15,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _ssidController,
                    decoration: InputDecoration(
                      labelText: 'SSID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _ssidPwController,
                    decoration: InputDecoration(
                      labelText: 'SSID Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailPwController,
                    decoration: InputDecoration(
                      labelText: 'Password Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _isSending ? null : _sendData,
                        child: Text(
                            _isSending ? 'Sending...' : 'Set Configuration'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Use Navigator to push HomePage
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      fromLoginPage: true,
                                    )),
                          );
                        },
                        child: Text('Go to Home Page'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
