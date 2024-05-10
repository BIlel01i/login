// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:tawhida_login/side_Nav/navigation.dart'; // Ensure this is the correct import path for your NavBar

class EmgPage extends StatefulWidget {
  const EmgPage({super.key});

  @override
  _EmgPageState createState() => _EmgPageState();
}

class _EmgPageState extends State<EmgPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // This makes the animation go back and forth

    _animation = IntTween(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(), // Your navigation drawer
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
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
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
                Expanded(
                  child: orientationLayout(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget orientationLayout() {
    var orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? portraitLayout()
        : landscapeLayout();
  }

  Widget portraitLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30, top: 40),
                child: Text(
                  'EMG',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (_, __) => Image.asset(
                  _animation.value == 0
                      ? 'lib/images/icon1.png'
                      : 'lib/images/icon2.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Image.asset(
                'lib/images/emg1.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
          buttonsRow(),
          Center(
            child: Image.asset(
              'lib/images/Mode_Isolation.png',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget landscapeLayout() {
    return const Center(
      child: Text("Landscape mode - Show real-time chart here"),
    );
  }

  Widget buttonsRow() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('Start', Colors.blue, () {}),
              _buildButton('Reset', Colors.blue, () {}),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('Upload', Colors.blue, () {
                print('Upload pressed');
              }),
              _buildButton('Archive', Colors.blue, () {
                print('Archive pressed');
              }),
            ],
          ),
        ),
      ],
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
