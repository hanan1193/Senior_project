import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Screens/welcome_page.dart';
import 'package:flutter_application_1/widget/forgot_pass.dart';
import 'package:flutter_application_1/widget/navigation_bar.dart';
import 'package:flutter_application_1/widget/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widget/Button.dart';
import '../Widget/text_field.dart';
import '../services/authentication.dart';
// import 'package:flutter_application_1/Screens/camera.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isChecked = false; // Remember Me checkbox state

  @override
  void initState() {
    super.initState();
    loadUserCredentials();
  }

  // 🗂️ Load saved credentials
  void loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('email') ?? '';
    passwordController.text = prefs.getString('password') ?? '';
    isChecked = prefs.getBool('rememberMe') ?? false;

    setState(() {});
  }

  // ✅ Save credentials if Remember Me is checked
  void saveUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isChecked) {
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('rememberMe', false);
    }
  }

  // 🔑 Sign-In Function
  void signInUser() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthMethod().signInUser(
      email: emailController.text,
      password: passwordController.text,
    );
     if (!mounted) return; 

    if (res == "success") {
      saveUserCredentials(); // Save credentials on successful sign-in

      // Get user ID
      String? userId = AuthMethod().getUserId();
      if (userId != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Navigation_Bar(),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, "Failed to get user ID");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res); // Display error message
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:  Image.asset(
                        'assets/f3.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    
                  ),
                ),
                Column(
                  children: [  
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(25),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Sign in to continue',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextFieldInput(
                            textEditingController: emailController,
                            hintText: "Email",
                          ),
                          TextFieldInput(
                            textEditingController: passwordController,
                            hintText: "Password",
                            isPass: true,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Remember Me',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const ForgotPassword(),
                            ],
                          ),
                          SizedBox(height: 15),
                          MyButtons(onTap:  signInUser, text: "Sign in"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

