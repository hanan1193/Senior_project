import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/welcome_page.dart';
import 'package:flutter_application_1/firebase_options.dart';

void main() async {
  // Ensures Flutter bindings are initialized before calling any async code
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initializes Firebase with platform-specific options
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // If Firebase is already initialized, catch the error and print a message
    print("Firebase already initialized: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WelcomePage(),
      ),
    );
  }
}
