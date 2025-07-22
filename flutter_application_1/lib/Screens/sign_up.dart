import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/sign_in.dart';
import 'package:flutter_application_1/widget/snackbar.dart';
import '../Widget/Button.dart';
import '../widget/text_field.dart';
import '../services/authentication.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Text controllers for the input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  // Clean up controllers when the widget is disposed
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void signupUser() async {
    // signup user using our authmethod
    String res = await AuthMethod().signupUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phone: phoneController.text);
    // Check if the widget is still mounted before performing any UI-related actions.
    // This prevents errors if the widget was disposed while waiting for async tasks.
    if (!mounted) return;
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      //navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    } else {
      // show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extends the body behind the AppBar for a full-screen image effect
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            // Background image for the whole screen
            image: DecorationImage(
              image: AssetImage('assets/f2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              // Top image shown above the white container
              const Image(
                image: AssetImage('assets/f2.jpg'),
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      color: Colors.black26,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create new Account',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextFieldInput(
                      textEditingController: nameController,
                      hintText: "Name",
                    ),
                    TextFieldInput(
                      textEditingController: emailController,
                      hintText: "Email",
                    ),
                    TextFieldInput(
                      textEditingController: phoneController,
                      hintText: "Phone",
                    ),
                    TextFieldInput(
                      textEditingController: passwordController,
                      hintText: "Password",
                      isPass: true,
                    ),
                    const SizedBox(height: 8.5),
                    MyButtons(
                      onTap: () {
                        signupUser();
                      },
                      text: "Sign up",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
