
import 'package:flutter/material.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Health Monitor"),centerTitle: true,),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/f1.jpeg"), 
                  fit: BoxFit.cover, 
                ),
              ),
            ),
          ),
          
          Positioned(
            top: 50,
            right: 20,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text("ID:100002", style: TextStyle(fontSize: 16)),
                    Text("Heart Rate: 80 BPM", style: TextStyle(fontSize: 16)),
                    Text("SPO2: 98%", style: TextStyle(fontSize: 16)),
                    Text("Acceleration: Normal", style: TextStyle(fontSize: 16)),
                     Text("Drowning or safe", style: TextStyle(
                      color:Colors.redAccent,
                      fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

