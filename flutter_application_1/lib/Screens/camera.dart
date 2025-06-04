// import 'package:flutter/material.dart';
// class CameraSereen extends StatefulWidget {
//   const CameraSereen({super.key});

//   @override
//   State<CameraSereen> createState() => _CameraSereenState();
// }

// class _CameraSereenState extends State<CameraSereen> {
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//       appBar: AppBar(
//         title: Text("Drowning Detector"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             // Camera preview placeholder
//              SizedBox(height: 30),
//             Container(
//               height: 100,
//               margin: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black),
//               ),
//               child: Center(child: Text("Camera View")),
//             ),
//              Text("Drowning or safe", style: TextStyle(
//                         color:Colors.redAccent,
//                         fontSize: 16))
            
//             // Drowning Detector Button
//           ],
//         ),
//       ),
//     );
//   }
// }
//2
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CameraSereen extends StatefulWidget {
  const CameraSereen({super.key});

  @override
  State<CameraSereen> createState() => _CameraSereenState();
}

class _CameraSereenState extends State<CameraSereen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      'https://res.cloudinary.com/dulqbncjw/video/upload/v1748718303/drowning_albitk.mp4', // ← استبدله بالرابط الخاص بك
    )
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
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
      appBar: AppBar(
        title: Text("Drowning Detector"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              height: 200,
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
            Text(
              "Drowning or safe",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
