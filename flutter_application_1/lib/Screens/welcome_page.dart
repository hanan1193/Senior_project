import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/sign_in.dart';
import 'package:flutter_application_1/Screens/sign_up.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                const Spacer(
                    flex: 1), //  Adds flexible vertical space at the top
                SizedBox(height: constraints.maxHeight * 0.05), // مسافة علوية
                Text(
                  'Welcome to',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                SizedBox(height: 8),
                Text(
                  'AquaGuard',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Stay Alert, to Keep People Safe.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 30),
                    backgroundColor: Colors.blue.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'Get started',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        );
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 136, 222, 243),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(), // يدفع الصورة للأسفل
                // Bottom image with rounded top corners
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Image.asset(
                    'assets/f1.jpeg',
                    width: double.infinity,
                    height: constraints.maxHeight * 0.4, // ياخد 30% من الشاشة
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
