import 'package:flutter/material.dart';
import 'package:tawhida_login/archive/archive_ecg.dart';
import 'package:tawhida_login/archive/archive_emg.dart';
import 'package:tawhida_login/archive/archive_glycemie.dart';
import 'package:tawhida_login/archive/archive_rythcar.dart';
import 'package:tawhida_login/archive/archive_spo2.dart';
import 'package:tawhida_login/nav_bar.dart'; // Ensure this is the correct import path for your NavBar

import 'archive_temp.dart';
class Archive extends StatelessWidget {
     final String userId;

  const Archive({super.key, required  this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(userId: userId),
          
          appBar: AppBar(
            
      
          
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              /*IconButton(onPressed: signUserOut,icon:Icon(Icons.logout)),
              const SizedBox(width:10),*/

              
              Image.asset(
                "lib/images/logotaw.png",
                width: 110,
                height: 45,
                fit: BoxFit.cover,
              ),
            ],
          ),
          body: Container(
                  
                  decoration: BoxDecoration(
                  image:DecorationImage(
                    image: AssetImage('lib/images/background.png'),
                    fit:BoxFit.cover,
                  ),
              ), 
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Center(
                        child: Text(
                          'Archives TAWHIDA',
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
                                            builder: (context) =>  Archspo2()));
                                  
            
                               
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
                                            builder: (context) =>  Archecg()));
                                  
            
                                  
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
                                                  builder: (context) =>  Archryth()));
                                        
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
                                "Rythme\nCardiaque",
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
                                onTap: () 
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  Archemg()));
                                  
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
                                            builder: (context) =>  Archglyc()));
                                  
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
                                "Glycemie",
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
                                            builder: (context) =>  Archtemp()));
                                  
                                  
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
                                "Température\nCorporelle",
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