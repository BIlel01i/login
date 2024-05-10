// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tawhida_login/capteurs/ecg_page.dart';
import 'package:tawhida_login/capteurs/emg_page.dart';
import 'package:tawhida_login/capteurs/glycemie_page.dart';
import 'package:tawhida_login/capteurs/rythme_page.dart';
import 'package:tawhida_login/capteurs/spo2_page.dart';
import 'package:tawhida_login/capteurs/temperture_page.dart';
import 'package:tawhida_login/side_Nav/navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
          height: screenSize.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                    child: Text(
                      'Welcome to TAWHIDA !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
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
                                      builder: (context) => const Spo2Page()));
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
                                      builder: (context) => const EcgPage(
                                            userId:
                                                'XYeapz3yTfh4yet5tBGk35eneJm1',
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
                                      builder: (context) =>
                                          const RythmePage()));
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
                                      builder: (context) => const EmgPage()));
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
                                      builder: (context) => const GlycemiePage(
                                          userId:
                                              "RpJP0eVgJrOiAZm1pgVyoRGvwY13")));
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
                                          userId:
                                              "XYeapz3yTfh4yet5tBGk35eneJm1")));
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
      ),
    );
  }
}
