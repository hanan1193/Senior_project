//
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class swimmerMonitoringPage extends StatefulWidget {
  @override
  _swimmerMonitoringPageState createState() => _swimmerMonitoringPageState();
}

class _swimmerMonitoringPageState extends State<swimmerMonitoringPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref('Sensor');

  String heartRate = '--';
  String bloodOxygen = '--';
  String acceleration = '--';
  String status = 'SAFE';

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _activateListeners() {
    _database.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          heartRate = data['bpm']?.toString() ?? '--';
          bloodOxygen = data['spo2']?.toString() ?? '--';
          acceleration = data['accel']?.toString() ?? '--';
          status = data['status']?.toString() ?? 'SAFE';
        });
      }
    });
  }

  Widget _buildSimpleCard(
      String title, String value, String unit, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(unit, style: TextStyle(color: Colors.grey[600]))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Swimmer Monitoring',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Animate(
              effects: status != 'SAFE'
                  ? [
                      ShimmerEffect(duration: 800.ms),
                      ShakeEffect(duration: 500.ms)
                    ]
                  : [],
              child: Container(
                height: 70,
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: status == 'SAFE' ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'STATUS: $status',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          status == 'SAFE' ? Colors.blue[300] : Colors.red[900],
                    ),
                  ),
                ),
              ),
            ),
            _buildSimpleCard(
                'Heart Rate', heartRate, 'BPM', Colors.red, Icons.favorite),
            _buildSimpleCard('Blood Oxygen', bloodOxygen, '% SpO2', Colors.blue,
                Icons.bloodtype),
            _buildSimpleCard('Acceleration', acceleration, 'm/s²',
                Colors.deepPurple, Icons.speed),
          ],
        ),
      ),
    );
  }
}
