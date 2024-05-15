// ignore_for_file: avoid_print, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tawhida_login/pages/recupdata.dart';
import 'package:tawhida_login/side_Nav/navigation.dart';

class Spo2Page extends StatefulWidget {
  final String
      userId; // This assumes you're passing the userId when creating the page.
  Spo2Page({super.key, required this.userId});
  @override
  // ignore: library_private_types_in_public_api
  _Spo2PageState createState() => _Spo2PageState();
}

class _Spo2PageState extends State<Spo2Page> {
  late RecupRealTimeData recupTemperatureData;
  @override
  void initState() {
    super.initState();
    // Initialize the recupTemperatureData with the specific field 'temperature'
    recupTemperatureData =
        RecupRealTimeData(userId: widget.userId, field: 'spo2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(), // Your navigation drawer
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
              const SizedBox(height: 30),
              const Text(
                "SpO2",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Stack(
                  alignment:
                      Alignment.center, // Centers the '%' text on the image
                  children: [
                    Image.asset(
                      'lib/images/temp3.png',
                      width: 200, // Responsive width
                      height: 200, // Responsive height
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: recupTemperatureData.stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData &&
                              snapshot.data!.data() != null) {
                            var data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            var temperature = '${data['spo2']}%';
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
              ),
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'lib/images/spo2im1.png',
                  width: 150,
                  height: 150,
                ),
              ),

              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton('Start', Colors.blue, () {
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
              const SizedBox(height: 200), // Bottom spacing
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
        minimumSize:
            const Size(120, 40), // Ensuring the button size is consistent
      ),
      child: Text(text),
    );
  }
}
