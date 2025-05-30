import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/sign_in.dart';
// import 'package:flutter_application_1/widget/navigation_bar.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }
   void signupUser() async {
    // set is loading to true.
    setState(() {
      isLoading = true;
    });
    // signup user using our authmethod
    String res = await AuthMethod().signupUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phone: phoneController.text);
        if (!mounted) return;
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      //navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/f2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/f2.jpg'),
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
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
                      onTap: (){
                        //  Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (context) =>  Navigation_Bar(),
                        //     ),
                        //   );
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


