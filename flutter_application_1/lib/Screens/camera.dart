import 'package:flutter/material.dart';
class CameraSereen extends StatefulWidget {
  const CameraSereen({super.key});

  @override
  State<CameraSereen> createState() => _CameraSereenState();
}

class _CameraSereenState extends State<CameraSereen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text("Drowning Detector"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            // Camera preview placeholder
             SizedBox(height: 30),
            Container(
              height: 100,
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Center(child: Text("Camera View")),
            ),
             Text("Drowning or safe", style: TextStyle(
                        color:Colors.redAccent,
                        fontSize: 16))
            
            // Drowning Detector Button
          ],
        ),
      ),
    );
  }
}