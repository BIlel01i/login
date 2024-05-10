import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawhida_login/recupdata.dart';
import 'package:tawhida_login/side_Nav/navigation.dart'; // Adjust according to your actual import path

class EcgPage extends StatefulWidget {
  final String userId;
  const EcgPage({Key? key, required this.userId}) : super(key: key);

  @override
  _EcgPageState createState() => _EcgPageState();
}

class _EcgPageState extends State<EcgPage> with SingleTickerProviderStateMixin {
  late RecupRealTimeData recupECGeData;
  late AnimationController _controller;
  late Animation<int> _animation;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> recupEcgData;

  @override
  void initState() {
    super.initState();
    recupECGeData = RecupRealTimeData(userId: widget.userId, field: 'ECG');
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
      drawer: const NavBar(),
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
      stream: recupEcgData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var ecgDataString = snapshot.data!.data()!['ecg'] as String;
          List<String> ecgDataList = ecgDataString.split(',');
          List<FlSpot> spots = [];
          DateTime startTime =
              DateTime.now().subtract(Duration(minutes: ecgDataList.length));

          for (var i = 0; i < ecgDataList.length; i++) {
            final ecgValue = double.parse(ecgDataList[i]);
            final time = startTime.add(Duration(minutes: i));
            spots.add(FlSpot(time.millisecondsSinceEpoch.toDouble(), ecgValue));
          }

          saveDataLocally(ecgDataString);

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/bcgECG.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
                        getTitlesWidget: (value, meta) {
                          final DateTime date =
                              DateTime.fromMillisecondsSinceEpoch(
                                  value.toInt());
                          return SideTitleWidget(
                            child: Text(DateFormat('HH:mm').format(date),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10)),
                            angle: -45,
                            axisSide: AxisSide.bottom,
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void saveDataLocally(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ECGData', data);
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
