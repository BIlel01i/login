// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print, prefer_interpolation_to_compose_strings, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tawhida_login/firebase_service/recup_data.dart'; // Make sure this import points to your RecupRealTimeData class
import 'package:tawhida_login/nav_bar.dart';

class TemperaturePage extends StatefulWidget {
  final String
      userId; // This assumes you're passing the userId when creating the page.
  const TemperaturePage({super.key, required this.userId});

  @override
  // ignore: library_private_types_in_public_api
  _TemperaturePageState createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  late RecupRealTimeData recupTemperatureData;

  @override
  void initState() {
    super.initState();
    // Initialize the recupTemperatureData with the specific field 'temperature'
    recupTemperatureData =
        RecupRealTimeData(userId: widget.userId, field: 'temperature');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  NavBar(userId: widget.userId), // Your navigation drawer
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset(
              "lib/images/logotaw.png",
              width: 100,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Body\nTemperature',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center, // Centers the text on the image
                children: [
                  Image.asset(
                    'lib/images/temp3.png',
                    width: 160,
                    height: 150,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: recupTemperatureData.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData && snapshot.data!.data() != null) {
                          var data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          var temperature =
                              data['temperature'].toString() + '°C';
                          return Text(
                            temperature, // Display dynamic temperature data here
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Text(
                            'Error',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      }
                      // Default or loading state
                      return Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'lib/images/temp4.png',
                    width: 150,
                    height: 200,
                  ),
                  Image.asset(
                    'lib/images/temp5.png',
                    width: 150,
                    height: 200,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton('Start', Colors.blue, () {
                    // ignore: avoid_print
                    print('Start pressed');
                  }),
                  const SizedBox(width: 20),
                  _buildButton('Reset', Colors.blue, () {
                    print('Reset pressed');
                  }),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton('Upload', Colors.blue, () {
                    print('Upload pressed');
                  }),
                  const SizedBox(width: 20),
                  _buildButton('Archive', Colors.blue, () {
                    print('Archive pressed');
                  }),
                ],
              ),
              const SizedBox(height: 30),
              Image.asset(
                'lib/images/Mode_Isolation.png',
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(120, 40),
      ),
      child: Text(text),
    );
  }
}
