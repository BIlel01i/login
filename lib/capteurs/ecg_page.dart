// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tawhida_login/pages/recupdata.dart';
import 'package:tawhida_login/side_nav/navigation.dart';

class EcgPage extends StatefulWidget {
  const EcgPage(String userId, {super.key});

  @override
  _EcgPageState createState() => _EcgPageState();
}

class _EcgPageState extends State<EcgPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  late RecupRealTimeData recupECGData;
  List<FlSpot> emgDataPoints = [];
  double timeCounter = 0;

  @override
  void initState() {
    super.initState();

    recupECGData = RecupRealTimeData(field: 'ECG');
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

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
      drawer: NavBar(),
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
                  'ECG',
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
                'lib/images/ecg1.png',
                width: 120,
                height: 120,
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
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: recupECGData.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data?.data() == null) {
          return const Center(child: Text("No ECG data available"));
        }
        var data = snapshot.data!.data()!;
        var ecgValue = double.tryParse(data['ECG'].toString()) ?? 0.0;

        if (emgDataPoints.length > 300) {
          emgDataPoints.removeAt(0);
        }
        emgDataPoints.add(FlSpot(timeCounter++, ecgValue));

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: emgDataPoints,
                  isCurved: true,
                  color: const Color.fromARGB(255, 255, 52, 37),
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        );
      },
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
              _buildButton('Upload', Colors.blue, () {}),
              _buildButton('Archive', Colors.blue, () {}),
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
