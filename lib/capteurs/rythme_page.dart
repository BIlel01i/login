// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tawhida_login/pages/recupdata.dart';
import 'package:tawhida_login/side_Nav/navigation.dart'; // Ensure this is the correct import path for your NavBar

class RythmePage extends StatefulWidget {
  final String
      userId; // This assumes you're passing the userId when creating the page.
  // ignore: prefer_const_constructors_in_immutables
  RythmePage({super.key, required this.userId});
  @override
  _RythmePageState createState() => _RythmePageState();
}

class _RythmePageState extends State<RythmePage> {
  late RecupRealTimeData recupTemperatureData;
  @override
  void initState() {
    super.initState();
    // Initialize the recupTemperatureData with the specific field 'temperature'
    recupTemperatureData =
        RecupRealTimeData(userId: widget.userId, field: 'bpm');
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Heart Rate',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Stack(
                    alignment: Alignment
                        .center, // This will center the 'BPM' text over the image
                    children: [
                      Image.asset(
                        'lib/images/temp3.png',
                        width: 180,
                        height: 180,
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
                              var temperature = '${data['spo2']}BPM';
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
                    'lib/images/rythme.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildButton('Start', Colors.blue, () {
                        print('Start pressed');
                      }),
                      const SizedBox(width: 30),
                      _buildButton('Reset', Colors.blue, () {
                        print('Reset pressed');
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildButton('Upload', Colors.blue, () {
                        print('Upload pressed');
                      }),
                      const SizedBox(width: 30),
                      _buildButton('Archive', Colors.blue, () {
                        print('Archive pressed');
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(120, 40), // Set button size
      ),
      child: Text(text),
    );
  }
}
