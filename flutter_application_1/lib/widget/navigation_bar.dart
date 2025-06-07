// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Screens/camera.dart';
// import 'package:flutter_application_1/Screens/clock.dart';

// class Navigation_Bar extends StatelessWidget {
//   const Navigation_Bar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//           onTap: (index) {
//             switch (index) {
//               case 0:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ClockScreen()),
//                 );
//                 break;
//               case 1:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => CameraSereen()),
//                 );
//                 break;
//             }
//           },
//           items:[
//             BottomNavigationBarItem(icon:Icon(Icons.access_time_outlined,color: Colors.black,),label: ''),
//             BottomNavigationBarItem(icon:Icon(Icons.camera_alt_outlined,color: Colors.black),label: ''),
//           ],
//           backgroundColor:const Color.fromARGB(255, 136, 222, 243),
//           iconSize: 40,
//         );
//   }
// }
//2-
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/camera.dart';
import 'package:flutter_application_1/Screens/clock.dart';

class Navigation_Bar extends StatelessWidget {
  const Navigation_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 136, 222, 243),
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.access_time_outlined,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SwimmerMonitoringPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraSereen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text('')),
    );
  }
}
