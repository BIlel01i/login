// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawhida_login/capteurs/ecg_page.dart';
import 'package:tawhida_login/capteurs/emg_page.dart';
import 'package:tawhida_login/capteurs/glycemie_page.dart';
import 'package:tawhida_login/capteurs/rythme_page.dart';
import 'package:tawhida_login/capteurs/spo2_page.dart';
import 'package:tawhida_login/capteurs/temperture_page.dart';
import 'package:tawhida_login/pages/BLEpage.dart';
import 'package:tawhida_login/pages/dashbord.dart';
import 'package:tawhida_login/side_Nav/navigation.dart';

class HomePage extends StatefulWidget {
  final bool fromLoginPage;

  const HomePage({super.key, required this.fromLoginPage});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userId = FirebaseAuth.instance.currentUser?.uid ?? 'defaultUserId';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.fromLoginPage && await _shouldShowConfigurationDialog()) {
        _showConfigurationDialog(context);
      }
    });
  }

  Future<bool> _shouldShowConfigurationDialog() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('showConfigurationDialog') ?? true;
  }

  Future<void> _setConfigurationDialogShown(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showConfigurationDialog', value);
  }

  void _showConfigurationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool keepConfiguration = false;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Configuration'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      "Would you like to keep the last device configuration?"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: keepConfiguration,
                            onChanged: (bool? value) {
                              setState(() {
                                keepConfiguration = value ?? false;
                              });
                            },
                          ),
                          const Text('Yes'),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: !keepConfiguration,
                            onChanged: (bool? value) {
                              setState(() {
                                keepConfiguration = !(value ?? false);
                              });
                            },
                          ),
                          const Text('No'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(); // Close the dialog
                    if (keepConfiguration) {
                      await _setConfigurationDialogShown(false);
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BLEPage(),
                        ),
                      );
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavBar(), // Your navigation drawer
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
          height: screenSize.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'Welcome to Your Tawhida !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              dashBorad()), // Navigate to Dashboard
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Text color
                  ),
                  child: const Text('Switch to Dashboard'),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Spo2Page(userId)));
                          },
                          child: Container(
                            height: 116,
                            width: 103,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 30,
                                  offset: const Offset(0.5, 0.5),
                                )
                              ],
                            ),
                            child: const SizedBox(
                              height: 45,
                              width: 45,
                              child: ImageIcon(
                                AssetImage("lib/images/spo2.png"),
                                color: Color.fromRGBO(31, 128, 195, 1),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0.1),
                        const Text(
                          "SpO2",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EcgPage(userId)));
                          },
                          child: Container(
                            height: 116,
                            width: 103,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 30,
                                  offset: const Offset(0.5, 0.5),
                                )
                              ],
                            ),
                            child: const SizedBox(
                              height: 45,
                              width: 45,
                              child: ImageIcon(
                                AssetImage("lib/images/ECG.png"),
                                color: Color.fromRGBO(31, 128, 195, 1),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0.1),
                        const Text(
                          "ECG",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RythmePage(userId)));
                          },
                          child: Container(
                            height: 116,
                            width: 103,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 30,
                                  offset: const Offset(0.5, 0.5),
                                )
                              ],
                            ),
                            child: const SizedBox(
                              height: 45,
                              width: 45,
                              child: ImageIcon(
                                AssetImage("lib/images/RC.png"),
                                color: Color.fromRGBO(31, 128, 195, 1),
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0.5),
                        const Text(
                          "Heart\nRate",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmgPage(userId)));
                          },
                          child: Container(
                            height: 116,
                            width: 103,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 30,
                                  offset: const Offset(0.05, 0.05),
                                )
                              ],
                            ),
                            child: const SizedBox(
                              height: 50,
                              width: 50,
                              child: ImageIcon(
                                AssetImage("lib/images/EMG.png"),
                                color: Color.fromRGBO(31, 128, 195, 1),
                                size: 45,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0.1),
                        const Text(
                          "EMG",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GlycemiePage(
                                          userId: userId,
                                        )));
                          },
                          child: Container(
                            height: 116,
                            width: 103,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 30,
                                  offset: const Offset(0.5, 0.5),
                                )
                              ],
                            ),
                            child: const SizedBox(
                              height: 45,
                              width: 45,
                              child: ImageIcon(
                                AssetImage("lib/images/GLC.png"),
                                color: Color.fromRGBO(31, 128, 195, 1),
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0.5),
                        const Text(
                          "Blood Sugar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TemperaturePage(
                                          userId,
                                        )));
                          },
                          child: Container(
                            height: 116,
                            width: 103,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 30,
                                  offset: const Offset(0.1, 0.1),
                                )
                              ],
                            ),
                            child: const SizedBox(
                              height: 45,
                              width: 45,
                              child: ImageIcon(
                                AssetImage("lib/images/TC.png"),
                                color: Color.fromRGBO(31, 128, 195, 1),
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 0.1),
                        const Text(
                          "Body\nTemperature",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
