// import 'package:flutter/material.dart';

// class ClockScreen extends StatefulWidget {
//   const ClockScreen({super.key});

//   @override
//   State<ClockScreen> createState() => _ClockScreenState();
// }

// class _ClockScreenState extends State<ClockScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(title: Text("Health Monitor"),centerTitle: true,),
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("assets/f1.jpeg"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),

//           Positioned(
//             top: 50,
//             right: 20,
//             child: Card(
//               elevation: 6,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                      Text("ID:100002", style: TextStyle(fontSize: 16)),
//                     Text("Heart Rate: 80 BPM", style: TextStyle(fontSize: 16)),
//                     Text("SPO2: 98%", style: TextStyle(fontSize: 16)),
//                     Text("Acceleration: Normal", style: TextStyle(fontSize: 16)),
//                      Text("Drowning or safe", style: TextStyle(
//                       color:Colors.redAccent,
//                       fontSize: 16)),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/io.dart';
// import 'dart:convert';

// void main() {
//   runApp(const DrowningDetectorApp());
// }

// class DrowningDetectorApp extends StatelessWidget {
//   const DrowningDetectorApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Drowning Detector',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const DrowningDetectorHomePage(),
//     );
//   }
// }

// class DrowningDetectorHomePage extends StatefulWidget {
//   const DrowningDetectorHomePage({super.key});

//   @override
//   _DrowningDetectorHomePageState createState() =>
//       _DrowningDetectorHomePageState();
// }

// class _DrowningDetectorHomePageState extends State<DrowningDetectorHomePage> {
//   late IOWebSocketChannel channel;
//   String bpm = '0';
//   String spo2 = '0';
//   String accel = '0';
//   String status = 'Connecting...';
//   bool isConnected = false;

//   @override
//   void initState() {
//     super.initState();
//     // Replace with your ESP32's IP address
//     channel = IOWebSocketChannel.connect('ws://172.17.53.33:81');
//     channel.stream.listen(
//       (message) {
//         final data = jsonDecode(message);
//         setState(() {
//           bpm = data['bpm'].toString();
//           spo2 = data['spo2'].toString();
//           accel = data['accel'].toString();
//           status = data['status'];
//           isConnected = true;
//         });
//       },
//       onError: (error) {
//         setState(() {
//           status = 'Error: $error';
//           isConnected = false;
//         });
//       },
//       onDone: () {
//         setState(() {
//           status = 'Disconnected';
//           isConnected = false;
//         });
//       },
//     );
//   }

//   @override
//   void dispose() {
//     channel.sink.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Drowning Detector'),
//         backgroundColor: isConnected ? Colors.green : Colors.red,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Card(
//               child: ListTile(
//                 title: const Text('Heart Rate'),
//                 subtitle:
//                     Text('$bpm BPM', style: const TextStyle(fontSize: 20)),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Card(
//               child: ListTile(
//                 title: const Text('SpO2'),
//                 subtitle: Text('$spo2 %', style: const TextStyle(fontSize: 20)),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Card(
//               child: ListTile(
//                 title: const Text('Acceleration'),
//                 subtitle:
//                     Text('$accel m/s²', style: const TextStyle(fontSize: 20)),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Card(
//               child: ListTile(
//                 title: const Text('Status'),
//                 subtitle: Text(
//                   status,
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: status == 'DROWNING'
//                         ? Colors.red
//                         : status == 'SAFE'
//                             ? Colors.green
//                             : Colors.orange,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//3-
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(const SensorMonitorApp());
// }

// class SensorMonitorApp extends StatelessWidget {
//   const SensorMonitorApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sensor Monitor',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const SensorMonitorPage(),
//     );
//   }
// }

// class SensorMonitorPage extends StatefulWidget {
//   const SensorMonitorPage({super.key});

//   @override
//   _SensorMonitorPageState createState() => _SensorMonitorPageState();
// }

// class _SensorMonitorPageState extends State<SensorMonitorPage> {
//   String heartRate = '0';
//   String spo2 = '0';
//   String acceleration = '0';
//   String status = 'Unknown';
//   bool isLoading = true;
//   String errorMessage = '';
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     fetchSensorData();
//     // Periodically fetch data every 5 seconds
//     _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       fetchSensorData();
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   Future<void> fetchSensorData() async {
//     const String url = 'http://192.168.4.1'; // ESP32 AP IP address
//     try {
//       final response =
//           await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
//       if (response.statusCode == 200) {
//         // Parse JSON response
//         final data = jsonDecode(response.body);
//         setState(() {
//           isLoading = false;
//           errorMessage = '';
//           heartRate = data['heartRate'].toString();
//           spo2 = data['spo2'].toString();
//           acceleration = data['acceleration'].toString();
//           status = data['status'];
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//           errorMessage = 'Failed to load data: HTTP ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sensor Monitor'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: isLoading
//             ? const CircularProgressIndicator()
//             : errorMessage.isNotEmpty
//                 ? Text(
//                     errorMessage,
//                     style: const TextStyle(color: Colors.red, fontSize: 18),
//                     textAlign: TextAlign.center,
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SensorDataCard(
//                           label: 'Heart Rate',
//                           value: '$heartRate BPM',
//                           icon: Icons.favorite,
//                           color: Colors.red,
//                         ),
//                         const SizedBox(height: 16),
//                         SensorDataCard(
//                           label: 'SpO2',
//                           value: '$spo2%',
//                           icon: Icons.opacity,
//                           color: Colors.blue,
//                         ),
//                         const SizedBox(height: 16),
//                         SensorDataCard(
//                           label: 'Acceleration',
//                           value: '$acceleration m/s²',
//                           icon: Icons.directions_run,
//                           color: Colors.green,
//                         ),
//                         const SizedBox(height: 16),
//                         SensorDataCard(
//                           label: 'Status',
//                           value: status,
//                           icon: Icons.warning,
//                           color:
//                               status == 'DROWNING' ? Colors.red : Colors.green,
//                         ),
//                       ],
//                     ),
//                   ),
//       ),
//     );
//   }
// }

// class SensorDataCard extends StatelessWidget {
//   final String label;
//   final String value;
//   final IconData icon;
//   final Color color;

//   const SensorDataCard({
//     super.key,
//     required this.label,
//     required this.value,
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Icon(icon, color: color, size: 40),
//             const SizedBox(width: 16),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   value,
//                   style: TextStyle(fontSize: 16, color: color),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//4-
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // For formatting date/time

class SwimmerMonitoringPage extends StatefulWidget {
  @override
  _SwimmerMonitoringPageState createState() => _SwimmerMonitoringPageState();
}

class _SwimmerMonitoringPageState extends State<SwimmerMonitoringPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref('Sensor');
  String heartRate = '--';
  String bloodOxygen = '--';
  String acceleration = '--';
  String status = 'SAFE';
  String lastUpdated = '--';

  @override
  void initState() {
    super.initState();
    _activateListeners();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swimmer Monitoring System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: status == 'SAFE' ? Colors.green[100] : Colors.red[100],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'STATUS: $status',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.grey[200],
              child: ListTile(
                title: Text('Heart Rate'),
                subtitle: Text(heartRate),
                trailing: Text('BPM'),
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.grey[200],
              child: ListTile(
                title: Text('Blood Oxygen'),
                subtitle: Text(bloodOxygen),
                trailing: Text('% SpO2'),
              ),
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.grey[200],
              child: ListTile(
                title: Text('Acceleration'),
                subtitle: Text(acceleration),
                trailing: Text('m/s²'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add reset alert logic here
              },
              child: Text('Reset Alert'),
            ),
            SizedBox(height: 10),
            Text('Last updated: $lastUpdated', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
